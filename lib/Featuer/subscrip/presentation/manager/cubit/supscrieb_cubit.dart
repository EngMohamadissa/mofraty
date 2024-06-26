import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'supscrieb_state.dart';

class SupscriebCubit extends Cubit<SupscriepState> {
  final Dio dio = Dio();

  SupscriebCubit() : super(SubscripInitial());

  void getsupscrieb() async {
    dio.options.headers['Content-Type'] =
        'application/json'; // Set content type
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences
    dio.options.headers['Authorization'] = 'Bearer $token';

    if (token == null) {
      emit(SubscpriFailure('Authentication token not found'));
      return;
    }

    emit(SubscripLoading());

    try {
      final response = await dio.get(
          'https://backend.almowafraty.com/api/v1/markets/renew-subscription');

      emit(SubscripSucces(message: response.data['message']));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(SubscpriFailure(errorMessage));
    } catch (e) {
      emit(SubscpriFailure("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
