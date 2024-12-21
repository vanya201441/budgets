import 'package:byte_budget/domain/core/failure.dart';
import 'package:byte_budget/domain/entities/payment.dart';
import 'package:byte_budget/domain/repositories/budget_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetState extends Equatable {
  const BudgetState({
    this.isLoading = false,
    this.error,
    this.payments = const [],
  });

  final bool isLoading;
  final Failure? error;
  final List<Payment> payments;

  Payment get loadingOperation => Payment.loading();

  BudgetState copyWith({
    bool? isLoading,
    Failure? error,
    List<Payment>? payments,
  }) {
    return BudgetState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      payments: payments ?? this.payments,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        payments,
      ];
}

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit({required this.repository}) : super(const BudgetState());

  final BudgetRepository repository;

  void fetchOperations() async {
    emit(state.copyWith(isLoading: true));

    final result = await repository.getPayments();
    return result.fold(
      (list) {
        emit(state.copyWith(
          isLoading: false,
          error: null,
          payments: list,
        ));
      },
      (error) {
        emit(state.copyWith(
          isLoading: false,
          error: error,
        ));
      },
    );
  }
}
