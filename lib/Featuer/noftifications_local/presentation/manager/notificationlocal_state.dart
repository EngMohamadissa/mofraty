import 'package:eghyptproject/Featuer/noftifications_local/data/notification_modle.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationLoaded(this.notifications);
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}

class readNotificationInitial extends NotificationState {}

class readNotificationLoading extends NotificationState {}

class readNotificationLoaded extends NotificationState {
  final String message;
  readNotificationLoaded(this.message);
}

class readNotificationError extends NotificationState {
  final String message;
  readNotificationError(this.message);
}
