class Goal {
  final int id;
  final int supplierId;
  final String startingDate;
  final String expiringDate;
  final String supplierstorename;
  final double minPrice;
  final double discountPrice;
  final Pivot pivot;

  Goal({
    required this.id,
    required this.supplierId,
    required this.startingDate,
    required this.expiringDate,
    required this.supplierstorename,
    required this.minPrice,
    required this.discountPrice,
    required this.pivot,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'] ?? 0,
      supplierId: json['supplier_id'] ?? 0,
      startingDate: json['starting_date'] ?? '',
      expiringDate: json['expiring_date'] ?? '',
      supplierstorename: json['supplier_store_name'] ?? '',
      minPrice: (json['min_bill_price'] != null
          ? json['min_bill_price'].toDouble()
          : 0.0),
      discountPrice: (json['discount_price'] != null
          ? json['discount_price'].toDouble()
          : 0.0),
      pivot: json['pivot'] != null
          ? Pivot.fromJson(json['pivot'])
          : Pivot(marketId: 0, goalId: 0),
    );
  }
}

class Pivot {
  final int marketId;
  final int goalId;

  Pivot({
    required this.marketId,
    required this.goalId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      marketId: json['market_id'] ?? 0,
      goalId: json['goal_id'] ?? 0,
    );
  }
}
