import 'package:equatable/equatable.dart';

enum OperationType {
  regular(id: 0, title: 'Подписка'),
  single(id: 1, title: 'Платеж'),
  topUp(id: 2, title: 'Пополнение');

  const OperationType({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;
}

enum Currency {
  rub(id: 0, title: 'RUB', symbol: '₽'),
  usd(id: 1, title: 'USD', symbol: '\$'),
  eur(id: 2, title: 'EUR', symbol: '€'),
  ;

  const Currency({
    required this.id,
    required this.title,
    required this.symbol,
  });

  final int id;
  final String title;
  final String symbol;
}

class Operation extends Equatable {
  const Operation({
    required this.id,
    required this.merchantId,
    required this.merchantName,
    required this.type,
    required this.amount,
    required this.currency,
    required this.paymentDate,
    this.daysPeriod,
    this.bankId,
    this.accountId,
    this.bankCardId,
    this.description,
  });

  final int id;
  final String merchantId;
  final String merchantName;
  final OperationType type;
  final double amount;
  final Currency currency;
  final DateTime paymentDate;
  final int? daysPeriod;
  final String? bankId;
  final String? accountId;
  final String? bankCardId;
  final String? description;

  Operation copyWith({
    int? id,
    String? merchantId,
    String? merchantName,
    OperationType? type,
    double? amount,
    Currency? currency,
    DateTime? paymentDate,
    int? daysPeriod,
    String? bankId,
    String? accountId,
    String? bankCardId,
    String? description,
  }) {
    return Operation(
      id: id ?? this.id,
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentDate: paymentDate ?? this.paymentDate,
      daysPeriod: daysPeriod ?? this.daysPeriod,
      bankId: bankId ?? this.bankId,
      accountId: accountId ?? this.accountId,
      bankCardId: bankCardId ?? this.bankCardId,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        merchantId,
        merchantName,
        type,
        amount,
        currency,
        paymentDate,
        daysPeriod,
        bankId,
        accountId,
        bankCardId,
        description,
      ];
}
