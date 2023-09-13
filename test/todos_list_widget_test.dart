import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/app/providers.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/main.dart';

import 'mocks/mocks.dart';

void main() {
  group('TodoListScreen Tests', () {
    final mockRepository = MockTodosRepository();

    final mockTodoEntities = [
      TodoEntity('a', false),
      TodoEntity('b', false),
      TodoEntity('c', true),
    ];

    testWidgets('ScreenStateData Test', (WidgetTester tester) async {
      when(mockRepository.fetchTodos()).thenAnswer((_) async => mockTodoEntities);

      await tester.pumpWidget(ProviderScope(
        overrides: [todosRepositoryProvider.overrideWithValue(mockRepository)],
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
      when(mockRepository.fetchTodos()).thenAnswer((_) async => []);

      await tester.pumpWidget(ProviderScope(
        overrides: [todosRepositoryProvider.overrideWithValue(mockRepository)],
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
      when(mockRepository.fetchTodos()).thenAnswer((_) async => Future.error('test error'));

      await tester.pumpWidget(ProviderScope(
        overrides: [todosRepositoryProvider.overrideWithValue(mockRepository)],
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
