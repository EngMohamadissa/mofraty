part of 'home_cubit.dart';

abstract class SupplierState extends Equatable {
  @override
  List<Object> get props => [];
}

class SupplierInitial extends SupplierState {}

class SupplierLoading extends SupplierState {}

class SupplierLoaded extends SupplierState {
  final List<HomeModel> supplierCategories;
  final List<String> offerImages;

  SupplierLoaded(this.supplierCategories, this.offerImages);

  @override
  List<Object> get props => [supplierCategories, offerImages];
}

class SupplierError extends SupplierState {
  final String message;

  SupplierError(this.message);

  @override
  List<Object> get props => [message];
}
