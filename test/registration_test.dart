import 'package:flutter_test/flutter_test.dart';
import 'package:college_society_os/providers/registration_provider.dart';
import 'package:college_society_os/models/registration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('Registration provider initial state is loading', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final registrations = container.read(registrationsProvider);
    expect(registrations, isA<AsyncValue<List<Registration>>>());
    expect(registrations.isLoading, true);
  });
}
