import 'package:equatable/equatable.dart';
import 'package:rust_types/rust_types.dart';

abstract class Failure extends Equatable {
  const Failure({this.whereString});

  final String? whereString;

  where(String where);

  Result<T, Failure> toErr<T>() => Err<T, Failure>(this);

  @override
  List<Object?> get props => [whereString];
}

class BudgetRepositoryFailure extends Failure {
  const BudgetRepositoryFailure({
    super.whereString,
  });

  @override
  where(String where) => BudgetRepositoryFailure(whereString: where);
}

class MerchantNotFoundFailure extends Failure {
  const MerchantNotFoundFailure({
    super.whereString,
    this.id,
  });

  final int? id;

  @override
  where(String where) => MerchantNotFoundFailure(whereString: where, id: id);

  @override
  List<Object?> get props => [whereString, id];
}

class OperationNotFoundByIdFailure extends Failure {
  const OperationNotFoundByIdFailure({
    super.whereString,
    this.id,
  });

  final int? id;

  @override
  where(String where) =>
      OperationNotFoundByIdFailure(whereString: where, id: id);

  @override
  List<Object?> get props => [whereString, id];
}

class DatabaseInsertEmptyDataFailure extends Failure {
  const DatabaseInsertEmptyDataFailure({
    super.whereString,
  });

  @override
  where(String where) => DatabaseInsertEmptyDataFailure(whereString: where);
}

class DatabaseTableNotFoundFailure extends Failure {
  const DatabaseTableNotFoundFailure({
    super.whereString,
  });

  @override
  where(String where) => DatabaseTableNotFoundFailure(whereString: where);
}

class DatabaseInsertTryCatchFailure extends Failure {
  const DatabaseInsertTryCatchFailure({
    super.whereString,
  });

  @override
  where(String where) => DatabaseInsertTryCatchFailure(whereString: where);
}

class DatabaseQueryTryCatchFailure extends Failure {
  const DatabaseQueryTryCatchFailure({
    super.whereString,
  });

  @override
  where(String where) => DatabaseQueryTryCatchFailure(whereString: where);
}

class DatabaseQueryWhereTryCatchFailure extends Failure {
  const DatabaseQueryWhereTryCatchFailure({
    super.whereString,
  });

  @override
  where(String where) => DatabaseQueryWhereTryCatchFailure(whereString: where);
}

class DatabaseDeleteWhereTryCatchFailure extends Failure {
  const DatabaseDeleteWhereTryCatchFailure({
    super.whereString,
  });

  @override
  where(String where) => DatabaseDeleteWhereTryCatchFailure(whereString: where);
}

// /// Новый общий класс ошибки
// class GeneralFailure extends Failure {
//   const GeneralFailure({
//     super.whereString,
//     this.message,
//   });
//
//   final String? message;
//
//   @override
//   where(String where) => GeneralFailure(whereString: where, message: message);
//
//   @override
//   List<Object?> get props => [whereString, message];
// }
