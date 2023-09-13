import 'package:dio/dio.dart';
import 'package:todo/data/models/todo_model.dart';

abstract class TodosRepository {
  Future<List<TodoEntity>> fetchTodos();
}

class TodosRepositoryImpl implements TodosRepository {
  final Dio _dio;

  TodosRepositoryImpl(this._dio);

  @override
  Future<List<TodoEntity>> fetchTodos() async {
    final response = await _dio.get('/todos');
    final data = response.data as List<dynamic>;
    return data.map((item) => TodoEntity.fromJson(item)).toList();
  }
}
