import 'package:byte_budget/domain/entities.dart';

class OperationModel {
  static const tableName = 'operations';
  static const tableColumns = {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'merchantId': 'TEXT',
    'merchantName': 'TEXT',
    'typeId': 'INTEGER',
    'amount': 'REAL',
    'currencyTitle': 'TEXT',
    'paymentDate': 'TEXT',
    'daysPeriod': 'INTEGER',
    'bankId': 'TEXT',
    'accountId': 'TEXT',
    'bankCardId': 'TEXT',
    'description': 'TEXT',
  };

  OperationModel.fromEntity(Operation operation)
      : id = operation.id,
        merchantId = operation.merchantId,
        merchantName = operation.merchantName,
        typeId = operation.type.id,
        amount = operation.amount,
        currencyTitle = Currency.values.firstWhere((element) => element.id == operation.currency.id,).title,
        paymentDate = operation.paymentDate.toString(),
        daysPeriod = operation.daysPeriod,
        bankId = operation.bankId,
        accountId = operation.accountId,
        bankCardId = operation.bankCardId,
        description = operation.description;

  OperationModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        merchantId = map['merchantId'],
        merchantName = map['merchantName'],
        typeId = map['typeId'],
        amount = map['amount'],
        currencyTitle = map['currencyTitle'],
        paymentDate = map['paymentDate'],
        daysPeriod = map['daysPeriod'],
        bankId = map['bankId'],
        accountId = map['accountId'],
        bankCardId = map['bankCardId'],
        description = map['description'];

  final int id;
  final String merchantId;
  final String merchantName;
  final int typeId;
  final double amount;
  final String currencyTitle;
  final String paymentDate;
  final int? daysPeriod;
  final String? bankId;
  final String? accountId;
  final String? bankCardId;
  final String? description;

  Map<String, dynamic> toMap() {
    return {
      'merchantId': merchantId,
      'merchantName': merchantName,
      'typeId': typeId,
      'amount': amount,
      'currencyTitle': currencyTitle,
      'paymentDate': paymentDate,
      'daysPeriod': daysPeriod,
      'bankId': bankId,
      'accountId': accountId,
      'bankCardId': bankCardId,
      'description': description,
    };
  }

  Operation toEntity() {
    return Operation(
      id: id,
      merchantId: merchantId,
      merchantName: merchantName,
      type: OperationType.values.firstWhere((element) => element.id == typeId),
      amount: amount,
      currency: Currency.values.firstWhere((element) => element.title == currencyTitle),
      paymentDate: DateTime.parse(paymentDate),
      daysPeriod: daysPeriod,
      bankId: bankId,
      accountId: accountId,
      bankCardId: bankCardId,
      description: description,
    );
  }
}
