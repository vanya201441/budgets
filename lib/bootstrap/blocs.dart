import 'package:byte_budget/domain/repositories.dart';
import 'package:byte_budget/domain/repositories/operations_repo.dart';
import 'package:byte_budget/presentation/bloc/budget_cubit.dart';
import 'package:byte_budget/presentation/bloc/operations_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> bootstrapBlocs(GetIt getIt) async {
  getIt.registerLazySingleton<BudgetCubit>(() => BudgetCubit(
        repository: getIt<BudgetRepository>(),
      ));

  getIt.registerLazySingleton<OperationsCubit>(
    () => OperationsCubit(
      operationsRepository: getIt<OperationsRepository>(),
    ),
  );
}
