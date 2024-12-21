import 'package:byte_budget/domain/core/failure.dart';
import 'package:byte_budget/main.dart';
import 'package:logger/logger.dart';
import 'package:rust_types/rust_types.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseRepository {
  const DatabaseRepository();

  static void createTable(
      Database db, String tableName, Map<String, String> columnsWithType) {
    final columns =
        columnsWithType.entries.map((e) => '${e.key} ${e.value}').join(', ');
    db.execute('CREATE TABLE $tableName ($columns)');
  }

  Future<bool> isTableExists(String tableName);

  Future<Result<int, Failure>> insert(String table, Map<String, dynamic> data);

  Future<Result<List<Map<String, dynamic>>, Failure>> query(String table);

  Future<Result<void, Failure>> deleteWhere(String table,
      {required String where, required List<Object> whereArgs});

  Future<Result<List<Map<String, dynamic>>, Failure>> queryWhere(
    String table, {
    required String where,
    required List<Object> whereArgs,
  });
}

class DatabaseRepositoryImpl extends DatabaseRepository {
  const DatabaseRepositoryImpl({required this.database});

  final Database database;

  @override
  Future<bool> isTableExists(String tableName) async {
    // Выполняем запрос к sqlite_master с указанием имени таблицы
    var result = await database.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );

    // Если результат не пустой, значит таблица существует
    return result.isNotEmpty;
  }

  @override
  Future<Result<int, Failure>> insert(
      String table, Map<String, dynamic> data) async {
    if (data.isEmpty) {
      getIt<Logger>().e(
          'DatabaseRepositoryImpl: Пустые данные для добавления в таблицу `$table`');
      return const DatabaseInsertEmptyDataFailure().toErr();
    }

    if (!await isTableExists(table)) {
      getIt<Logger>().e('DatabaseRepositoryImpl: Таблица `$table` не найдена');
      return const DatabaseTableNotFoundFailure().toErr();
    }

    try {
      final id = await database.insert(table, data);
      getIt<Logger>().t(
          'DatabaseRepositoryImpl: Добавлена запись в таблицу `$table` с id: $id');

      return Ok(id);
    } catch (e) {
      getIt<Logger>().e(
          'DatabaseRepositoryImpl: Ошибка при добавлении записи в таблицу `$table`: \n$e');
      return const DatabaseInsertTryCatchFailure().toErr();
    }
  }

  @override
  Future<Result<List<Map<String, dynamic>>, Failure>> query(
      String table) async {
    if (!await isTableExists(table)) {
      getIt<Logger>().e('DatabaseRepositoryImpl: Таблица `$table` не найдена');
      return const DatabaseTableNotFoundFailure().toErr();
    }

    try {
      final result = await database.query(table);
      getIt<Logger>().t(
          'DatabaseRepositoryImpl: Получены данные из таблицы `$table` в количестве: ${result.length}');

      return Ok(result);
    } catch (e) {
      getIt<Logger>().e(
          'DatabaseRepositoryImpl: Ошибка при получении данных из таблицы `$table`: \n$e');

      return const DatabaseQueryTryCatchFailure().toErr();
    }
  }

  @override
  Future<Result<List<Map<String, dynamic>>, Failure>> queryWhere(
    String table, {
    required String where,
    required List<Object> whereArgs,
  }) async {
    if (!await isTableExists(table)) {
      getIt<Logger>().e('DatabaseRepositoryImpl: Таблица `$table` не найдена');
      return const DatabaseTableNotFoundFailure().toErr();
    }

    try {
      final result =
          await database.query(table, where: where, whereArgs: whereArgs);
      getIt<Logger>().t(
          'DatabaseRepositoryImpl: Получены данные из таблицы `$table` в количестве: ${result.length}');

      return Ok(result);
    } catch (e) {
      getIt<Logger>().e(
          'DatabaseRepositoryImpl: Ошибка при получении данных из таблицы `$table` c условием where = $where, whereArgs = $whereArgs: \n$e');

      return const DatabaseQueryWhereTryCatchFailure().toErr();
    }
  }

  @override
  Future<Result<void, Failure>> deleteWhere(String table,
      {required String where, required List<Object> whereArgs}) async {
    if (!await isTableExists(table)) {
      getIt<Logger>().e('DatabaseRepositoryImpl: Таблица `$table` не найдена');
      return const DatabaseTableNotFoundFailure().toErr();
    }

    try {
      final result =
      await database.delete(table, where: where, whereArgs: whereArgs);
      getIt<Logger>().t(
          'DatabaseRepositoryImpl: Удалены данные из таблицы `$table` с условием where = $where, whereArgs = $whereArgs');

      return Ok(result);
    } catch (e) {
      getIt<Logger>().e(
          'DatabaseRepositoryImpl: Ошибка при удалении данных из таблицы `$table` c условием where = $where, whereArgs = $whereArgs: \n$e');

      return const DatabaseDeleteWhereTryCatchFailure().toErr();
    }
  }
}
