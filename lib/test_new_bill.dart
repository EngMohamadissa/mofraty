// // import 'package:dio/dio.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // class Product {
// //   final int? id;
// //   final int? productCategoryId;
// //   final String? name;
// //   final String? description;
// //   final int? size;
// //   final String? sizeOf;
// //   final DateTime? createdAt;
// //   final DateTime? updatedAt;
// //   final int? productId;
// //   final int? supplierId;
// //   final double? price;
// //   final int? maxSellingQuantity;
// //   final bool? isAvailable;
// //   final bool? hasOffer;
// //   final double? offerPrice;
// //   int? maxOfferQuantity;
// //   final DateTime? offerExpiresAt;
// //   final List<dynamic>? image; // يفضل تحديد نوع بيانات أكثر تحديدًا

// //   Product({
// //     this.id,
// //     this.productCategoryId,
// //     this.name,
// //     this.description,
// //     this.size,
// //     this.sizeOf,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.productId,
// //     this.supplierId,
// //     this.price,
// //     this.maxSellingQuantity,
// //     this.isAvailable,
// //     this.hasOffer,
// //     this.offerPrice,
// //     this.maxOfferQuantity,
// //     this.offerExpiresAt,
// //     this.image,
// //   });

// //   factory Product.fromJson(Map<String, dynamic> json) {
// //     return Product(
// //       id: json['id'] as int?,
// //       productCategoryId: json['product_category_id'] as int?,
// //       name: json['name'] as String?,
// //       description: json['discription'] as String?,
// //       size: json['size'] as int?,
// //       sizeOf: json['size_of'] as String?,
// //       createdAt: json['created_at'] != null
// //           ? DateTime.parse(json['created_at'])
// //           : null,
// //       updatedAt: json['updated_at'] != null
// //           ? DateTime.parse(json['updated_at'])
// //           : null,
// //       productId: json['product_id'] as int?,
// //       supplierId: json['supplier_id'] as int?,
// //       price: (json['price'] as num?)?.toDouble(),
// //       maxSellingQuantity: json['max_selling_quantity'] as int?,
// //       isAvailable: json['is_available'] == 1,
// //       hasOffer: json['has_offer'] == 1,
// //       offerPrice: (json['offer_price'] as num?)?.toDouble(),
// //       maxOfferQuantity: json['max_offer_quantity'] as int?,
// //       offerExpiresAt: json['offer_expires_at'] != null
// //           ? DateTime.parse(json['offer_expires_at'])
// //           : null,
// //       image: json['image'] as List<dynamic>?,
// //     );
// //   }
// // }

// // abstract class BillState {}

// // class BillInitial extends BillState {}

// // class BillLoading extends BillState {}

// // class BillCreated extends BillState {
// //   final String message;

// //   BillCreated(this.message);
// // }

// // class BillError extends BillState {
// //   final String errorMessage;

// //   BillError(this.errorMessage);
// // }

// // class BillCubit extends Cubit<BillState> {
// //   BillCubit({required this.token}) : super(BillInitial()) {
// //     dio.options.headers.addAll({
// //       'Authorization': 'Bearer $token',
// //       'Content-Type': 'application/json', // إضافة Content-Type هنا
// //     });
// //   }

// //   final Dio dio = Dio();
// //   final String token;

// //   void createBill(List<Product> products) async {
// //     assert(!products.any((product) => product == null),
// //         'Product in the list cannot be null');
// //     assert(!products.any((product) => product.id == null),
// //         'Product ID cannot be null');
// //     if (products.any(
// //         (product) => product.id == null || product.maxOfferQuantity == null)) {
// //       emit(BillError('Product ID and quantity cannot be null'));
// //       return;
// //     }
// //     emit(BillLoading());
// //     try {
// //       final response = await dio.post(
// //         'https://backend.almowafraty.com/api/v1/markets/bills',
// //         data: {
// //           'products': products.map((product) {
// //             return {
// //               'id': product.id,
// //               'quantity': product.maxOfferQuantity ?? 1,
// //             };
// //           }).toList(),
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         emit(BillCreated(response.data['message']));
// //       } else {
// //         emit(BillError('Failed to create bill'));
// //       }
// //     } catch (e) {
// //       emit(BillError(e.toString()));
// //     }
// //   }
// // }

// // class BillPagess extends StatelessWidget {
// //   const BillPagess({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     List<Product>? products;

// //     return BlocProvider(
// //       create: (context) => BillCubit(
// //           token: '84|kiZkVuPd2xe1T3h4UdM8GfrDi29xTUG1tMmxhosSfec8c970'),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Create Bill'),
// //         ),
// //         body: BlocConsumer<BillCubit, BillState>(
// //           listener: (context, state) {
// //             if (state is BillCreated) {
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(content: Text(state.message)),
// //               );
// //             } else if (state is BillError) {
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(content: Text(state.errorMessage)),
// //               );
// //             }
// //           },
// //           builder: (context, state) {
// //             if (state is BillLoading) {
// //               return const Center(child: CircularProgressIndicator());
// //             }
// //             return Center(
// //               child: ElevatedButton(
// //                 onPressed: () =>
// //                     context.read<BillCubit>().createBill(products!),
// //                 child: const Text('Create Bill'),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
// import 'package:eghyptproject/Featuer/products/data/model/product_model.dart';
// import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';

// abstract class BillState {}

// class BillInitial extends BillState {}

// class BillLoading extends BillState {}

// class BillSuccess extends BillState {
//   final String message;

//   BillSuccess(this.message);
// }

// class BillFailure extends BillState {
//   final String error;

//   BillFailure(this.error);
// }

// // تعريف الـ Cubit
// class BillCubit extends Cubit<BillState> {
//   Product? product;
//   BillCubit() : super(BillInitial());

//   final Dio dio = Dio(); // تأكد من إعداد Dio مع BaseUrl وأي headers مطلوبة

//   void createBill(List<Product> products) async {
//     dio.options.headers['Content-Type'] =
//         'application/json'; // تعيين Content-Type لـ application/json
//     dio.options.headers['Authorization'] =
//         'Bearer 90|UWTJw8LZb7uezPtAyOQgYI5ZIvRe4cvoMZlirIlT7fd9b636'; // استخدم توكين الوصول الخاص بك هنا
//     emit(BillLoading());
//     try {
//       final response = await dio.post(
//         'https://backend.almowafraty.com/api/v1/markets/bills', // استبدل بنقطة نهاية API الخاصة بك
//         data: {
//           'bills': [
//             {
//               'supplier_id': 12,
//               'market_note': 'noote',
//               'payment_method_id': 1,
//               'products': [
//                 {'id': 33, 'quantity': 8}
//               ]
//             }
//           ],
//         },
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json', // يمكنك أيضًا تعيين الرؤوس هنا
//           },
//         ),
//       );

//       if (response.statusCode == 201) {
//         emit(BillSuccess(response.data['message']));
//       } else {
//         emit(BillFailure(response.data['message']));
//       }
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       emit(BillFailure(errorMessage));
//     } catch (e) {
//       emit(BillFailure("An unexpected error occurred: ${e.toString()}"));
//     }
//   }
// }

// class BillPagessrequst extends StatelessWidget {
//   const BillPagessrequst({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BillCubit(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Create Bill'),
//         ),
//         body: BlocConsumer<BillCubit, BillState>(
//           listener: (context, state) {
//             if (state is BillSuccess) {
//               showCustomSnackBar(context, state.message, color: Colors.green);
//             } else if (state is BillFailure) {
//               showCustomSnackBar(context, state.error, color: Colors.red);
//             }
//           },
//           builder: (context, state) {
//             if (state is BillLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             // إضافة واجهة المستخدم الخاصة بك هنا
//             // يمكنك استخدام RaisedButton لتشغيل createBill على سبيل المثال
//             return Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // هنا يجب تمرير قائمة المنتجات الحقيقية
//                   BlocProvider.of<BillCubit>(context).createBill([]);
//                 },
//                 child: const Text('Create Bill'),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
