// class Market {
//   final int id;
//   final int marketCategoryId;
//   final int cityId;
//   final String firstName;
//   final String middleName;
//   final String lastName;
//   final String storeName;
//   final String phoneNumber;
//   final String representatorCode;
//   final bool isSubscribed;
//   final String subscriptionExpiresAt;
//   final String status;
//   final String createdFrom;
//   final String cityName;
//   final String categoryName;

//   Market({
//     required this.id,
//     required this.marketCategoryId,
//     required this.cityId,
//     required this.firstName,
//     required this.middleName,
//     required this.lastName,
//     required this.storeName,
//     required this.phoneNumber,
//     required this.representatorCode,
//     required this.isSubscribed,
//     required this.subscriptionExpiresAt,
//     required this.status,
//     required this.createdFrom,
//     required this.cityName,
//     required this.categoryName,
//   });

//   factory Market.fromJson(Map<String, dynamic> json) {
//     return Market(
//       id: json['id'],
//       marketCategoryId: json['market_category_id'],
//       cityId: json['city_id'],
//       firstName: json['first_name'],
//       middleName: json['middle_name'],
//       lastName: json['last_name'],
//       storeName: json['store_name'],
//       phoneNumber: json['phone_number'],
//       representatorCode: json['representator_code'],
//       isSubscribed: json['is_subscribed'] == 1,
//       subscriptionExpiresAt: json['subscription_expires_at'],
//       status: json['status'],
//       createdFrom: json['created_from'],
//       cityName: json['city_name'],
//       categoryName: json['category_name'],
//     );
//   }
// }

// class LoginResponse {
//   final String message;
//   final String accessToken;
//   final String refreshToken;
//   final Market market;

//   LoginResponse({
//     required this.message,
//     required this.accessToken,
//     required this.refreshToken,
//     required this.market,
//   });

//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       message: json['message'],
//       accessToken: json['access_token'],
//       refreshToken: json['refresh_token'],
//       market: Market.fromJson(json['market']),
//     );
//   }
// }

class Market {
  final int id;
  final int marketCategoryId;
  final int cityId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String storeName;
  final String phoneNumber;
  final String representatorCode;
  final bool isSubscribed;
  final String subscriptionExpiresAt;
  final String status;
  final String createdFrom;
  final String cityName;
  final String categoryName;

  Market({
    required this.id,
    required this.marketCategoryId,
    required this.cityId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.storeName,
    required this.phoneNumber,
    required this.representatorCode,
    required this.isSubscribed,
    required this.subscriptionExpiresAt,
    required this.status,
    required this.createdFrom,
    required this.cityName,
    required this.categoryName,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      id: json['id'] ?? 0,
      marketCategoryId: json['market_category_id'] ?? 0,
      cityId: json['city_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      storeName: json['store_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      representatorCode: json['representator_code'] ?? '',
      isSubscribed: json['is_subscribed'] == 1,
      subscriptionExpiresAt: json['subscription_expires_at'] ?? '',
      status: json['status'] ?? '',
      createdFrom: json['created_from'] ?? '',
      cityName: json['city_name'] ?? '',
      categoryName: json['category_name'] ?? '',
    );
  }
}

class LoginResponse {
  final String message;
  final String accessToken;
  final String refreshToken;
  final Market market;

  LoginResponse({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.market,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      market: json['market'] != null
          ? Market.fromJson(json['market'])
          : Market(
              id: 0,
              marketCategoryId: 0,
              cityId: 0,
              firstName: '',
              middleName: '',
              lastName: '',
              storeName: '',
              phoneNumber: '',
              representatorCode: '',
              isSubscribed: false,
              subscriptionExpiresAt: '',
              status: '',
              createdFrom: '',
              cityName: '',
              categoryName: '',
            ),
    );
  }
}
