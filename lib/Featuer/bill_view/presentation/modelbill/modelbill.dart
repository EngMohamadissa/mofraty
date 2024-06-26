import 'bill.dart';

class Modelbill {
  List<Bill>? bills;

  Modelbill({this.bills});

  factory Modelbill.fromJson(Map<String, dynamic> json) => Modelbill(
        bills: (json['bills'] as List<dynamic>?)
            ?.map((e) => Bill.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        if (bills != null) 'bills': bills?.map((e) => e.toJson()).toList(),
      };
}
