import 'package:equatable/equatable.dart';

class BankCard extends Equatable {
  const BankCard({
    required this.id,
    required this.shortCardNumber,
  });

  final int id;
  final String shortCardNumber;

  @override
  List<Object> get props => [
        id,
        shortCardNumber,
      ];
}
