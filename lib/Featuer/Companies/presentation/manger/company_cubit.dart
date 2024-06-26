import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Auth/cubit/user_cubit_cubit.dart';
import '../../company_repo/comany_repo._implement.dart';
import '../../data/company_model.dart';
import 'company_state.dart';

class DataCubitCompany extends Cubit<DataState> {
  final DataRepository dataRepository;

  DataCubitCompany(this.dataRepository) : super(DataInitial());

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences

    if (token == null) {
      emit(DataError(message: 'Authentication token not found'));
      return;
    }

    Dio().options.headers['Authorization'] = 'Bearer $token';
    try {
      emit(DataLoading());
      final data = await dataRepository
          .fetchData(); // استخدام Dio لجلب البيانات من الـ API

      // تحويل البيانات إلى نماذج
      List<Offer> offers = (data['offers'] as List)
          .map((offerJson) => Offer.fromJson(offerJson))
          .toList();
      List<SupplierModel> suppliers = (data['suppliers'] as List)
          .map((supplierJson) => SupplierModel.fromJson(supplierJson))
          .toList();

      // إصدار الحالة الناجحة مع البيانات المحولة
      emit(DataLoaded(offers: offers, suppliers: suppliers));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(DataError(message: errorMessage));
    } catch (e) {
      emit(DataError(message: "An unexpected error occurred: ${e.toString()}"));
    }
  }
}
