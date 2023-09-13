import 'package:todo/data/models/todo_model.dart';
import 'package:todo/data/todos_repository.dart';

class FakeDataTodosRepository implements TodosRepository {
  FakeDataTodosRepository.empty() : data = [];

  FakeDataTodosRepository()
      : data = [
          TodoEntity('a', false),
          TodoEntity('b', false),
          TodoEntity('c', true),
        ];

  final List<TodoEntity> data;

  @override
  Future<List<TodoEntity>> fetchTodos() async => data;
}

class FakeErrorTodosRepository implements TodosRepository {
  const FakeErrorTodosRepository();

  @override
  Future<List<TodoEntity>> fetchTodos() async => Future.error('fake something wrong');
}
