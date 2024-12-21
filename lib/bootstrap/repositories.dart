import 'package:byte_budget/domain/repositories.dart';
import 'package:byte_budget/domain/repositories/operations_repo.dart';
import 'package:byte_budget/infrastructure/repositories.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

Future<void> bootstrapRepositories(GetIt getIt) async {
  getIt.registerLazySingleton<BudgetRepository>(() => MockBudgetRepository());

  getIt.registerLazySingleton<DatabaseRepository>(
    () => DatabaseRepositoryImpl(
      database: getIt<Database>(),
    ),
  );

  getIt.registerLazySingleton<OperationsRepository>(
    () => OperationsRepositoryImpl(
      databaseRepository: getIt<DatabaseRepository>(),
    ),
  );
}
