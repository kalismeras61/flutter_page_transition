import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  group('PageTransition Widget Tests', () {
    testWidgets('creates fade transition correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const Scaffold(key: Key('target')),
                  ),
                ),
                child: const Text('Go'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(FadeTransition), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('target')), findsOneWidget);
    });

    testWidgets('creates slide transition correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const Scaffold(key: Key('target')),
                  ),
                ),
                child: const Text('Go'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(SlideTransition), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('target')), findsOneWidget);
    });

    testWidgets('childBuilder works correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    childBuilder: (context) =>
                        const Scaffold(key: Key('builder_target')),
                  ),
                ),
                child: const Text('Go'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('builder_target')), findsOneWidget);
    });
  });

  group('PageTransition Extension Tests', () {
    testWidgets('pushTransition works correctly', (tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () {
                context.pushTransition(
                  type: PageTransitionType.fade,
                  child: const Scaffold(key: Key('next_page')),
                );
              },
              child: const Text('Navigate'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('next_page')), findsOneWidget);
    });

    testWidgets('pushReplacementTransition works correctly', (tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () {
                context.pushReplacementTransition(
                  type: PageTransitionType.fade,
                  child: const Scaffold(key: Key('replacement_page')),
                );
              },
              child: const Text('Replace'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Replace'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('replacement_page')), findsOneWidget);
      expect(find.text('Replace'), findsNothing);
    });
  });

  group('PageTransition Properties Tests', () {
    test('duration property is respected', () {
      final transition = PageTransition(
        type: PageTransitionType.fade,
        child: const SizedBox(),
        duration: const Duration(milliseconds: 500),
      );

      expect(transition.transitionDuration, const Duration(milliseconds: 500));
    });

    test('reverseDuration property is respected', () {
      final transition = PageTransition(
        type: PageTransitionType.fade,
        child: const SizedBox(),
        reverseDuration: const Duration(milliseconds: 300),
      );

      expect(transition.reverseTransitionDuration,
          const Duration(milliseconds: 300));
    });

    test('assertions work correctly', () {
      expect(
        () => PageTransition(type: PageTransitionType.fade),
        throwsAssertionError,
      );

      expect(
        () => PageTransition(
          type: PageTransitionType.fade,
          child: const SizedBox(),
          childBuilder: (context) => const SizedBox(),
        ),
        throwsAssertionError,
      );
    });
  });
}
