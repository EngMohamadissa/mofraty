import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/mydata_modle.dart';
import 'mydata_cubit_state.dart';

class MydataCubit extends Cubit<MydataState> {
  final Dio dio = Dio();

  MydataCubit() : super(MydataInitial()) {
    // تعيين رأس الـ Authorization لجميع الطلبات الصادرة من هذا الـ dio
  }

  void getMarket() async {
    dio.options.headers['Content-Type'] =
        'application/json'; // Set content type
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences
    dio.options.headers['Authorization'] = 'Bearer $token';
    final userId = prefs.getInt('id');
    if (token == null) {
      emit(MydataError('Authentication token not found'));
      return;
    }
    emit(MydataLoading());
    try {
      final response = await dio.get(
          'https://backend.almowafraty.com/api/v1/markets/markets/$userId');
      final firstNamedrawer = response.data['market']['first_name'];
      final market = Market.fromJson(response.data['market']);
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('first_name', firstNamedrawer);

      emit(MydataLoaded(market));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(MydataError(errorMessage));
    } catch (e) {
      emit(MydataError("An unexpected error occurred: ${e.toString()}"));
    }
  }

  Future updateName(
      String firstName, String middleName, String lastName) async {
    dio.options.headers['Content-Type'] =
        'application/json'; // Set content type
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences
    dio.options.headers['Authorization'] = 'Bearer $token';
    final userId = prefs.getInt('id');
    emit(UpdateNameLoading());
    try {
      final response = await dio.put(
        'https://backend.almowafraty.com/api/v1/markets/markets/$userId',
        data: {
          'first_name': firstName,
          'middle_name': middleName,
          'last_name': lastName,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      emit(UpdateNameSuccess(response.data['message']));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(MydataError(errorMessage));
    } catch (e) {
      emit(MydataError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
