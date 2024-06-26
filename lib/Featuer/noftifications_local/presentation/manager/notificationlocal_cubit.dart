import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/Featuer/noftifications_local/data/notification_modle.dart';
import 'package:eghyptproject/Featuer/noftifications_local/presentation/manager/notificationlocal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final dio = Dio();

  NotificationCubit(Dio dio) : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences
    dio.options.headers['Authorization'] = 'Bearer $token';
    if (token == null) {
      emit(NotificationError('Authentication token not found'));
      return;
    }
    try {
      emit(NotificationLoading());
      final response = await dio
          .get('https://backend.almowafraty.com/api/v1/markets/notifications');
      final List<dynamic> data = response.data['notifications'];

      // final List<NotificationModel> notifications = response
      //     .data['notifications']
      //     .map((json) => NotificationModel.fromJson(json))
      //     .toList();
      final notifications =
          data.map((billJson) => NotificationModel.fromJson(billJson)).toList();
      emit(NotificationLoaded(notifications));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(NotificationError(errorMessage));
    } catch (e) {
      emit(NotificationError("Failed to fetch notifications"));
    }
  }

  Future readNotifications(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences
    dio.options.headers['Authorization'] = 'Bearer $token';
    if (token == null) {
      emit(readNotificationError('Authentication token not found'));
      return;
    }
    try {
      emit(readNotificationLoading());
      final response = await dio.get(
          'https://backend.almowafraty.com/api/v1/markets/notifications/$id');

      // final List<NotificationModel> notifications = response
      //     .data['notifications']
      //     .map((json) => NotificationModel.fromJson(json))
      //     .toList();

      emit(readNotificationLoaded(response.data['message']));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(readNotificationError(errorMessage));
    } catch (e) {
      emit(readNotificationError("Failed to fetch notifications"));
    }
  }
}
