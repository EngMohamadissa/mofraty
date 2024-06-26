// class Market {
//   final String firstName;
//   final String middleName;
//   final String lastName;
//   final String phoneNumber;
//   final String storeName;
//   final String cityId;
//   final String representatorCode;
//   final String marketCategoryId;
//   final DateTime subscriptionExpiresAt;
//   final int id;
//   final String createdFrom;

//   Market({
//     required this.firstName,
//     required this.middleName,
//     required this.lastName,
//     required this.phoneNumber,
//     required this.storeName,
//     required this.cityId,
//     required this.representatorCode,
//     required this.marketCategoryId,
//     required this.subscriptionExpiresAt,
//     required this.id,
//     required this.createdFrom,
//   });

//   factory Market.fromJson(Map<String, dynamic> json) {
//     return Market(
//       firstName: json['first_name'],
//       middleName: json['middle_name'],
//       lastName: json['last_name'],
//       phoneNumber: json['phone_number'],
//       storeName: json['store_name'],
//       cityId: json['city_id'],
//       representatorCode: json['representator_code'],
//       marketCategoryId: json['market_category_id'],
//       subscriptionExpiresAt: DateTime.parse(json['subscription_expires_at']),
//       id: json['id'],
//       createdFrom: json['created_from'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'first_name': firstName,
//       'middle_name': middleName,
//       'last_name': lastName,
//       'phone_number': phoneNumber,
//       'store_name': storeName,
//       'city_id': cityId,
//       'representator_code': representatorCode,
//       'market_category_id': marketCategoryId,
//       'subscription_expires_at': subscriptionExpiresAt.toIso8601String(),
//       'id': id,
//       'created_from': createdFrom,
//     };
//   }
// }
