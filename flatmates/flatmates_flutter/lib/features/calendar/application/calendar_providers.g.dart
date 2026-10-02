// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every calendar entry around the month containing [month]: real and
/// planned Turns, Events and Away periods.

@ProviderFor(calendarMonth)
const calendarMonthProvider = CalendarMonthFamily._();

/// Every calendar entry around the month containing [month]: real and
/// planned Turns, Events and Away periods.

final class CalendarMonthProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CalendarEntry>>,
          List<CalendarEntry>,
          FutureOr<List<CalendarEntry>>
        >
    with
        $FutureModifier<List<CalendarEntry>>,
        $FutureProvider<List<CalendarEntry>> {
  /// Every calendar entry around the month containing [month]: real and
  /// planned Turns, Events and Away periods.
  const CalendarMonthProvider._({
    required CalendarMonthFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'calendarMonthProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$calendarMonthHash();

  @override
  String toString() {
    return r'calendarMonthProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CalendarEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CalendarEntry>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return calendarMonth(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CalendarMonthProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$calendarMonthHash() => r'bf48bc6a3b49bcc43735f204c5b79693ab4a299b';

/// Every calendar entry around the month containing [month]: real and
/// planned Turns, Events and Away periods.

final class CalendarMonthFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<CalendarEntry>>, DateTime> {
  const CalendarMonthFamily._()
    : super(
        retry: null,
        name: r'calendarMonthProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Every calendar entry around the month containing [month]: real and
  /// planned Turns, Events and Away periods.

  CalendarMonthProvider call(DateTime month) =>
      CalendarMonthProvider._(argument: month, from: this);

  @override
  String toString() => r'calendarMonthProvider';
}

/// Adding and removing Events.

@ProviderFor(EventsController)
const eventsControllerProvider = EventsControllerProvider._();

/// Adding and removing Events.
final class EventsControllerProvider
    extends $NotifierProvider<EventsController, void> {
  /// Adding and removing Events.
  const EventsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsControllerHash();

  @$internal
  @override
  EventsController create() => EventsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$eventsControllerHash() => r'e72640bce37f9004ac972ec0285d4de38342c8f9';

/// Adding and removing Events.

abstract class _$EventsController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
