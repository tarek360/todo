import 'package:dio/dio.dart';
import 'package:todo/data/models/todo_model.dart';

class TodosRepository {
  final Dio _dio;

  TodosRepository(this._dio);

  Future<List<TodoEntity>> fetchTodos() async {
    final response = await _dio.get('/todos');
    final data = response.data as List<dynamic>;
    return data.map((item) => TodoEntity.fromJson(item)).toList();
  }
}
