import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/app/providers.dart';
import 'package:todo/main.dart';

import 'mocks.dart';

void main() {
  group('TodoListScreen Tests', () {
    testWidgets('ScreenStateData Test', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [todosRepositoryProvider.overrideWithValue(FakeDataTodosRepository())],
        child: const ToDoApp(),
      ));

      // At first, expect the loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();

      // Then, expect the data state

      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);

      expect(find.text('a'), findsOneWidget);
      expect(find.text('b'), findsOneWidget);
      expect(find.text('c'), findsOneWidget);

      expect(find.byIcon(Icons.hourglass_empty_rounded), findsNWidgets(2));
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });

    testWidgets('ScreenStateNoData Test', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [todosRepositoryProvider.overrideWithValue(FakeDataTodosRepository.empty())],
        child: const ToDoApp(),
      ));

      // At first, expect the loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();

      // Then, expect the no-data state
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('No ToDos here!'), findsOneWidget);
      expect(find.text('Add ToDo'), findsOneWidget);
    });

    testWidgets('ScreenStateError Test', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [todosRepositoryProvider.overrideWithValue(const FakeErrorTodosRepository())],
        child: const ToDoApp(),
      ));

      // At first, expect the loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();

      // Then, expect the error state
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
      expect(find.text('Failed to load todos!'), findsOneWidget);
    });
  });
}
