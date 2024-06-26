// // import 'package:dio/dio.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // class Supplier {
// //   final int id;
// //   final int supplierCategoryId;
// //   final int cityId;
// //   final String firstName;
// //   final String middleName;
// //   final String lastName;
// //   final String storeName;
// //   final String phoneNumber;
// //   final int minBillPrice;
// //   final int minSellingQuantity;
// //   final String deliveryDuration;
// //   final String status;
// //   final String createdAt;
// //   final String updatedAt;

// //   Supplier({
// //     required this.id,
// //     required this.supplierCategoryId,
// //     required this.cityId,
// //     required this.firstName,
// //     required this.middleName,
// //     required this.lastName,
// //     required this.storeName,
// //     required this.phoneNumber,
// //     required this.minBillPrice,
// //     required this.minSellingQuantity,
// //     required this.deliveryDuration,
// //     required this.status,
// //     required this.createdAt,
// //     required this.updatedAt,
// //   });

// //   factory Supplier.fromJson(Map<String, dynamic> json) {
// //     return Supplier(
// //       id: json['id'],
// //       supplierCategoryId: json['supplier_category_id'],
// //       cityId: json['city_id'],
// //       firstName: json['first_name'],
// //       middleName: json['middle_name'],
// //       lastName: json['last_name'],
// //       storeName: json['store_name'],
// //       phoneNumber: json['phone_number'],
// //       minBillPrice: json['min_bill_price'],
// //       minSellingQuantity: json['min_selling_quantity'],
// //       deliveryDuration: json['delivery_duration'],
// //       status: json['status'],
// //       createdAt: json['created_at'],
// //       updatedAt: json['updated_at'],
// //     );
// //   }
// // }
// // abstract class SupplierState {}

// // class SupplierInitial extends SupplierState {}

// // class SupplierLoading extends SupplierState {}

// // class SupplierLoaded extends SupplierState {
// //   final List<Supplier> suppliers;
// //   SupplierLoaded(this.suppliers);
// // }

// // class SupplierError extends SupplierState {
// //   final String message;
// //   SupplierError(this.message);
// // }
// // class SupplierCubit extends Cubit<SupplierState> {
// //   SupplierCubit() : super(SupplierInitial());

// //   void getSuppliers(String type, String token) async {
// //     emit(SupplierLoading());
// //     try {
// //       var dio = Dio();
// //       dio.options.headers['Authorization'] = 'Bearer $token'; // Set the token here
// //       var response = await dio.get(
// //         'https://almowafraty.com/api/v1/markets/suppliers',
// //         queryParameters: {'type': type},
// //       );
// //       List<Supplier> suppliers = (response.data['suppliers'] as List)
// //           .map((supplier) => Supplier.fromJson(supplier))
// //           .toList();
// //       emit(SupplierLoaded(suppliers));
// //     } catch (e) {
// //       emit(SupplierError(e.toString()));
// //     }
// //   }
// // }

// // class SuppliersPage extends StatelessWidget {

// //    SuppliersPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => SupplierCubit()..getSuppliers('مورد', '173|Ce34VTJMIef3TfwwqEGWg5I7brJ2Ane0AgMRzH5p181d40e9'),
// //       child: Scaffold(
// //         appBar: AppBar(title: const Text('الموردين')),
// //         body: BlocBuilder<SupplierCubit, SupplierState>(
// //           builder: (context, state) {
// //             if (state is SupplierLoading) {
// //               return const Center(child: CircularProgressIndicator());
// //             } else if (state is SupplierLoaded) {
// //               return ListView.builder(
// //                 itemCount: state.suppliers.length,
// //                 itemBuilder: (context, index) {
// //                   final supplier = state.suppliers[index];
// //                   return ListTile(
// //                     title: Text(supplier.storeName),
// //                     subtitle: Text('${supplier.firstName} ${supplier.middleName} ${supplier.lastName}'),
// //                     trailing: Text(supplier.status),
// //                     // إضافة المزيد من التفاصيل حسب الحاجة
// //                   );
// //                 },
// //               );
// //             } else if (state is SupplierError) {
// //               return Center(child: Text('Error: ${state.message}'));
// //             } else {
// //               return const Center(child: Text('Press the button to load suppliers'));
// //             }
// //           },
// //         ),
// //         floatingActionButton: FloatingActionButton(
// //           onPressed: () => context.read<SupplierCubit>().getSuppliers('مورد','173|Ce34VTJMIef3TfwwqEGWg5I7brJ2Ane0AgMRzH5p181d40e9'), // أو 'شركات' حسب الحاجة
// //           tooltip: 'Load Suppliers',
// //           child: const Icon(Icons.refresh),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Offer {
//   final int id;
//   final int supplierId;
//   final String image;

//   Offer({required this.id, required this.supplierId, required this.image});

//   factory Offer.fromJson(Map<String, dynamic> json) {
//     return Offer(
//       id: json['id'],
//       supplierId: json['supplier_id'],
//       image: json['image'],
//     );
//   }
// }

// class Supplier {
//   final int id;
//   final int supplierCategoryId;
//   final int cityId;
//   final String firstName;
//   final String middleName;
//   final String lastName;
//   final String storeName;
//   final String phoneNumber;
//   final double minBillPrice;
//   final int minSellingQuantity;
//   final String? deliveryDuration;
//   final String status;
//   final String createdAt;
//   final String updatedAt;

//   Supplier({
//     required this.id,
//     required this.supplierCategoryId,
//     required this.cityId,
//     required this.firstName,
//     required this.middleName,
//     required this.lastName,
//     required this.storeName,
//     required this.phoneNumber,
//     required this.minBillPrice,
//     required this.minSellingQuantity,
//     this.deliveryDuration,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Supplier.fromJson(Map<String, dynamic> json) {
//     return Supplier(
//       id: json['id'],
//       supplierCategoryId: json['supplier_category_id'],
//       cityId: json['city_id'],
//       firstName: json['first_name'],
//       middleName: json['middle_name'],
//       lastName: json['last_name'],
//       storeName: json['store_name'],
//       phoneNumber: json['phone_number'],
//       minBillPrice: json['min_bill_price'].toDouble(),
//       minSellingQuantity: json['min_selling_quantity'],
//       deliveryDuration: json['delivery_duration'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

// class DataCubit extends Cubit<DataState> {
//   final DataRepository _dataRepository;

//   DataCubit(this._dataRepository) : super(DataInitial());

//   void fetchData() async {
//     try {
//       emit(DataLoading());
//       final data = await _dataRepository
//           .fetchData(); // استخدام Dio لجلب البيانات من الـ API

//       // تحويل البيانات إلى نماذج
//       List<Offer> offers = (data['offers'] as List)
//           .map((offerJson) => Offer.fromJson(offerJson))
//           .toList();
//       List<Supplier> suppliers = (data['suppliers'] as List)
//           .map((supplierJson) => Supplier.fromJson(supplierJson))
//           .toList();

//       // إصدار الحالة الناجحة مع البيانات المحولة
//       emit(DataLoaded(offers: offers, suppliers: suppliers));
//     } catch (e) {
//       emit(DataError(message: e.toString()));
//     }
//   }
// }

// class DataRepository {
//   final Dio _dio = Dio();

//   DataRepository(String token) {
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   Future<Map<String, dynamic>> fetchData() async {
//     try {
//       final response = await _dio.get(
//           'https://backend.almowafraty.com/api/v1/markets/suppliers?type=شركات');
//       return response.data;
//     } catch (e) {
//       print(e);
//       throw Exception('Failed to load data');
//     }
//   }
// }

// abstract class DataState {}

// class DataInitial extends DataState {}

// class DataLoading extends DataState {}

// class DataLoaded extends DataState {
//   final List<Offer> offers;
//   final List<Supplier> suppliers;

//   DataLoaded({required this.offers, required this.suppliers});
// }

// class DataError extends DataState {
//   final String message;

//   DataError({required this.message});
// }

// class OffersPage extends StatelessWidget {
//   const OffersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('عروض وموردين'),
//       ),
//       body: BlocProvider(
//         create: (context) => DataCubit(DataRepository(
//             '150|VeSFxkffQ7nQejEbQ6GQxag1f6Tc9w7KjeqFYXUZ32b098e3'))
//           ..fetchData(),
//         child: BlocBuilder<DataCubit, DataState>(
//           builder: (context, state) {
//             if (state is DataLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is DataLoaded) {
//               return ListView(
//                 children: [
//                   ...state.offers.map((offer) => ListTile(
//                         title: Text('Offer ID: ${offer.id}'),
//                         leading: Image.network(offer.image),
//                       )),
//                   ...state.suppliers.map((supplier) => ListTile(
//                         title: Text('Supplier: ${supplier.storeName}'),
//                       )),
//                 ],
//               );
//             } else if (state is DataError) {
//               return Center(child: Text('Error: ${state.message}'));
//             }
//             return const Center(child: Text('Please wait...'));
//           },
//         ),
//       ),
//     );
//   }
// }
