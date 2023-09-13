import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/app/models/screen_state.dart';
import 'package:todo/app/models/todo.dart';
import 'package:todo/app/providers.dart';
import 'package:todo/app/todo_adding/add_todo_view_model.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/data/todos_repository.dart';

final todoListViewModelProvider = StateNotifierProvider.autoDispose<TodoListViewModel, ScreenState<List<ToDo>>>(
  (ref) => TodoListViewModel(
    ref.container,
    ref.watch(todosRepositoryProvider),
  ),
);

final onItemInsertedProvider = StateProvider.autoDispose<ToDo?>((ref) => null);

class TodoListViewModel extends StateNotifier<ScreenState<List<ToDo>>> {
  TodoListViewModel(
    this._ref,
    this._repository,
  ) : super(const ScreenStateLoading()) {
    _ref.listen<ToDo?>(onToDoAddedProvider, (previous, todo) {
      if (todo != null) {
        _addTodo(todo);
      }
    });
  }

  final ProviderContainer _ref;
  final TodosRepository _repository;

  Future<void> loadData() async {
    try {
      final todos = _transformModel(await _repository.fetchTodos());
      state = todos.isEmpty ? const ScreenStateNoData() : ScreenStateData(todos);
    } catch (e) {
      state = const ScreenStateError('Failed to load todos!');
    }
  }

  /// Transform to UI model that has only valid data.
  /// Items that have unexpected data are ignored.
  List<ToDo> _transformModel(List<TodoEntity> input) {
    return input
        .map((e) {
          final title = e.title;
          final isCompleted = e.isCompleted;

          if (title == null || isCompleted == null) {
            return null;
          }

          return ToDo(title: title, isCompleted: isCompleted);
        })
        .whereNotNull()
        .toList();
  }

  Future<void> tryAgain() async {
    state = const ScreenStateLoading();
    loadData();
  }

  void _addTodo(ToDo todo) {
    void addItem() {
      final List<ToDo> newList = switch (state) {
        ScreenStateData(data: var data) => [todo, ...data],
        _ => [todo],
      };

      state = ScreenStateData(newList);
      _ref.read(onItemInsertedProvider.notifier).state = todo;
    }

    void doHapticFeedback() {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          HapticFeedback.lightImpact();
        }
      });
    }

    // A delay to wait the bottom sheet closing.
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        addItem();
        doHapticFeedback();
      }
    });
  }
}
