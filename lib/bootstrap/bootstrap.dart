import 'package:byte_budget/bootstrap/blocs.dart';
import 'package:byte_budget/bootstrap/repositories.dart';
import 'package:byte_budget/domain/keys.dart';
import 'package:byte_budget/infrastructure/models/operation.dart';
import 'package:byte_budget/infrastructure/repositories.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> bootstrapDependencies(GetIt getIt) async {
  // Logger
  getIt.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(methodCount: 0),
    ),
  );

  // Database
  getIt.registerSingletonAsync<Database>(
    () async {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, DatabaseKeys.budgetDB);

      getIt<Logger>().t('Database path: $path');

      return await openDatabase(DatabaseKeys.budgetDB, version: 1,
          onCreate: (db, version) async {
            DatabaseRepository.createTable(
              db,
              OperationModel.tableName,
              OperationModel.tableColumns,
            );
          });
    },
  );

  await getIt.allReady();
  await bootstrapRepositories(getIt);
  await bootstrapBlocs(getIt);
}
