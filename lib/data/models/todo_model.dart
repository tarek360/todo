// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoEntity {
  TodoEntity(
    this.title,
    this.isCompleted,
  );

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'completed')
  final bool? isCompleted;

  factory TodoEntity.fromJson(Map<String, dynamic> json) => _$TodoEntityFromJson(json);
}
