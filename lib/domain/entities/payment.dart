import 'package:byte_budget/domain/entities.dart';
import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  const Payment({
    required this.id,
    required this.operationDate,
    required this.balance,
    required this.merchantId,
    required this.merchantName,
    required this.operationType,
    required this.operationAmount,
    required this.operationCurrency,
    required this.remainBalance,
    this.paymentAccountId,
    this.topUpAccountId,
  });

  Payment.loading():
        id = -1,
        operationDate = DateTime.now(),
        balance = 10000,
        merchantId = '000000',
        merchantName = 'Nigga\'s Shop',
        operationType = OperationType.single,
        operationAmount = 0,
        operationCurrency = Currency.rub,
        remainBalance = 0,
        paymentAccountId = '000000',
        topUpAccountId = '000000';

  final int id;
  final DateTime operationDate;
  final double balance;
  final String merchantId;
  final String merchantName;
  final OperationType operationType;
  final double operationAmount;
  final Currency operationCurrency;
  final double remainBalance;
  final String? paymentAccountId;
  final String? topUpAccountId;

  Payment copyWith({
    int? id,
    DateTime? operationDate,
    double? balance,
    String? merchantId,
    String? merchantName,
    OperationType? operationType,
    double? operationAmount,
    Currency? operationCurrency,
    double? remainBalance,
    String? paymentAccountId,
    String? topUpAccountId,
  }) {
    return Payment(
      id: id ?? this.id,
      operationDate: operationDate ?? this.operationDate,
      balance: balance ?? this.balance,
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      operationType: operationType ?? this.operationType,
      operationAmount: operationAmount ?? this.operationAmount,
      operationCurrency: operationCurrency ?? this.operationCurrency,
      remainBalance: remainBalance ?? this.remainBalance,
      paymentAccountId: paymentAccountId ?? this.paymentAccountId,
      topUpAccountId: topUpAccountId ?? this.topUpAccountId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    operationDate,
    balance,
    merchantId,
    merchantName,
    operationType,
    operationAmount,
    operationCurrency,
    remainBalance,
    paymentAccountId,
    topUpAccountId,
  ];
}