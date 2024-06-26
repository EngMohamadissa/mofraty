class SupplierModel {
  final int id;
  final int supplierCategoryId;
  final int cityId;
  final String location;

  final String firstName;
  final String middleName;
  final String lastName;
  final String storeName;
  final String? categoryName;
  final String phoneNumber;
  final double minBillPrice;
  final int minSellingQuantity;
  final String? deliveryDuration;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String image;

  SupplierModel({
    required this.id,
    required this.supplierCategoryId,
    required this.cityId,
    this.categoryName,
    required this.location,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.storeName,
    required this.phoneNumber,
    required this.minBillPrice,
    required this.minSellingQuantity,
    this.deliveryDuration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      supplierCategoryId: json['supplier_category_id'],
      cityId: json['city_id'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      storeName: json['store_name'],
      phoneNumber: json['phone_number'],
      minBillPrice: json['min_bill_price'].toDouble(),
      minSellingQuantity: json['min_selling_quantity'],
      deliveryDuration: json['delivery_duration'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      categoryName: json['category_name'],
      location: json['location_details'],
      image: json['image'],
    );
  }
}

class ProductCategory {
  final int id;
  final String name;

  ProductCategory({
    required this.id,
    required this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Product {
  final int id;
  final int productCategoryId;
  String? name;
  final String discription;
  final int size;
  final String sizeOf;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int productId;
  final int supplierId;
  double price;
  final int maxSellingQuantity;
  final bool isAvailable;
  final bool hasOffer;
  double offerPrice;
  final int maxOfferQuantity;
  final DateTime offerExpiresAt;
  final List<String?>? images;
  final String productCategory;
  int quantity;
  String supllierName;
  String supplierMinprice;
  String supplierMinQuantity;

  Product({
    required this.id,
    required this.productCategoryId,
    required this.name,
    required this.discription,
    required this.size,
    required this.sizeOf,
    this.createdAt,
    this.updatedAt,
    required this.productId,
    required this.supplierId,
    required this.price,
    required this.maxSellingQuantity,
    required this.isAvailable,
    required this.hasOffer,
    required this.offerPrice,
    required this.maxOfferQuantity,
    required this.offerExpiresAt,
    required this.images,
    required this.productCategory,
    this.quantity = 1,
    this.supllierName = 'jafar',
    this.supplierMinQuantity = '',
    this.supplierMinprice = '',
  });
  @override
  String toString() {
    return '{id: $id, name: $name, description: $discription, price: $price, offerPrice: $offerPrice}';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productCategoryId: json['product_category_id'],
      name: json['name'],
      discription: json['discription'],
      size: json['size'],
      sizeOf: json['size_of'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      productId: json['product_id'],
      supplierId: json['supplier_id'],
      price: json['price'].toDouble(),
      maxSellingQuantity: json['max_selling_quantity'],
      isAvailable: json['is_available'] == 1,
      hasOffer: json['has_offer'] == 1,
      offerPrice: json['offer_price'].toDouble(),
      maxOfferQuantity: json['max_offer_quantity'],
      offerExpiresAt: DateTime.parse(json['offer_expires_at']),
      images: List<String>.from(json['image']),
      productCategory: json['product_category'],
    );
  }
}
