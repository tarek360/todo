import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_todo_view_model.dart';

class AddTodoBottomSheet extends ConsumerWidget {
  const AddTodoBottomSheet._();

  static show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTodoBottomSheet._(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.primary, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New ToDo', style: textTheme.titleMedium),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      elevation: 0,
                    ),
                    onPressed: _getOnPressed(context, ref),
                    child: child,
                  );
                },
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextField(
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _getOnPressed(context, ref)?.call(),
            decoration: InputDecoration(
              hintText: 'Example: Drink more water.',
              hintStyle: textTheme.titleMedium?.copyWith(color: Colors.grey.shade500),
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
            ),
            onChanged: ref.read(addToDoViewModelProvider.notifier).onTextInputChanged,
          ),
        ],
      ),
    );
  }

  VoidCallback? _getOnPressed(BuildContext context, WidgetRef ref) {
    return ref.watch(isAddButtonEnabledProvider)
        ? () {
            ref.read(addToDoViewModelProvider.notifier).addToDo();
            Navigator.pop(context);
          }
        : null;
  }
}
