import 'package:byte_budget/domain/core/failure.dart';
import 'package:byte_budget/domain/entities/operation.dart';
import 'package:byte_budget/domain/repositories/operations_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperationsState extends Equatable {
  const OperationsState({
    this.isLoading = false,
    this.error,
    this.operations = const [],
  });

  final bool isLoading;
  final Failure? error;
  final List<Operation> operations;

  OperationsState copyWith({
    bool? isLoading,
    Failure? error,
    List<Operation>? operations,
  }) {
    return OperationsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      operations: operations ?? this.operations,
    );
  }

  @override
  List<Object> get props => [isLoading, error ?? '', operations];
}

class OperationsCubit extends Cubit<OperationsState> {
  OperationsCubit({required this.operationsRepository})
      : super(const OperationsState());

  final OperationsRepository operationsRepository;

  // Получение операций
  Future<void> fetchOperations() async {
    emit(state.copyWith(isLoading: true));

    final result = await operationsRepository.getOperations();

    result.fold((value) {
      emit(
        state.copyWith(
          isLoading: false,
          operations: value,
          error: null,
        ),
      );
    }, (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: error.where('OperationsCubit.fetchOperations()'),
        ),
      );
    });
  }

  // Добавление новой операции
  Future<void> addOperation(Operation operation) async {
    final result = await operationsRepository.addOperation(operation);

    result.fold((id) {
      emit(
        state.copyWith(
          isLoading: false,
          operations: state.operations + [operation.copyWith(id: id)],
          error: null,
        ),
      );
    }, (error) {
      emit(
        state.copyWith(
          error: error.where('OperationsCubit.addOperation()'),
        ),
      );
    });
  }

  // Удаление операции
  Future removeOperation(int operationId) async {
    final result = await operationsRepository.removeOperation(operationId);
    result.fold((_) {
      final updatedOperations =
          state.operations.where((op) => op.id != operationId).toList();
      emit(state.copyWith(operations: updatedOperations));
    }, (error) {
      emit(
        state.copyWith(
          error: error,
        ),
      );
    });
  }
}
