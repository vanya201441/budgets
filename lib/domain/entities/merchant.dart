import 'package:equatable/equatable.dart';

class Merchant extends Equatable {
  const Merchant({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
  });

  final int id;
  final String name;
  final String logo;
  final String description;

  Merchant copyWith({
    int? id,
    String? name,
    String? logo,
    String? description,
  }) {
    return Merchant(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, name, logo, description];
}