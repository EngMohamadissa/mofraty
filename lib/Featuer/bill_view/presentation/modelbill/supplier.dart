import 'product.dart';

class Supplier {
  num? id;
  num? supplierCategoryId;
  num? cityId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? storeName;
  String? phoneNumber;
  num? minBillPrice;
  num? minSellingQuantity;
  dynamic deliveryDuration;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProductBill>? products;

  Supplier({
    this.id,
    this.supplierCategoryId,
    this.cityId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.storeName,
    this.phoneNumber,
    this.minBillPrice,
    this.minSellingQuantity,
    this.deliveryDuration,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: num.tryParse(json['id'].toString()),
        supplierCategoryId:
            num.tryParse(json['supplier_category_id'].toString()),
        cityId: num.tryParse(json['city_id'].toString()),
        firstName: json['first_name']?.toString(),
        middleName: json['middle_name']?.toString(),
        lastName: json['last_name']?.toString(),
        storeName: json['store_name']?.toString(),
        phoneNumber: json['phone_number']?.toString(),
        minBillPrice: num.tryParse(json['min_bill_price'].toString()),
        minSellingQuantity:
            num.tryParse(json['min_selling_quantity'].toString()),
        deliveryDuration: json['delivery_duration'],
        status: json['status']?.toString(),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.tryParse(json['updated_at'].toString()),
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => ProductBill.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (supplierCategoryId != null)
          'supplier_category_id': supplierCategoryId,
        if (cityId != null) 'city_id': cityId,
        if (firstName != null) 'first_name': firstName,
        if (middleName != null) 'middle_name': middleName,
        if (lastName != null) 'last_name': lastName,
        if (storeName != null) 'store_name': storeName,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        if (minBillPrice != null) 'min_bill_price': minBillPrice,
        if (minSellingQuantity != null)
          'min_selling_quantity': minSellingQuantity,
        if (deliveryDuration != null) 'delivery_duration': deliveryDuration,
        if (status != null) 'status': status,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (updatedAt != null) 'updated_at': updatedAt?.toIso8601String(),
        if (products != null)
          'products': products?.map((e) => e.toJson()).toList(),
      };
}
