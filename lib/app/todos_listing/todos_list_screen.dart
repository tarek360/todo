import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/app/models/screen_state.dart';
import 'package:todo/app/models/todo.dart';
import 'package:todo/app/todo_adding/add_todo_bottom_sheet.dart';

import 'todos_list_view_model.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDos'),
      ),
      body: Center(
        child: switch (state) {
          ScreenStateLoading() => const _LoadingWidget(),
          ScreenStateError(errorMessage: var error) => _ErrorWidget(error),
          ScreenStateData(data: var todos) => _DataWidget(todos),
          ScreenStateNoData() => const _NoDataWidget(),
        },
      ),
      floatingActionButton: state is ScreenStateData
          ? FloatingActionButton(
        tooltip: 'Add ToDo',
              onPressed: () => AddTodoBottomSheet.show(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 32,
      height: 32,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}

class _ErrorWidget extends ConsumerWidget {
  const _ErrorWidget(this.error);

  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error,
              style: textTheme.titleSmall?.copyWith(
                color: Colors.grey.shade600,
              )),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: ref.read(todoListViewModelProvider.notifier).tryAgain,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}

class _NoDataWidget extends StatelessWidget {
  const _NoDataWidget();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No ToDos here!',
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            onPressed: () => AddTodoBottomSheet.show(context),
            child: const Text('Add ToDo'),
          ),
        ],
      ),
    );
  }
}

class _DataWidget extends StatelessWidget {
  const _DataWidget(this.todos);

  final List<ToDo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return _TodoListItem(todo: todos[index]);
      },
    );
  }
}

class _TodoListItem extends StatelessWidget {
  final ToDo todo;

  const _TodoListItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        // color: AppColors.colors.danger30,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.primaryContainer, width: 1),
      ),
      child: ListTile(
        title: Text(todo.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        leading: Icon(
          todo.isCompleted ? Icons.check_rounded : Icons.hourglass_empty_rounded,
          color: todo.isCompleted ? Colors.green : colorScheme.primary,
        ),
      ),
    );
  }
}
