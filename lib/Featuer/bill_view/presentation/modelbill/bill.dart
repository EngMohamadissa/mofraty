import 'product.dart';
import 'supplier.dart';

class Bill {
  num? id;
  num? marketId;
  num? supplierId;
  num? paymentMethodId;
  num? totalPrice;
  num? goaldiscount;
  num? totalpriceafterdiscount;
  num? recievedPrice;
  String? status;
  num? hasAdditionalCost;
  String? marketNote;
  String? rejectionReason;
  String? deliveryDuration;
  String? createdAt;
  DateTime? updatedAt;
  String? createdFrom;
  String? paymentMethod;
  num? additionalPrice;
  num? waffarnalak;
  bool? updatable;
  List<ProductBill>? products;
  Supplier? supplier;

  Bill({
    this.id,
    this.marketId,
    this.supplierId,
    this.paymentMethodId,
    this.totalPrice,
    this.totalpriceafterdiscount,
    this.goaldiscount,
    this.recievedPrice,
    this.status,
    this.hasAdditionalCost,
    this.marketNote,
    this.rejectionReason,
    this.deliveryDuration,
    this.createdAt,
    this.updatedAt,
    this.createdFrom,
    this.paymentMethod,
    this.additionalPrice,
    this.waffarnalak,
    this.updatable,
    this.products,
    this.supplier,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: num.tryParse(json['id'].toString()),
        marketId: num.tryParse(json['market_id'].toString()),
        supplierId: num.tryParse(json['supplier_id'].toString()),
        paymentMethodId: num.tryParse(json['payment_method_id'].toString()),
        totalPrice: num.tryParse(json['total_price'].toString()),
        goaldiscount: num.tryParse(json['goal_discount'].toString()),
        totalpriceafterdiscount:
            num.tryParse(json['total_price_after_discount'].toString()),
        recievedPrice: num.tryParse(json['recieved_price'].toString()),
        status: json['status']?.toString(),
        hasAdditionalCost: num.tryParse(json['has_additional_cost'].toString()),
        marketNote: json['market_note']?.toString(),
        rejectionReason: json['rejection_reason']?.toString(),
        deliveryDuration: json['delivery_duration']?.toString(),
        createdAt: json['created_at']?.toString(),
        // createdAt: json['created_at'] == null
        //     ? null
        //     : DateTime.tryParse(json['created_at'].toString()),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.tryParse(json['updated_at'].toString()),
        createdFrom: json['created_at_formatted']?.toString(),
        paymentMethod: json['payment_method']?.toString(),
        additionalPrice: num.tryParse(json['additional_price'].toString()),
        waffarnalak: num.tryParse(json['waffarnalak'].toString()),
        updatable: json['updatable']?.toString().contains("true"),
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => ProductBill.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        supplier: json['supplier'] == null
            ? null
            : Supplier.fromJson(Map<String, dynamic>.from(json['supplier'])),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (marketId != null) 'market_id': marketId,
        if (supplierId != null) 'supplier_id': supplierId,
        if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
        if (totalPrice != null) 'total_price': totalPrice,
        if (recievedPrice != null) 'recieved_price': recievedPrice,
        if (status != null) 'status': status,
        if (hasAdditionalCost != null) 'has_additional_cost': hasAdditionalCost,
        if (marketNote != null) 'market_note': marketNote,
        if (rejectionReason != null) 'rejection_reason': rejectionReason,
        if (deliveryDuration != null) 'delivery_duration': deliveryDuration,
        if (createdAt != null) 'created_at': createdAt,
        if (updatedAt != null) 'updated_at': updatedAt?.toIso8601String(),
        if (createdFrom != null) 'created_from': createdFrom,
        if (paymentMethod != null) 'payment_method': paymentMethod,
        if (additionalPrice != null) 'additional_price': additionalPrice,
        if (waffarnalak != null) 'waffarnalak': waffarnalak,
        if (updatable != null) 'updatable': updatable,
        if (products != null)
          'products': products?.map((e) => e.toJson()).toList(),
        if (supplier != null) 'supplier': supplier?.toJson(),
      };
}
