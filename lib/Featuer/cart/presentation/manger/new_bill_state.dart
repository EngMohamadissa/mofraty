// abstract class BillState {}

// class BillInitial extends BillState {}

// class BillLoading extends BillState {}

// class BillSuccess extends BillState {
//   final String message;

//   BillSuccess(this.message);
// }

// class BillFailure extends BillState {
//   final String errorMessage;

//   BillFailure(this.errorMessage);
// }
abstract class BillState {}

class BillInitial extends BillState {}

class BillLoading extends BillState {}

class BillSuccess extends BillState {
  final String message;

  BillSuccess(this.message);
}

class BillFailure extends BillState {
  final String errorMessage;

  BillFailure(this.errorMessage);
}
