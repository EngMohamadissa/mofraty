// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/products/data/model/product_model.dart';
// import 'package:eghyptproject/Featuer/products/presentation/manger/product_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductCubit extends Cubit<ProductState> {
//   final Dio dio;
//   final String token;

//   ProductCubit(this.dio, this.token) : super(ProductInitial());

//   void getProducts(int supplierId) async {
//     emit(ProductLoading());
//     try {
//       final response = await dio.get(
//         'https://almowafraty.com/api/v1/markets/suppliers/$supplierId',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );
//       final products = (response.data['products'] as List)
//           .map((productJson) => Product.fromJson(productJson))
//           .toList();
//       emit(ProductLoaded(products));
//     } on DioException catch (e) {
//       emit(ProductError(e.response?.data['message']));
//     }
//   }
// }