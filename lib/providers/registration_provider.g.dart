// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(registrations)
final registrationsProvider = RegistrationsProvider._();

final class RegistrationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Registration>>,
          List<Registration>,
          Stream<List<Registration>>
        >
    with
        $FutureModifier<List<Registration>>,
        $StreamProvider<List<Registration>> {
  RegistrationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registrationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registrationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Registration>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Registration>> create(Ref ref) {
    return registrations(ref);
  }
}

String _$registrationsHash() => r'0fc5724117db3b706b46fd8daf5b37c9955718de';

@ProviderFor(RegistrationController)
final registrationControllerProvider = RegistrationControllerProvider._();

final class RegistrationControllerProvider
    extends $NotifierProvider<RegistrationController, void> {
  RegistrationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registrationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registrationControllerHash();

  @$internal
  @override
  RegistrationController create() => RegistrationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$registrationControllerHash() =>
    r'9f13067c122e8c34b66a7eebbc694a80260bf125';

abstract class _$RegistrationController extends $Notifier<void> {
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
