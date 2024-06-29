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
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      notifiableType: json['notifiable_type'] ?? '',
      notifiableId: json['notifiable_id'] ?? 0,
      supplier: SupplierModel.fromJson(json['data']['supplier_id'] ?? {}),
      message: json['data']['message'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
    );
  }
}
