// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'society_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Stream of all society_requests — used by the Admin Dashboard.

@ProviderFor(societyRequests)
final societyRequestsProvider = SocietyRequestsProvider._();

/// Stream of all society_requests — used by the Admin Dashboard.

final class SocietyRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SocietyRequest>>,
          List<SocietyRequest>,
          Stream<List<SocietyRequest>>
        >
    with
        $FutureModifier<List<SocietyRequest>>,
        $StreamProvider<List<SocietyRequest>> {
  /// Stream of all society_requests — used by the Admin Dashboard.
  SocietyRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'societyRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$societyRequestsHash();

  @$internal
  @override
  $StreamProviderElement<List<SocietyRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<SocietyRequest>> create(Ref ref) {
    return societyRequests(ref);
  }
}

String _$societyRequestsHash() => r'c4bf385a05c39e3b9da224e10bc3b785a5b23d42';

/// Stream of all active societies — used by the Societies screen and Profile.

@ProviderFor(societyList)
final societyListProvider = SocietyListProvider._();

/// Stream of all active societies — used by the Societies screen and Profile.

final class SocietyListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Society>>,
          List<Society>,
          Stream<List<Society>>
        >
    with $FutureModifier<List<Society>>, $StreamProvider<List<Society>> {
  /// Stream of all active societies — used by the Societies screen and Profile.
  SocietyListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'societyListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$societyListHash();

  @$internal
  @override
  $StreamProviderElement<List<Society>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Society>> create(Ref ref) {
    return societyList(ref);
  }
}

String _$societyListHash() => r'82eff0b24cae182d6cbf28354446535f6994f862';

@ProviderFor(SocietyController)
final societyControllerProvider = SocietyControllerProvider._();

final class SocietyControllerProvider
    extends $NotifierProvider<SocietyController, void> {
  SocietyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'societyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$societyControllerHash();

  @$internal
  @override
  SocietyController create() => SocietyController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$societyControllerHash() => r'5962a41d0e0a7db8a44b58ea4c4fe3b9aeb1e518';

abstract class _$SocietyController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
