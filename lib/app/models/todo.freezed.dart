// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ToDo {
  String get title => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ToDoCopyWith<ToDo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToDoCopyWith<$Res> {
  factory $ToDoCopyWith(ToDo value, $Res Function(ToDo) then) =
      _$ToDoCopyWithImpl<$Res, ToDo>;
  @useResult
  $Res call({String title, bool isCompleted});
}

/// @nodoc
class _$ToDoCopyWithImpl<$Res, $Val extends ToDo>
    implements $ToDoCopyWith<$Res> {
  _$ToDoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ToDoCopyWith<$Res> implements $ToDoCopyWith<$Res> {
  factory _$$_ToDoCopyWith(_$_ToDo value, $Res Function(_$_ToDo) then) =
      __$$_ToDoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, bool isCompleted});
}

/// @nodoc
class __$$_ToDoCopyWithImpl<$Res> extends _$ToDoCopyWithImpl<$Res, _$_ToDo>
    implements _$$_ToDoCopyWith<$Res> {
  __$$_ToDoCopyWithImpl(_$_ToDo _value, $Res Function(_$_ToDo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isCompleted = null,
  }) {
    return _then(_$_ToDo(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ToDo implements _ToDo {
  _$_ToDo({required this.title, required this.isCompleted});

  @override
  final String title;
  @override
  final bool isCompleted;

  @override
  String toString() {
    return 'ToDo(title: $title, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ToDo &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ToDoCopyWith<_$_ToDo> get copyWith =>
      __$$_ToDoCopyWithImpl<_$_ToDo>(this, _$identity);
}

abstract class _ToDo implements ToDo {
  factory _ToDo(
      {required final String title, required final bool isCompleted}) = _$_ToDo;

  @override
  String get title;
  @override
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$$_ToDoCopyWith<_$_ToDo> get copyWith => throw _privateConstructorUsedError;
}
