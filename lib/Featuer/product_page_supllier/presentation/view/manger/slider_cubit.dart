// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/slider_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OffersSliderCubit extends Cubit<OffersSliderState> {
//   final Dio _dio;

//   OffersSliderCubit({Dio? dio})
//       : _dio = dio ?? Dio(),
//         super(OffersSliderInitial());

//   void getOffersSlider(num id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');

//     try {
//       emit(OffersSliderLoading());
//       final options = Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       // استخدم dio مع الـ headers لجلب البيانات من الـ API
//       final response = await _dio.get(
//         'https://backend.almowafraty.com/api/v1/markets/suppliers/$id',
//         options: options,
//       );

//       // final offers = (response.data['offers'] as List)
//       //     .map((e) => Offer.fromJson(e))
//       //     .toList();

//       final offers = (response.data['slider_offers'] as List)
//           .map((e) => Offer.fromJson(e))
//           .toList();

//       emit(OffersSliderLoaded(offers: offers));
//     } catch (e) {
//       emit(OffersSliderError(message: e.toString()));
//     }
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/slider_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OffersSliderCubit extends Cubit<OffersSliderState> {
//   final Dio _dio;

//   OffersSliderCubit({Dio? dio})
//       : _dio = dio ?? Dio(),
//         super(OffersSliderInitial());

//   Future<void> getOffersSlider(num id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');

//     try {
//       emit(OffersSliderLoading());
//       final options = Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       final response = await _dio.get(
//         'https://backend.almowafraty.com/api/v1/markets/suppliers/$id',
//         options: options,
//       );

//       final offers = (response.data['slider_offers'] as List)
//           .map((e) => Offer.fromJson(e))
//           .toList();

//       if (!isClosed) emit(OffersSliderLoaded(offers: offers));
//     } catch (e) {
//       if (!isClosed) emit(OffersSliderError(message: e.toString()));
//     }
//   }

//   @override
//   bool get isClosed =>
//       state is! OffersSliderInitial && state is! OffersSliderLoading;

//   @override
//   Future<void> close() {
//     // تنظيف الموارد هنا إذا لزم الأمر
//     return super.close();
//   }
// }
