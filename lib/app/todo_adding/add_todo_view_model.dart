import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';

final onToDoAddedProvider = StateProvider.autoDispose<ToDo?>((ref) => null);

final isAddButtonEnabledProvider = StateProvider.autoDispose((ref) => ref.watch(_isValidInputProvider));

final _isValidInputProvider = StateProvider.autoDispose((ref) => ref.watch(addToDoViewModelProvider).trim().isNotEmpty);

final addToDoViewModelProvider = StateNotifierProvider.autoDispose<AddToDoViewModel, String>(
  (ref) => AddToDoViewModel(ref),
);

class AddToDoViewModel extends StateNotifier<String> {
  AddToDoViewModel(this._ref) : super('');

  final Ref _ref;

  void onTextInputChanged(String value) {
    state = value;
  }

  void addToDo() {
    _ref.read(onToDoAddedProvider.notifier).state = ToDo(title: state, isCompleted: false);
  }
}
