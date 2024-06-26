import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/target_model.dart';
import 'target_state.dart';

class GoalCubit extends Cubit<GoalState> {
  final Dio dio = Dio();

  GoalCubit() : super(GoalInitial());

  void getGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      emit(GoalError(message: 'Authentication token not found'));
      return;
    }
    dio.options.headers['Authorization'] = 'Bearer $token';

    emit(GoalLoading());
    try {
      final response =
          await dio.get('https://backend.almowafraty.com/api/v1/markets/goals');
      final data = response.data as Map<String, dynamic>;
      final goals =
          (data['goals'] as List).map((e) => Goal.fromJson(e)).toList();
      emit(GoalLoaded(goals));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(GoalError(message: errorMessage));
    } catch (e) {
      emit(GoalError(message: "An unexpected error occurred: ${e.toString()}"));
    }
  }
}
