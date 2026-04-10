// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventList)
final eventListProvider = EventListProvider._();

final class EventListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          Stream<List<Event>>
        >
    with $FutureModifier<List<Event>>, $StreamProvider<List<Event>> {
  EventListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventListHash();

  @$internal
  @override
  $StreamProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Event>> create(Ref ref) {
    return eventList(ref);
  }
}

String _$eventListHash() => r'91dab0617805151ab1efa5fd8fdb41320470f9eb';

@ProviderFor(visibleEvents)
final visibleEventsProvider = VisibleEventsProvider._();

final class VisibleEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          AsyncValue<List<Event>>,
          AsyncValue<List<Event>>
        >
    with $Provider<AsyncValue<List<Event>>> {
  VisibleEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visibleEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visibleEventsHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<Event>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<Event>> create(Ref ref) {
    return visibleEvents(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Event>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Event>>>(value),
    );
  }
}

String _$visibleEventsHash() => r'191b0d61dd2110e3bf9cab008d451def4c679504';

/// CRUD controller for events. Only Global Admins and Presidents can
/// create/update/delete events.

@ProviderFor(EventController)
final eventControllerProvider = EventControllerProvider._();

/// CRUD controller for events. Only Global Admins and Presidents can
/// create/update/delete events.
final class EventControllerProvider
    extends $NotifierProvider<EventController, void> {
  /// CRUD controller for events. Only Global Admins and Presidents can
  /// create/update/delete events.
  EventControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventControllerHash();

  @$internal
  @override
  EventController create() => EventController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$eventControllerHash() => r'9e7e936cc879e71126ebd91b428c8aa32d977ccb';

/// CRUD controller for events. Only Global Admins and Presidents can
/// create/update/delete events.

abstract class _$EventController extends $Notifier<void> {
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
