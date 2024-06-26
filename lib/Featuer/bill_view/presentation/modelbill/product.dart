import 'pivot.dart';

class ProductBill {
  num? id;
  num? productCategoryId;
  String? name;
  String? discription;
  num? size;
  String? sizeOf;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  List<String>? image;
  String? productCategory;
  Pivot? pivot;

  ProductBill({
    this.id,
    this.productCategoryId,
    this.name,
    this.discription,
    this.size,
    this.sizeOf,
    // this.createdAt,
    // this.updatedAt,
    this.image,
    this.productCategory,
    this.pivot,
  });

  factory ProductBill.fromJson(Map<String, dynamic> json) => ProductBill(
        id: num.tryParse(json['id'].toString()),
        productCategoryId: num.tryParse(json['product_category_id'].toString()),
        name: json['name']?.toString(),
        discription: json['discription']?.toString(),
        size: num.tryParse(json['size'].toString()),
        sizeOf: json['size_of']?.toString(),
        // createdAt: json['created_at'] == null
        //     ? null
        //     : DateTime.tryParse(json['created_at'].toString()),
        // updatedAt: json['updated_at'] == null
        //     ? null
        //     : DateTime.tryParse(json['updated_at'].toString()),
        image: List<String>.from(json['image'] ?? []),
        productCategory: json['product_category']?.toString(),
        pivot: json['pivot'] == null
            ? null
            : Pivot.fromJson(Map<String, dynamic>.from(json['pivot'])),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (productCategoryId != null) 'product_category_id': productCategoryId,
        if (name != null) 'name': name,
        if (discription != null) 'discription': discription,
        if (size != null) 'size': size,
        if (sizeOf != null) 'size_of': sizeOf,
        // if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        // if (updatedAt != null) 'updated_at': updatedAt?.toIso8601String(),
        if (image != null) 'image': image,
        if (productCategory != null) 'product_category': productCategory,
        if (pivot != null) 'pivot': pivot?.toJson(),
      };
}
