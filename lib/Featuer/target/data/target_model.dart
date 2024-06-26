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
    required this.supplierstorename,
    required this.id,
    required this.supplierId,
    required this.startingDate,
    required this.expiringDate,
    required this.minPrice,
    required this.discountPrice,
    required this.pivot,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'],
      supplierId: json['supplier_id'],
      startingDate: json['starting_date'],
      supplierstorename: json['supplier_store_name'],

      // status: json['status']?.toString(),
      expiringDate: json['expiring_date'],
      minPrice: json['min_bill_price'].toDouble(),
      discountPrice: json['discount_price'].toDouble(),
      pivot: Pivot.fromJson(json['pivot']),
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
      marketId: json['market_id'],
      goalId: json['goal_id'],
    );
  }
}
