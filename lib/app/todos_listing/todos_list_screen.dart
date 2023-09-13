import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/app/models/screen_state.dart';
import 'package:todo/app/models/todo.dart';
import 'package:todo/app/todo_adding/add_todo_bottom_sheet.dart';

import 'todos_list_view_model.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  ConsumerState<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(todoListViewModelProvider.notifier).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoListViewModelProvider);
    final colorScheme = Theme.of(context).colorScheme;

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
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              splashColor: colorScheme.onPrimaryContainer,
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

class _DataWidget extends ConsumerStatefulWidget {
  const _DataWidget(this.todos);

  final List<ToDo> todos;

  @override
  ConsumerState<_DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends ConsumerState<_DataWidget> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ref.listen(onItemInsertedProvider, (previous, next) {
      _scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.ease);
      _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 500));
    });
    return AnimatedList(
      key: _listKey,
      controller: _scrollController,
      initialItemCount: widget.todos.length,
      itemBuilder: (context, index, animation) {
        return _TodoListItem(todo: widget.todos[index], animation: animation);
      },
    );
  }
}

class _TodoListItem extends StatelessWidget {
  final ToDo todo;
  final Animation<double> animation;

  const _TodoListItem({
    required this.todo,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final displayAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animation, curve: const Interval(0.0, 0.6, curve: Cubic(.42, 0, .58, 1))),
    );

    final scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(parent: animation, curve: const Interval(0.3, 1, curve: Cubic(.42, 0, .58, 2.2))),
    );

    return FadeTransition(
      opacity: displayAnimation,
      child: SizeTransition(
        sizeFactor: displayAnimation,
        child: ScaleTransition(
          alignment: Alignment.center,
          scale: scaleAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Text(todo.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              leading: Icon(
                todo.isCompleted ? Icons.check_rounded : Icons.hourglass_empty_rounded,
                color: todo.isCompleted ? Colors.green : colorScheme.primary,
              ),
              onTap: () => _TodoBottomDetailsSheet.show(context, todo: todo),
            ),
          ),
        ),
      ),
    );
  }
}

class _TodoBottomDetailsSheet extends ConsumerWidget {
  const _TodoBottomDetailsSheet._(
    this.todo,
    this.scrollController,
  );

  final ToDo todo;
  final ScrollController scrollController;

  static show(BuildContext context, {required ToDo todo}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) => _TodoBottomDetailsSheet._(todo, scrollController),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Icon(
            todo.isCompleted ? Icons.check_rounded : Icons.hourglass_empty_rounded,
            color: todo.isCompleted ? Colors.green : colorScheme.primary,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsetsDirectional.symmetric(vertical: 32.0, horizontal: 16),
            child: Text(todo.title, style: textTheme.titleMedium),
          ),
        ),
      ],
    );
  }
}
