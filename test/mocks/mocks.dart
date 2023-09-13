library app_mocks;

import 'package:mockito/annotations.dart';
import 'package:todo/data/todos_repository.dart';

export 'mocks.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TodosRepository>(),
])
void main() {}
