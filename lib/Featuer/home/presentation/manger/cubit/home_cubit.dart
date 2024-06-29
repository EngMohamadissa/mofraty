// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/Featuer/Auth/login/presentation/view/login_view.dart';
import 'package:eghyptproject/Featuer/home/data/home_model.dart';
import 'package:eghyptproject/core/utils/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<SupplierState> {
  HomeCubit() : super(SupplierInitial());
  void loadSuppliers(String token) async {
    emit(SupplierLoading());

    try {
      // إنشاء instance من Dio
      final dio = Dio();
      // إعداد الـ headers لتضمين الرمز المميز
      dio.options.headers['Authorization'] = 'Bearer $token';
      // استخدم Dio لجلب البيانات من الـ API
      final response = await dio
          .get('https://backend.almowafraty.com/api/v1/markets/starting-page');

      if (response.statusCode == 401) {
        emit(SupplierErrortoken());
      }

      final data = response.data;
      final supplierCategories = (data['supplier_categories'] as List)
          .map((e) => HomeModel.fromJson(e))
          .toList();
      final offerImages =
          (data['offers'] as List).map((e) => e['image'] as String).toList();
      emit(SupplierLoaded(supplierCategories, offerImages));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(SupplierError(errorMessage));
    } catch (error) {
      emit(SupplierError(error.toString()));
    }
  }
}
