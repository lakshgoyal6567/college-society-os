import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/analytics/app_analytics.dart';
import '../theme/app_theme.dart';
import 'events/event_feed_screen.dart';
import 'admin/admin_dashboard.dart';
import 'admin/societies_screen.dart';
import 'tickets/ticket_screen.dart';
import 'admin/scanner_screen.dart';
import 'profile/profile_screen.dart';
import '../providers/auth_provider.dart';

class NavItem {
  final IconData icon;
  final String label;
  final bool requiresAdmin;
  const NavItem(this.icon, this.label, [this.requiresAdmin = false]);
}

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _currentIndex = 0;

  // IndexedStack keeps all screens alive — zero rebuild cost on tab switch.
  static const List<Widget> _screens = [
    EventFeedScreen(),
    TicketScreen(),
    ProfileScreen(),
    SocietiesScreen(),
    ScannerScreen(),
    AdminDashboardScreen(),
  ];

  final List<NavItem> _navItems = const [
    NavItem(Icons.event, 'Events'),
    NavItem(Icons.qr_code, 'Tickets'),
    NavItem(Icons.person_outline, 'Profile'),
    NavItem(Icons.group_work_outlined, 'Societies'),
    NavItem(Icons.qr_code_scanner, 'Scan', true),
    NavItem(Icons.admin_panel_settings, 'Admin', true),
  ];

  void _onTabTapped(int index, bool isAdmin) {
    if (_navItems[index].requiresAdmin && !isAdmin) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Access Denied. Admins Only.')),
        );
      }
      return;
    }
    setState(() => _currentIndex = index);
    AppAnalytics.logScreenView(_navItems[index].label);

    // Auto-close drawer on narrow screens (Mobile Web)
    if (kIsWeb && MediaQuery.of(context).size.width < 800) {
      if (Scaffold.of(context).isDrawerOpen) {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildSidebar(BuildContext context, bool isAdmin) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 16,
            offset: const Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'TIT&S',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (ctx, i) {
                final item = _navItems[i];
                if (item.requiresAdmin && !isAdmin) {
                  return const SizedBox.shrink();
                }

                final isSelected = _currentIndex == i;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: InkWell(
                    onTap: () => _onTabTapped(i, isAdmin),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryContainer
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: isSelected
                                ? AppTheme.primary
                                : AppTheme.onSurfaceVariant,
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            item.label,
                            style: TextStyle(
                              color: isSelected
                                  ? AppTheme.primary
                                  : AppTheme.onSurfaceVariant,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider);
    final isAdmin = user?.isGlobalAdmin ?? false;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 800;

        if (isWide) {
          // Web / Desktop wide layout (Sidebar + IndexedStack)
          return Scaffold(
            body: Row(
              children: [
                _buildSidebar(context, isAdmin),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _screens,
                  ),
                ),
              ],
            ),
          );
        }

        // Web narrow layout (Hamburger + Drawer + IndexedStack)
        if (kIsWeb) {
          return Scaffold(
            drawer: Drawer(child: _buildSidebar(context, isAdmin)),
            body: Stack(
              children: [
                IndexedStack(
                  index: _currentIndex,
                  children: _screens,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                    child: Builder(
                      builder: (c) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black87,
                          size: 28,
                        ),
                        onPressed: () => Scaffold.of(c).openDrawer(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Mobile App layout (Bottom Navigation Bar)
        final navItemsFiltered = _navItems
            .asMap()
            .entries
            .where((e) => !e.value.requiresAdmin || isAdmin)
            .toList();

        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      height:
                          kBottomNavigationBarHeight +
                          MediaQuery.of(context).padding.bottom,
                      color: AppTheme.surface.withAlpha(204),
                    ),
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  currentIndex:
                      navItemsFiltered.indexWhere(
                            (e) => e.key == _currentIndex,
                          ) ==
                          -1
                      ? 0
                      : navItemsFiltered.indexWhere(
                          (e) => e.key == _currentIndex,
                        ),
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  unselectedItemColor: AppTheme.onSurfaceVariant,
                  selectedItemColor: AppTheme.primary,
                  onTap: (renderedIndex) {
                    final actualIndex = navItemsFiltered[renderedIndex].key;
                    _onTabTapped(actualIndex, isAdmin);
                  },
                  items: navItemsFiltered
                      .map(
                        (e) => BottomNavigationBarItem(
                          icon: Icon(e.value.icon),
                          label: e.value.label,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
