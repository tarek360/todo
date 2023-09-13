import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/data/todos_repository.dart';

final dioProvider = Provider<Dio>((ref) {
  const baseUrl = 'https://jsonplaceholder.typicode.com';
  return Dio(BaseOptions(baseUrl: baseUrl));
});

final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  return TodosRepositoryImpl(ref.watch(dioProvider));
});
