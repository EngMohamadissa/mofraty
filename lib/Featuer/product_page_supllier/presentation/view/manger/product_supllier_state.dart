import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<ProductCategory> categories;

  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String errorMessage;

  CategoryError(this.errorMessage);
}

abstract class ProductStateSupllier {}

class ProductsInitial extends ProductStateSupllier {}

class ProductsLoading extends ProductStateSupllier {}

class ProductsLoaded extends ProductStateSupllier {
  final List<Product> products;
  final int categoryId;
  final SupplierModel? supplier;

  ProductsLoaded(this.products, this.categoryId, this.supplier);
}

class ProductsError extends ProductStateSupllier {
  final String errorMessage;

  ProductsError(this.errorMessage);
}

class WithOfferInitial extends ProductStateSupllier {}

class WithOfferLoading extends ProductStateSupllier {}

class WithOfferSuccess extends ProductStateSupllier {
  final List<Product> products;
  final int categoryId2;

  final SupplierModel? supplier;

  WithOfferSuccess(
    this.products,
    this.categoryId2,
    this.supplier,
  );
}

class WithOfferError extends ProductStateSupllier {
  final String errorMessage;

  WithOfferError(this.errorMessage);
}
