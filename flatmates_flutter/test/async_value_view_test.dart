import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_flutter/core/theme/app_theme.dart';
import 'package:flatmates_flutter/core/widgets/async_value_view.dart';
import 'package:flatmates_flutter/core/widgets/banners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('a failed load: a small centered card, under the header', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: FlatmatesTheme.light(),
        home: Scaffold(
          body: AsyncValueView<int>(
            value: AsyncError(
              const ServerpodClientNetworkException('offline'),
              StackTrace.empty,
            ),
            onRetry: () {},
            header: const Text('Back'),
            data: (_) => const SizedBox(),
          ),
        ),
      ),
    );
    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Couldn\'t reach the server. Try again.'), findsOneWidget);
    final card = tester.getSize(find.byType(ErrorCard));
    expect(card.height, lessThan(200));
    expect(card.width, lessThanOrEqualTo(420));
  });
}
