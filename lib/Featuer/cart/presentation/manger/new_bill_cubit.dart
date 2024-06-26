import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/Featuer/cart/presentation/manger/new_bill_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define your BillState classes as needed

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(BillInitial());

  final Dio dio = Dio();

  void createBill(List<Map<String, dynamic>> billData2) async {
    dio.options.headers['Content-Type'] = 'application/json';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    // final prefOrderBill = prefs.getString('orders');

    if (token == null) {
      // emit(BillFailure('Authentication token not found'));
      return;
    }

    dio.options.headers['Authorization'] = 'Bearer $token';
    emit(BillLoading());

    try {
      // Decode the JSON string into a List<dynamic>
      final List<dynamic> decodedData = (billData2);

      // Cast each element to Map<String, dynamic>
      final List<Map<String, dynamic>> billData =
          decodedData.cast<Map<String, dynamic>>();

      final response = await dio.post(
        'https://backend.almowafraty.com/api/v1/markets/bills',
        data: {"bills": billData},
      );

      if (response.statusCode == 201) {
        emit(BillSuccess(response.data['message']));
        await clearSharedPreferences();
      }
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(BillFailure(errorMessage));

      // await clearSharedPreferences();
      // print(prefs.getString('orders'));
    }
  }
}

Future<void> clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('orders');
  // Add more keys to remove if needed
}
