import 'package:equatable/equatable.dart';

class BankAccount extends Equatable {
  const BankAccount({
    required this.id,
    required this.accountName,
    required this.balance,
  });

  final int id;
  final String accountName;
  final double balance;

  @override
  List<Object> get props => [
        id,
        accountName,
        balance,
      ];
}
