import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/app/models/screen_state.dart';
import 'package:todo/app/models/todo.dart';
import 'package:todo/app/todo_adding/add_todo_view_model.dart';
import 'package:todo/app/todos_listing/todos_list_view_model.dart';
import 'package:todo/data/models/todo_model.dart';

import 'mocks/mocks.mocks.dart';

void main() {
  final mockRepository = MockTodosRepository();

  group('TodoListViewModel Tests', () {
    test('Initial state is loading', () {
      // Arrange
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Act
      final viewModel = TodoListViewModel(container, mockRepository);

      // Assert
      expect(viewModel.state, isA<ScreenStateLoading>());
    });

    test('Fetching ToDo items successfully', () async {
      // Arrange
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final mockTodoEntities = [
        TodoEntity('Task 1', false),
        TodoEntity('Task 2', true),
      ];
      when(mockRepository.fetchTodos()).thenAnswer((_) async => mockTodoEntities);
      final viewModel = TodoListViewModel(container, mockRepository);

      // Act
      await viewModel.loadData();

      // Assert
      final dataState = viewModel.state as ScreenStateData<List<ToDo>>;
      expect(dataState.data.length, equals(2));
      expect(dataState.data[0].title, equals('Task 1'));
      expect(dataState.data[0].isCompleted, isFalse);
      expect(dataState.data[1].title, equals('Task 2'));
      expect(dataState.data[1].isCompleted, isTrue);
    });

    test('Error state when fetching fails', () async {
      // Arrange
      final container = ProviderContainer();
      addTearDown(container.dispose);
      when(mockRepository.fetchTodos()).thenThrow(Exception('Test Error'));
      final viewModel = TodoListViewModel(container, mockRepository);

      // Act
      await viewModel.loadData();

      // Assert
      expect(viewModel.state, isA<ScreenStateError>());
    });

    test('Retry fetch operation', () async {
      // Arrange
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final mockTodoEntities = [TodoEntity('Task 1', false)];
      final viewModel = TodoListViewModel(container, mockRepository);
      viewModel.state = const ScreenStateError('Test Error');
      when(mockRepository.fetchTodos()).thenAnswer((_) async => mockTodoEntities);

      // Act
      await viewModel.tryAgain();

      // Assert
      expect(viewModel.state, isA<ScreenStateData>());
    });

    test('Adding a new ToDo item', () async {
      // Arrange
      final toDo = ToDo(title: 'Test Task', isCompleted: false);

      final container = ProviderContainer();
      addTearDown(container.dispose);
      final viewModel = TodoListViewModel(container, mockRepository);

      // Act
      container.read(onToDoAddedProvider.notifier).state = toDo;

      // A delay like the real code.
      await Future.delayed(const Duration(milliseconds: 150));

      // Assert
      expect(viewModel.state, isA<ScreenStateData<List<ToDo>>>());
      final dataState = viewModel.state as ScreenStateData<List<ToDo>>;
      expect(dataState.data.length, equals(1));
      expect(dataState.data[0].title, equals('Test Task'));
      expect(dataState.data[0].isCompleted, isFalse);
      expect(container.read(onItemInsertedProvider), equals(toDo));
    });
  });
}
