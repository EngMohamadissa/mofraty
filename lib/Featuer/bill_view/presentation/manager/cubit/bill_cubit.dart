import 'package:dio/dio.dart';

import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Auth/cubit/user_cubit_cubit.dart';
import '../../modelbill/bill.dart';

enum BillType { current, previous }

class BillCubitGet extends Cubit<BillStateGet> {
  final Dio dio;

  BillCubitGet({required this.dio}) : super(BillInitial());

  Future<void> getBills(BillType type) async {
    dio.options.headers['Content-Type'] =
        'application/json'; // Set content type
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences

    if (token == null) {
      emit(BillError(message: 'Authentication token not found'));
      return;
    }

    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      emit(BillLoading());

      final statusBill = type == BillType.current ? 'حالية' : 'سابقة';
      final response = await dio.get(
          'https://backend.almowafraty.com/api/v1/markets/bills?status=$statusBill');
      final List<Bill> bills = (response.data['bills'] as List)
          .map((billJson) => Bill.fromJson(billJson))
          .toList();

      emit(BillLoaded(bills: bills, statusBill: statusBill));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(BillError(message: errorMessage));
    } catch (e) {
      emit(BillError(message: "An unexpected error occurred: ${e.toString()}"));
    }
  }

  void updateInvoice(Map<String, dynamic> body, num? id) async {
    dio.options.headers['Content-Type'] =
        'application/json'; // Set content type
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences

    if (token == null) {
      emit(BillError(message: 'Authentication token not found'));
      return;
    }

    dio.options.headers['Authorization'] = 'Bearer $token';
    emit(InvoiceLoading());
    try {
      final response = await dio.put(
        'https://backend.almowafraty.com/api/v1/markets/bills/$id', // استبدل بنقطة النهاية الخاصة ب API
        data: body,
      );
      if (response.statusCode == 200) {
        emit(InvoiceSuccess(response.data['message']));
      } else {
        emit(InvoiceError(
            'Failed to update invoice. Status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(InvoiceError(errorMessage));
    } catch (e) {
      emit(InvoiceError("An unexpected error occurred: ${e.toString()}"));
    }
  }

  void deleteBill(num billId) async {
    dio.options.headers['Content-Type'] =
        'application/json'; // Set content type
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences

    if (token == null) {
      emit(BillError(message: 'Authentication token not found'));
      return;
    }

    dio.options.headers['Authorization'] = 'Bearer $token';
    emit(BillDeletLoading());
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.delete(
        'https://backend.almowafraty.com/api/v1/markets/bills/$billId',
      );
      emit(BillDeletSuccess(response.data['message']));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(BillDeletFailure(errorMessage));
    } catch (e) {
      emit(BillDeletFailure("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
