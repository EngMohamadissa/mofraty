// abstract class BillState {}

// class BillInitial extends BillState {}

// class BillLoading extends BillState {}

// class BillLoaded extends BillState {
//   final List<dynamic> bills;

//   final bool updatable;

//   final double wafrna;
//   final String status;
//   final String productName;
//   final String paymentMethod;
//   final String statusBill;

//   final String createdFromValue;

//   final double totalPriceValue;
//   // final double productOfferPrice;
//   // final double productPrice;

//   //final int productHasOffer;
//   //final int productQuantity;
//   final int idValue;

//   BillLoaded(
//       {required this.bills,
//       required this.updatable,
//       required this.paymentMethod,
//       required this.createdFromValue,
//       required this.idValue,
//       // required this.productQuantity,
//       required this.productName,
//       required this.wafrna,
//       required this.status,
//       required this.statusBill,
//       required this.totalPriceValue,
//       // required this.productOfferPrice,
//       // required this.productPrice,
//       // required this.productHasOffer,
//       required List products});
// }

// class BillError extends BillState {
//   final String message;

//   BillError(this.message);
// }

import '../../modelbill/bill.dart';

abstract class BillStateGet {}

class BillInitial extends BillStateGet {}

class BillLoading extends BillStateGet {}

class BillLoaded extends BillStateGet {
  final List<Bill> bills;
  final String statusBill;

  BillLoaded({required this.statusBill, required this.bills});
}

class BillError extends BillStateGet {
  final String message;

  BillError({required this.message});
}

//class InvoiceInitial extends BillState {}

class InvoiceLoading extends BillStateGet {}

class InvoiceSuccess extends BillStateGet {
  final String message;
  InvoiceSuccess(this.message);
}

class InvoiceError extends BillStateGet {
  final String error;
  InvoiceError(this.error);
}

/////
class BillDeletInitial extends BillStateGet {}

class BillDeletLoading extends BillStateGet {}

class BillDeletSuccess extends BillStateGet {
  final String message;

  BillDeletSuccess(this.message);
}

class BillDeletFailure extends BillStateGet {
  final String errorMessage;

  BillDeletFailure(this.errorMessage);
}
