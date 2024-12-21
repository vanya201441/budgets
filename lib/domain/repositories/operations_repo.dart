import 'package:byte_budget/domain/core/failure.dart';
import 'package:byte_budget/domain/entities/operation.dart';
import 'package:byte_budget/domain/keys.dart';
import 'package:byte_budget/infrastructure/models/operation.dart';
import 'package:byte_budget/infrastructure/repositories/database_repository.dart';
import 'package:byte_budget/main.dart';
import 'package:logger/logger.dart';
import 'package:rust_types/rust_types.dart';

abstract class OperationsRepository {
  Future<Result<List<Operation>, Failure>> getOperations();

  Future<Result<Operation, Failure>> getOperationById(int id);

  Future<Result<int, Failure>> addOperation(Operation operation);

  Future<Result<void, Failure>> removeOperation(int operationId);
}

class OperationsRepositoryImpl implements OperationsRepository {
  OperationsRepositoryImpl({required this.databaseRepository});

  final DatabaseRepository databaseRepository;

  @override
  Future<Result<List<Operation>, Failure>> getOperations() async {
    final result = await databaseRepository.query(DatabaseKeys.operationsTable);

    return result.fold(
      (list) {
        final operationModels =
            list.map((value) => OperationModel.fromMap(value)).toList();
        final operations =
            operationModels.map((model) => model.toEntity()).toList();

        return Ok(operations);
      },
      (error) {
        getIt<Logger>().e(
            'OperationsRepositoryImpl: Ошибка при получении операций: $error');
        return Err(error);
      },
    );
  }

  @override
  Future<Result<Operation, Failure>> getOperationById(int id) async {
    final result = await databaseRepository.queryWhere(
      DatabaseKeys.operationsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.fold(
      (list) {
        if (list.isEmpty) {
          getIt<Logger>()
              .e('OperationsRepositoryImpl: Операция с id $id не найдена');
          return OperationNotFoundByIdFailure(id: id).toErr();
        }

        final operationModel = OperationModel.fromMap(list.first);
        final operation = operationModel.toEntity();

        return Ok(operation);
      },
      (error) {
        getIt<Logger>().e(
            'OperationsRepositoryImpl: Ошибка при получении операции по id: $error');
        return error.toErr();
      },
    );
  }

  @override
  Future<Result<int, Failure>> addOperation(Operation operation) async {
    final operationModel = OperationModel.fromEntity(operation);
    final result = await databaseRepository.insert(
        DatabaseKeys.operationsTable, operationModel.toMap());

    return result.fold(
      (id) => Ok(id),
      (error) {
        getIt<Logger>().e(
            'OperationsRepositoryImpl: Ошибка при добавлении операции: $error');
        return error.toErr();
      },
    );
  }

  Future<Result<void, Failure>> removeOperation(int operationId) async {
    final result = await databaseRepository.deleteWhere(
      DatabaseKeys.operationsTable,
      where: 'id = ?',
      whereArgs: [operationId],
    );

    return result.fold(
      (_) => const Ok(null),
      (error) {
        getIt<Logger>().e(
            'OperationsRepositoryImpl: Ошибка при удалении операции: $error');
        return error.toErr();
      },
    );
  }
}
