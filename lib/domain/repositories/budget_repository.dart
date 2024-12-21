import 'package:byte_budget/domain/core/failure.dart';
import 'package:byte_budget/domain/entities.dart';
import 'package:byte_budget/domain/entities/payment.dart';
import 'package:rust_types/rust_types.dart';

abstract class BudgetRepository {
  Future<Result<List<Payment>, Failure>> getPayments();
}

class MockBudgetRepository extends BudgetRepository {
  @override
  Future<Result<List<Payment>, Failure>> getPayments() async {
    await Future.delayed(const Duration(seconds: 2));
    final list = [
      Payment(
          id: 1,
          operationDate: DateTime(2024, 11, 15),
          balance: 25.00,
          merchantId: '10001',
          merchantName: 'Apple iCloud',
          operationType: OperationType.regular,
          operationAmount: 2.99,
          operationCurrency: Currency.usd,
          remainBalance: 22.01,
      ),
      Payment(
          id: 2,
          operationDate: DateTime(2024, 11, 17),
          balance: 22.01,
          merchantId: '10002',
          merchantName: 'ChatGPT',
          operationType: OperationType.regular,
          operationAmount: 20.00,
          operationCurrency: Currency.usd,
          remainBalance: 2.01,
      ),
      Payment(
          id: 3,
          operationDate: DateTime(2024, 11, 20),
          balance: 32567.78,
          merchantId: '10005',
          merchantName: 'Т-Банк',
          operationType: OperationType.topUp,
          operationAmount: 75000.00,
          operationCurrency: Currency.rub,
          remainBalance: 107567.78,
      ),
    ];

    return Ok(list);
  }
}