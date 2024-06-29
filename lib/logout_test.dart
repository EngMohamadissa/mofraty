// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserCubitCubitlog extends Cubit<UserCubitStatetest> {
//   UserCubitCubitlog() : super(LogoutLoadingtestinitial());

//   logouttest() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs
//         .getString('access_token'); // Retrieve token from shared preferences

//     if (token == null) {
//       emit(LogoutFailuretest(errorMessage: 'Authentication token not found'));
//       return;
//     }

//     Dio().options.headers['Authorization'] = 'Bearer $token';

//     emit(LogoutLoadingtest());
//     try {
//       final response = await Dio()
//           .get('https://backend.almowafraty.com/api/v1/markets/auth/logout');
//       emit(LogoutSuccesstest(message: response.data['message']));
//       return response.data;
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       emit(LogoutFailuretest(errorMessage: errorMessage));
//     } catch (e) {
//       emit(LogoutFailuretest(
//           errorMessage: "An unexpected error occurred: ${e.toString()}"));
//     }
//   }
// }

// @immutable
// sealed class UserCubitStatetest {}

// class LogoutLoadingtestinitial extends UserCubitStatetest {}

// class LogoutLoadingtest extends UserCubitStatetest {}

// class LogoutSuccesstest extends UserCubitStatetest {
//   final String message;
//   LogoutSuccesstest({required this.message});
// }

// class LogoutFailuretest extends UserCubitStatetest {
//   final String errorMessage;
//   LogoutFailuretest({required this.errorMessage});
// }
