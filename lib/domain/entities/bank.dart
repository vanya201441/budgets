import 'package:equatable/equatable.dart';

class Bank extends Equatable {
  const Bank({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}