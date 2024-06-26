// class ProductTarget {
//   final int? id;
//   final int? productCategoryId;
//   final String? name;
//   final String? description;
//   final int? size;
//   final String? sizeOf;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? productId;
//   final int? supplierId;
//   final double? price;
//   final int? maxSellingQuantity;
//   final bool? isAvailable;
//   final bool? hasOffer;
//   final double? offerPrice;
//   int? maxOfferQuantity;
//   final DateTime? offerExpiresAt;
//   final List<dynamic>? image; // يفضل تحديد نوع بيانات أكثر تحديدًا

//   ProductTarget({
//     this.id,
//     this.productCategoryId,
//     this.name,
//     this.description,
//     this.size,
//     this.sizeOf,
//     this.createdAt,
//     this.updatedAt,
//     this.productId,
//     this.supplierId,
//     this.price,
//     this.maxSellingQuantity,
//     this.isAvailable,
//     this.hasOffer,
//     this.offerPrice,
//     this.maxOfferQuantity,
//     this.offerExpiresAt,
//     this.image,
//   });

//   factory ProductTarget.fromJson(Map<String, dynamic> json) {
//     return ProductTarget(
//       id: json['id'] as int?,
//       productCategoryId: json['product_category_id'] as int?,
//       name: json['name'] as String?,
//       description: json['discription'] as String?,
//       size: json['size'] as int?,
//       sizeOf: json['size_of'] as String?,
//       createdAt: json['created_at'] != null
//           ? DateTime.parse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//       productId: json['product_id'] as int?,
//       supplierId: json['supplier_id'] as int?,
//       price: (json['price'] as num?)?.toDouble(),
//       maxSellingQuantity: json['max_selling_quantity'] as int?,
//       isAvailable: json['is_available'] == 1,
//       hasOffer: json['has_offer'] == 1,
//       offerPrice: (json['offer_price'] as num?)?.toDouble(),
//       maxOfferQuantity: json['max_offer_quantity'] as int?,
//       offerExpiresAt: json['offer_expires_at'] != null
//           ? DateTime.parse(json['offer_expires_at'])
//           : null,
//       image: json['image'] as List<dynamic>?,
//     );
//   }
// }
