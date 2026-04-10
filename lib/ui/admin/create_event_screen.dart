import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../providers/event_provider.dart';
import '../../providers/society_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/event.dart';
import '../../models/society.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/widgets/skeleton_loader.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  /// Pass an existing event to enter edit mode.
  final Event? existingEvent;

  const CreateEventScreen({super.key, this.existingEvent});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  // ── Text controllers ────────────────────────────────────────────────────────
  late final TextEditingController _titleCtrl;
  late final TextEditingController _aboutCtrl;
  late final TextEditingController _bannerCtrl;
  late final TextEditingController _internalPriceCtrl;
  late final TextEditingController _externalPriceCtrl;

  // ── State ────────────────────────────────────────────────────────────────────
  String _visibility = 'open';
  String? _selectedSocietyId;
  bool _isFree = true;
  List<_StageEntry> _stages = [];
  List<TextEditingController> _ruleControllers = [];
  List<TextEditingController> _prizeControllers = [];
  XFile? _pickedImage;

  bool get _isEditMode => widget.existingEvent != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existingEvent;
    _titleCtrl = TextEditingController(text: e?.title ?? '');
    _aboutCtrl = TextEditingController(text: e?.details.about ?? '');
    _bannerCtrl = TextEditingController(text: e?.details.bannerUrl ?? '');
    _internalPriceCtrl = TextEditingController(
      text: e?.pricing.internalPrice.toString() ?? '0',
    );
    _externalPriceCtrl = TextEditingController(
      text: e?.pricing.externalPrice.toString() ?? '0',
    );
    _visibility = e?.visibility ?? 'open';
    _selectedSocietyId = e?.societyId;
    _isFree = e?.pricing.isFree ?? true;

    _stages = e?.details.stages
            .map(
              (s) => _StageEntry(
                titleCtrl: TextEditingController(text: s.title),
                dateCtrl: TextEditingController(text: s.date),
                descCtrl: TextEditingController(text: s.desc),
              ),
            )
            .toList() ??
        [];

    _ruleControllers = (e?.details.rules ?? [])
        .map((r) => TextEditingController(text: r))
        .toList();
    _prizeControllers = (e?.details.prizes ?? [])
        .map((p) => TextEditingController(text: p))
        .toList();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _aboutCtrl.dispose();
    _bannerCtrl.dispose();
    _internalPriceCtrl.dispose();
    _externalPriceCtrl.dispose();
    for (final s in _stages) {
      s.titleCtrl.dispose();
      s.dateCtrl.dispose();
      s.descCtrl.dispose();
    }
    for (final c in _ruleControllers) {
      c.dispose();
    }
    for (final c in _prizeControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSocietyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a society.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      String bannerUrl = _bannerCtrl.text.trim();

      // Handle Image Upload if a new file was picked
      if (_pickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('events')
            .child('${DateTime.now().millisecondsSinceEpoch}_${_pickedImage!.name}');
        
        if (kIsWeb) {
          final bytes = await _pickedImage!.readAsBytes();
          await ref.putData(bytes);
        } else {
          await ref.putFile(File(_pickedImage!.path));
        }
        bannerUrl = await ref.getDownloadURL();
      }
      // Lookup default society name from the stream
      final societies = ref.read(societyListProvider).asData?.value ?? [];
      final society = societies.cast<Society?>().firstWhere(
        (s) => s?.societyId == _selectedSocietyId,
        orElse: () => null,
      );

      final event = Event(
        eventId: widget.existingEvent?.eventId ?? '',
        societyId: _selectedSocietyId!,
        societyName: society?.name ?? '',
        societyLogo: society?.logoUrl ?? '',
        title: _titleCtrl.text.trim(),
        visibility: _visibility,
        pricing: EventPricing(
          isFree: _isFree,
          internalPrice: _isFree ? 0 : int.tryParse(_internalPriceCtrl.text) ?? 0,
          externalPrice: _isFree ? 0 : int.tryParse(_externalPriceCtrl.text) ?? 0,
        ),
        details: EventDetails(
          bannerUrl: bannerUrl,
          about: _aboutCtrl.text.trim(),
          stages: _stages
              .map(
                (s) => EventStage(
                  title: s.titleCtrl.text.trim(),
                  date: s.dateCtrl.text.trim(),
                  desc: s.descCtrl.text.trim(),
                ),
              )
              .toList(),
          rules: _ruleControllers
              .map((c) => c.text.trim())
              .where((t) => t.isNotEmpty)
              .toList(),
          prizes: _prizeControllers
              .map((c) => c.text.trim())
              .where((t) => t.isNotEmpty)
              .toList(),
        ),
      );

      if (_isEditMode) {
        await ref
            .read(eventControllerProvider.notifier)
            .updateEvent(event);
      } else {
        await ref
            .read(eventControllerProvider.notifier)
            .createEvent(event);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditMode
                  ? 'Event updated successfully!'
                  : 'Event created! It is now live.',
            ),
            backgroundColor: AppTheme.secondary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(24),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 1200,
    );
    if (image != null) {
      setState(() => _pickedImage = image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final societiesAsync = ref.watch(societyListProvider);
    final user = ref.watch(authUserProvider);

    // Filter societies to only ones the user can create events for
    final List<Society> allowedSocieties = societiesAsync.asData?.value
            .where(
              (s) =>
                  (user?.isGlobalAdmin ?? false) ||
                  user?.societyRoles[s.societyId] == 'president',
            )
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode ? 'Edit Event' : 'Create Event',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: AppTheme.surfaceContainerLowest,
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    _isEditMode ? 'UPDATE' : 'PUBLISH',
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // ── Core Info ─────────────────────────────────────────────────────
            SectionHeader(
              title: 'Event Details',
              subtitle: 'Basic information about your event',
            ),
            AppTextField(
              label: 'Event Title',
              hint: 'e.g. Hack-IT 2026',
              controller: _titleCtrl,
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'About',
              hint: 'Describe what makes this event special...',
              controller: _aboutCtrl,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'Banner Image URL',
                    hint: 'https://your-image-url.png',
                    controller: _bannerCtrl,
                    keyboardType: TextInputType.url,
                  ),
                ),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: IconButton.filledTonal(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.add_a_photo_rounded),
                    tooltip: 'Upload Image',
                  ),
                ),
              ],
            ),
            if (_pickedImage != null || _bannerCtrl.text.isNotEmpty) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _pickedImage != null
                    ? (kIsWeb
                        ? Image.network(_pickedImage!.path, height: 160, width: double.infinity, fit: BoxFit.cover)
                        : Image.file(File(_pickedImage!.path), height: 160, width: double.infinity, fit: BoxFit.cover))
                    : CachedNetworkImage(
                        imageUrl: _bannerCtrl.text,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (ctx, url) => const SkeletonBox(
                          height: 160,
                          borderRadius: 0,
                        ),
                        errorWidget: (ctx, url, err) => Container(
                          height: 160,
                          color: AppTheme.surfaceContainerHighest,
                          child: const Icon(
                            Icons.broken_image_outlined,
                            size: 48,
                            color: AppTheme.outlineVariant,
                          ),
                        ),
                      ),
              ),
              if (_pickedImage != null)
                TextButton.icon(
                  onPressed: () => setState(() => _pickedImage = null),
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text('Remove picked image'),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
            ],

            const SizedBox(height: 32),

            // ── Society & Visibility ──────────────────────────────────────────
            const SectionHeader(
              title: 'Scope',
              subtitle: 'Who organizes this and who can see it',
            ),

            // Society Picker
            societiesAsync.when(
              data: (societies) => allowedSocieties.isEmpty
                  ? const Text(
                      'No societies assigned to you. Ask an admin.',
                      style: TextStyle(color: AppTheme.outlineVariant),
                    )
                  : DropdownButtonFormField<String>(
                      initialValue: _selectedSocietyId,
                      decoration: const InputDecoration(
                        labelText: 'Organizing Society',
                      ),
                      items: allowedSocieties
                          .map(
                            (s) => DropdownMenuItem(
                              value: s.societyId,
                              child: Row(
                                children: [
                                  if (s.logoUrl.isNotEmpty)
                                    CircleAvatar(
                                      radius: 14,
                                      backgroundImage:
                                          CachedNetworkImageProvider(s.logoUrl),
                                    )
                                  else
                                    const CircleAvatar(
                                      radius: 14,
                                      backgroundColor: AppTheme.primaryContainer,
                                      child: Icon(
                                        Icons.group_work,
                                        size: 14,
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                  const SizedBox(width: 10),
                                  Text(s.name),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _selectedSocietyId = v),
                      validator: (v) =>
                          v == null ? 'Select a society' : null,
                    ),
              loading: () => const SkeletonBox(height: 56, borderRadius: 12),
              error: (err, stack) =>
                  const Text('Could not load societies.'),
            ),

            const SizedBox(height: 16),

            // Visibility
            DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: _visibility,
              decoration: const InputDecoration(labelText: 'Visibility'),
              items: const [
                DropdownMenuItem(
                  value: 'open',
                  child: Text('🌐 Open — Anyone can see & register'),
                ),
                DropdownMenuItem(
                  value: 'college',
                  child: Text('🎓 College-only — college email required'),
                ),
                DropdownMenuItem(
                  value: 'society',
                  child: Text('🔒 Society-only — members of this society'),
                ),
              ],
              onChanged: (v) => setState(() => _visibility = v ?? 'open'),
            ),

            const SizedBox(height: 32),

            // ── Pricing ───────────────────────────────────────────────────────
            const SectionHeader(
              title: 'Pricing',
              subtitle: 'College members may get a discounted rate',
            ),
            SwitchListTile(
              value: _isFree,
              onChanged: (v) => setState(() => _isFree = v),
              title: const Text('Free Event'),
              subtitle: const Text('No payment required to register'),
              thumbColor: WidgetStateProperty.resolveWith<Color?>(
                (states) => states.contains(WidgetState.selected) ? AppTheme.primary : null,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            if (!_isFree) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'Internal Price (₹)',
                      hint: '100',
                      controller: _internalPriceCtrl,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextField(
                      label: 'External Price (₹)',
                      hint: '250',
                      controller: _externalPriceCtrl,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 32),

            // ── Stages ────────────────────────────────────────────────────────
            SectionHeader(
              title: 'Timeline Stages',
              subtitle: 'Rounds, workshops, and deadlines',
              trailing: AppButton(
                text: 'Add Stage',
                isSecondary: true,
                expand: false,
                icon: Icons.add_rounded,
                onPressed: () => setState(
                  () => _stages.add(
                    _StageEntry(
                      titleCtrl: TextEditingController(),
                      dateCtrl: TextEditingController(),
                      descCtrl: TextEditingController(),
                    ),
                  ),
                ),
              ),
            ),
            ..._stages.asMap().entries.map((entry) {
              final i = entry.key;
              final s = entry.value;
              return _StageCard(
                index: i,
                stage: s,
                onRemove: () => setState(() => _stages.removeAt(i)),
              );
            }),

            const SizedBox(height: 32),

            // ── Rules ────────────────────────────────────────────────────────
            SectionHeader(
              title: 'Rules',
              subtitle: 'Define participation requirements',
              trailing: AppButton(
                text: 'Add Rule',
                isSecondary: true,
                expand: false,
                icon: Icons.add_rounded,
                onPressed: () => setState(
                  () => _ruleControllers.add(TextEditingController()),
                ),
              ),
            ),
            ..._ruleControllers.asMap().entries.map((entry) {
              final i = entry.key;
              final c = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Rule ${i + 1}',
                        hint: 'e.g. Bring your own laptop',
                        controller: c,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                      onPressed: () => setState(
                        () => _ruleControllers.removeAt(i),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 32),

            // ── Prizes ───────────────────────────────────────────────────────
            SectionHeader(
              title: 'Prizes',
              subtitle: 'Recognition and rewards',
              trailing: AppButton(
                text: 'Add Prize',
                isSecondary: true,
                expand: false,
                icon: Icons.add_rounded,
                onPressed: () => setState(
                  () => _prizeControllers.add(TextEditingController()),
                ),
              ),
            ),
            ..._prizeControllers.asMap().entries.map((entry) {
              final i = entry.key;
              final c = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Prize ${i + 1}',
                        hint: 'e.g. 1st: ₹5000 Cash',
                        controller: c,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                      onPressed: () => setState(
                        () => _prizeControllers.removeAt(i),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 48),

            AppButton(
              text: _isEditMode ? 'Update Event' : 'Publish Event',
              isLoading: _isSubmitting,
              onPressed: _isSubmitting ? null : _submit,
              icon: Icons.rocket_launch_rounded,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StageEntry {
  final TextEditingController titleCtrl;
  final TextEditingController dateCtrl;
  final TextEditingController descCtrl;
  _StageEntry({
    required this.titleCtrl,
    required this.dateCtrl,
    required this.descCtrl,
  });
}

class _StageCard extends StatelessWidget {
  final int index;
  final _StageEntry stage;
  final VoidCallback onRemove;

  const _StageCard({
    required this.index,
    required this.stage,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Stage ${index + 1}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                iconSize: 18,
                color: Colors.red,
                onPressed: onRemove,
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Stage Title',
            hint: 'Round 1: Idea Pitch',
            controller: stage.titleCtrl,
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Date',
            hint: '15 Apr 2026',
            controller: stage.dateCtrl,
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Description',
            hint: 'Online / In-person',
            controller: stage.descCtrl,
          ),
        ],
      ),
    );
  }
}
