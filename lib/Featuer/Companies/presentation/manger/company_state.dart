import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';

import '../../data/company_model.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<Offer> offers;
  final List<SupplierModel> suppliers;

  DataLoaded({required this.offers, required this.suppliers});
}

class DataError extends DataState {
  final String message;

  DataError({required this.message});
}
