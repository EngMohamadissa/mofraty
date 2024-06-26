class Market {
  final int id;
  final int marketCategoryId;
  final int cityId;
  final String cityname;
  final String locationdetails;

  final String firstName;
  final String middleName;
  final String lastName;
  final String storeName;
  final String categoryname;

  final String phoneNumber;
  final String representatorCode;
  final bool isSubscribed;
  final String subscriptionExpiresAt;
  final String status;
  final String createdFrom;

  Market(
      {required this.id,
      required this.marketCategoryId,
      required this.cityId,
      required this.cityname,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.storeName,
      required this.categoryname,
      required this.phoneNumber,
      required this.representatorCode,
      required this.isSubscribed,
      required this.subscriptionExpiresAt,
      required this.status,
      required this.createdFrom,
      required this.locationdetails});

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      id: json['id'],
      marketCategoryId: json['market_category_id'],
      cityId: json['city_id'],
      cityname: json['city_name'],
      locationdetails: json['location_details'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      storeName: json['store_name'],
      categoryname: json['category_name'],
      phoneNumber: json['phone_number'],
      representatorCode: json['representator_code'],
      isSubscribed: json['is_subscribed'] == 1,
      subscriptionExpiresAt: json['subscription_expires_at'],
      status: json['status'],
      createdFrom: json['created_from'],
    );
  }
}
