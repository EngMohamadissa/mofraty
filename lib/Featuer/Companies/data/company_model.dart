class Offer {
  final int id;
  final int supplierId;
  final String? image;

  Offer({
    required this.id,
    required this.supplierId,
    this.image,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] ?? 0,
      supplierId: json['supplier_id'] ?? 0,
      image: json['image'],
    );
  }
}

class Supplier {
  final int id;
  final int supplierCategoryId;
  final int cityId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String storeName;
  final String phoneNumber;
  final double minBillPrice;
  final int minSellingQuantity;
  final String? deliveryDuration;
  final String status;
  final String createdAt;
  final String updatedAt;

  Supplier({
    required this.id,
    required this.supplierCategoryId,
    required this.cityId,
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
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'] ?? 0,
      supplierCategoryId: json['supplier_category_id'] ?? 0,
      cityId: json['city_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      storeName: json['store_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      minBillPrice: (json['min_bill_price'] != null
          ? json['min_bill_price'].toDouble()
          : 0.0),
      minSellingQuantity: json['min_selling_quantity'] ?? 0,
      deliveryDuration: json['delivery_duration'],
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
