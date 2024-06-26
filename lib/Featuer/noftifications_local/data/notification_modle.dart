// lib/models/notification_model.dart
import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';

class NotificationModel {
  final String id;
  final String type;
  final String notifiableType;
  final int notifiableId;
  final SupplierModel supplier;
  final String message;
  final String createdAt;
  final DateTime updatedAt;
  final DateTime? readAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.supplier,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    this.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: json['type'],
      notifiableType: json['notifiable_type'],
      notifiableId: json['notifiable_id'],
      supplier: SupplierModel.fromJson(json['data']['supplier_id']),
      message: json['data']['message'],
      createdAt: json['created_at'],
      updatedAt: DateTime.parse(json['updated_at']),
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
    );
  }
}

class Supplier {
  final int id;
  final int supplierCategoryId;
  final int cityId;
  final String locationDetails;
  final String firstName;
  final String middleName;
  final String lastName;
  final String storeName;
  final String phoneNumber;
  final String deviceToken;
  final int minBillPrice;
  final int minSellingQuantity;
  final String deliveryDuration;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryName;
  final String cityName;
  //final List<DistributionLocation> distributionLocations;

  Supplier({
    required this.id,
    required this.supplierCategoryId,
    required this.cityId,
    required this.locationDetails,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.storeName,
    required this.phoneNumber,
    required this.deviceToken,
    required this.minBillPrice,
    required this.minSellingQuantity,
    required this.deliveryDuration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
    required this.cityName,
    // required this.distributionLocations,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    // var distributionLocationsFromJson = json['distribution_locations'] as List;
    // List<DistributionLocation> distributionLocationList =
    //     distributionLocationsFromJson
    //         .map((i) => DistributionLocation.fromJson(i))
    //         .toList();

    return Supplier(
      id: json['id'],
      supplierCategoryId: json['supplier_category_id'],
      cityId: json['city_id'],
      locationDetails: json['location_details'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      storeName: json['store_name'],
      phoneNumber: json['phone_number'],
      deviceToken: json['deviceToken'],
      minBillPrice: json['min_bill_price'],
      minSellingQuantity: json['min_selling_quantity'],
      deliveryDuration: json['delivery_duration'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      categoryName: json['category_name'],
      cityName: json['city_name'],
      // distributionLocations: distributionLocationList,
    );
  }
}

// class DistributionLocation {
//   final int id;
//   final int supplierId;
//   final int toCityId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String cityName;
//   final ToCity toCity;

//   DistributionLocation({
//     required this.id,
//     required this.supplierId,
//     required this.toCityId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.cityName,
//     required this.toCity,
//   });

//   factory DistributionLocation.fromJson(Map<String, dynamic> json) {
//     return DistributionLocation(
//       id: json['id'],
//       supplierId: json['supplier_id'],
//       toCityId: json['to_city_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       cityName: json['city_name'],
//       toCity: ToCity.fromJson(json['to_city']),
//     );
//   }
// }

// class ToCity {
//   final int id;
//   final int position;
//   final String name;
//   final int? parentId;

//   ToCity({
//     required this.id,
//     required this.position,
//     required this.name,
//     this.parentId,
//   });

//   factory ToCity.fromJson(Map<String, dynamic> json) {
//     return ToCity(
//       id: json['id'],
//       position: json['position'],
//       name: json['name'],
//       parentId: json['parent_id'],
//     );
//   }
// }


























// // lib/models/notification_model.dart

// class NotificationModel {
//   final String id;
//   final String type;
//   final String notifiableType;
//   final int notifiableId;
//   final String message;
//   final String createdAt;
//   final DateTime updatedAt;
//   final DateTime? readAt;

//   NotificationModel({
//     required this.id,
//     required this.type,
//     required this.notifiableType,
//     required this.notifiableId,
//     required this.message,
//     required this.createdAt,
//     required this.updatedAt,
//     this.readAt,
//   });

//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//       id: json['id'],
//       type: json['type'],
//       notifiableType: json['notifiable_type'],
//       notifiableId: json['notifiable_id'],
//       message: json['data']['message'],
//       createdAt: json['created_at'],
//       updatedAt: DateTime.parse(json['updated_at']),
//       readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
//     );
//   }
// }


