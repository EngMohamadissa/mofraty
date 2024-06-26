import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Companies/presentation/manger/slidarcomanies_state.dart';
import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OffersSliderCompanyCubit extends Cubit<OffersSliderCompanyState> {
  final Dio _dio;

  OffersSliderCompanyCubit({Dio? dio})
      : _dio = dio ?? Dio(),
        super(OffersSliderCompanyInitial());

  Future<void> getOffersCompanySlider(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    try {
      emit(OffersSliderCompanyLoading());
      final options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      // استخدم dio مع الـ headers لجلب البيانات من الـ API
      final response = await _dio.get(
        'https://backend.almowafraty.com/api/v1/markets/suppliers?type=$type',
        options: options,
      );

      // final offers = (response.data['offers'] as List)
      //     .map((e) => Offer.fromJson(e))
      //     .toList();

      final offers = (response.data['offers'] as List)
          .map((e) => Offer.fromJson(e))
          .toList();

      emit(OffersSliderCompanyLoaded(offers: offers));
    } catch (e) {
      emit(OffersSliderCompanyError(message: e.toString()));
    }
  }
}
