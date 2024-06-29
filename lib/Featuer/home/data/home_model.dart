// class Offer {
//   //  الخصائص
// }

// class HomeModel  {
//   final int id;
//   final String type;

//   HomeModel({required this.id, required this.type});

//   factory HomeModel.fromJson(Map<String, dynamic> json) {
//     return HomeModel(
//       id: json['id'],
//       type: json['type'],
//     );
//   }
// }

class HomeModel {
  final int id;
  final String type;

  HomeModel({required this.id, required this.type});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] ?? 0, // تعيين قيمة افتراضية إذا كانت القيمة مساوية لـ Null
      type: json['type'] ??
          '', // تعيين قيمة افتراضية إذا كانت القيمة مساوية لـ Null
    );
  }
}
