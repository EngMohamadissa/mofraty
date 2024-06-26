// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Product {
//   final int id;
//   final int productCategoryId;
//   final String name;
//   final String description;
//   final int size;
//   final String sizeOf;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int productId;
//   final int supplierId;
//   final double price;
//   final int maxSellingQuantity;
//   final bool isAvailable;
//   final bool hasOffer;
//   final double offerPrice;
//   final int maxOfferQuantity;
//   final DateTime offerExpiresAt;
//   final List<dynamic> image; // يفضل تحديد نوع بيانات أكثر تحديدًا

//   Product({
//     required this.id,
//     required this.productCategoryId,
//     required this.name,
//     required this.description,
//     required this.size,
//     required this.sizeOf,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.productId,
//     required this.supplierId,
//     required this.price,
//     required this.maxSellingQuantity,
//     required this.isAvailable,
//     required this.hasOffer,
//     required this.offerPrice,
//     required this.maxOfferQuantity,
//     required this.offerExpiresAt,
//     required this.image,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       productCategoryId: json['product_category_id'],
//       name: json['name'],
//       description: json['discription'],
//       size: json['size'],
//       sizeOf: json['size_of'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       productId: json['product_id'],
//       supplierId: json['supplier_id'],
//       price: json['price'].toDouble(),
//       maxSellingQuantity: json['max_selling_quantity'],
//       isAvailable: json['is_available'] == 1,
//       hasOffer: json['has_offer'] == 1,
//       offerPrice: json['offer_price'].toDouble(),
//       maxOfferQuantity: json['max_offer_quantity'],
//       offerExpiresAt: DateTime.parse(json['offer_expires_at']),
//       image: json['image'], // يفضل تحويل هذا إلى قائمة من الصور إذا كانت متوفرة
//     );
//   }
// }

// abstract class ProductState {}

// class ProductInitial extends ProductState {}

// class ProductLoading extends ProductState {}

// class ProductLoaded extends ProductState {
//   final List<Product> products;
//   ProductLoaded(this.products);
// }

// class ProductError extends ProductState {
//   final String message;
//   ProductError(this.message);
// }

// // ProductCubit
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

// class ProductPage extends StatelessWidget {

//   const ProductPage({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//       ),
//       body: BlocProvider(
//         create: (context) => ProductCubit(Dio(),'203|4M1xWJVDdkyI1Fl4MbzkrxYgQCLJSQCbw9118zez85475a47')..getProducts(0),
//         child: BlocBuilder<ProductCubit, ProductState>(
//           builder: (context, state) {
//             if (state is ProductLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ProductLoaded) {
//               return ListView.builder(
//                 itemCount: state.products.length,
//                 itemBuilder: (context, index) {
//                   final product = state.products[index];
//                   return ListTile(
//                     title: Text(product.name),
//                     subtitle: Text(product.description),
//                     trailing: Text('${product.price}'),
//                     // إذا كان لديك صور للمنتج، يمكن عرضها هنا
//                   );
//                 },
//               );
//             } else if (state is ProductError) {
//               return Center(child: Text('Error: ${state.message}'));
//             } else {
//               return const Center(
//                   child: Text('Start searching for products...'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// ////////.....................successed
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Supplier {
//   final int id;
//   final int supplierCategoryId;
//   final int cityId;
//   final String firstName;
//   final String middleName;
//   final String lastName;
//   final String storeName;
//   final String phoneNumber;
//   final int minBillPrice;
//   final int minSellingQuantity;
//   final String deliveryDuration;
//   final String status;
//   final String createdAt;
//   final String updatedAt;
//   final List<Product> products;

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
//     required this.deliveryDuration,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//      required this.products,
//   });

//   factory Supplier.fromJson(Map<String, dynamic> json) {
//       var productList = (json['products'] as List)
//         .map((productJson) => Product.fromJson(productJson))
//         .toList();
//     return Supplier(
//       id: json['id'],
//       supplierCategoryId: json['supplier_category_id'],
//       cityId: json['city_id'],
//       firstName: json['first_name'],
//       middleName: json['middle_name'],
//       lastName: json['last_name'],
//       storeName: json['store_name'],
//       phoneNumber: json['phone_number'],
//       minBillPrice: json['min_bill_price'],
//       minSellingQuantity: json['min_selling_quantity'],
//       deliveryDuration: json['delivery_duration'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'], products: productList,
//     );
//   }
// }
// class Product {
//   final int id;
//   final int productCategoryId;
//   final String name;
//   final String description;
//   final int size;
//   final String sizeOf;
//   final String createdAt;
//   final String updatedAt;
//   final int productId;
//   final int supplierId;
//   final int price;
//   final int maxSellingQuantity;
//   final bool isAvailable;
//   final bool hasOffer;
//   final int offerPrice;
//   final int maxOfferQuantity;
//   final String offerExpiresAt;
//   final List<dynamic> image;

//   Product({
//     required this.id,
//     required this.productCategoryId,
//     required this.name,
//     required this.description,
//     required this.size,
//     required this.sizeOf,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.productId,
//     required this.supplierId,
//     required this.price,
//     required this.maxSellingQuantity,
//     required this.isAvailable,
//     required this.hasOffer,
//     required this.offerPrice,
//     required this.maxOfferQuantity,
//     required this.offerExpiresAt,
//     required this.image,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       productCategoryId: json['product_category_id'],
//       name: json['name'],
//       description: json['description'],
//       size: json['size'],
//       sizeOf: json['size_of'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       productId: json['product_id'],
//       supplierId: json['supplier_id'],
//       price: json['price'],
//       maxSellingQuantity: json['max_selling_quantity'],
//       isAvailable: json['is_available'] == 1,
//       hasOffer: json['has_offer'] == 1,
//       offerPrice: json['offer_price'],
//       maxOfferQuantity: json['max_offer_quantity'],
//       offerExpiresAt: json['offer_expires_at'],
//       image: json['image'] ?? [],
//     );
//   }
// }

// abstract class SupplierState {}

// class SupplierLoading extends SupplierState {}

// class SupplierLoaded extends SupplierState {
//   final List<Supplier> suppliers;

//   SupplierLoaded(this.suppliers);
// }

// class SupplierError extends SupplierState {
//   final String message;

//   SupplierError(this.message);
// }

// class SupplierCubit extends Cubit<SupplierState> {
//   SupplierCubit() : super(SupplierLoading());

//   void getSuppliers(String categoryId, String token) async {
//     try {
//       var dio = Dio();

//       // تعيين التوكين في الـ headers
//       dio.options.  headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get(
//         'https://almowafraty.com/api/v1/markets/suppliers',
//         queryParameters: {'categoryId': categoryId},
//       );
//         final data = response.data;
//       final supplier = Supplier.fromJson(data);
//       // final data = response.data['suppliers'] as List;
//       // final suppliers = data.map((json) => Supplier.fromJson(json)).toList();
//       emit(SupplierLoaded(supplier));
//     } catch (e) {
//       emit(SupplierError(e.toString()));
//     }
//   }
// }

// class SuppliersPageDet extends StatelessWidget {
//   final String categoryId;

//   const SuppliersPageDet({Key? key, required this.categoryId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Suppliers'),
//       ),
//       body: BlocProvider(
//         create: (context) => SupplierCubit()
//           ..getSuppliers(categoryId,
//               '175|yi1FgTeQtoa0lnV7PFE6dwRQT9jriT9DUXBnor4F8cbcbccb'),
//         child: BlocBuilder<SupplierCubit, SupplierState>(
//           builder: (context, state) {
//             if (state is SupplierLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is SupplierLoaded) {
//               return ListView.builder(
//                 itemCount: state.suppliers.length,
//                 itemBuilder: (context, index) {
//                   final supplier = state.suppliers[index];
//                   return ListTile(
//                     title: Text(supplier.storeName),
//                     subtitle: Text(
//                         '${supplier.firstName} ${supplier.middleName} ${supplier.lastName}'),
//                   );
//                 },
//               );
//             } else if (state is SupplierError) {
//               return Center(child: Text(state.message));
//             } else {
//               return const Center(child: Text('No data'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// ////////with tab bar
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
//       id: json['id'] as int,
//       supplierCategoryId: json['supplier_category_id'] as int,
//       cityId: json['city_id'] as int,
//       firstName: json['first_name'] as String,
//       middleName: json['middle_name'] as String,
//       lastName: json['last_name'] as String,
//       storeName: json['store_name'] as String,
//       phoneNumber: json['phone_number'] as String,
//       minBillPrice: json['min_bill_price'] as double,
//       minSellingQuantity: json['min_selling_quantity'] as int,
//       deliveryDuration: json['delivery_duration'] as String?,
//       status: json['status'] as String,
//       createdAt: json['created_at'] as String,
//       updatedAt: json['updated_at'] as String,
//     );
//   }
// }

// class ProductCategory {
//   final int id;
//   final String name;

//   ProductCategory({required this.id, required this.name});

//   factory ProductCategory.fromJson(Map<String, dynamic> json) {
//     return ProductCategory(
//       id: json['id'] as int,
//       name: json['name'] as String,
//     );
//   }
// }

// class Product {
//   final int id;
//   final int productCategoryId;
//   final String name;
//   final String description;
//   final int size;
//   final String sizeOf;
//   final double price;
//   final int maxSellingQuantity;
//   final bool isAvailable;
//   final bool hasOffer;
//   final double offerPrice;
//   final int maxOfferQuantity;
//   final String offerExpiresAt;
//   final List<String> images;

//   Product({
//     required this.id,
//     required this.productCategoryId,
//     required this.name,
//     required this.description,
//     required this.size,
//     required this.sizeOf,
//     required this.price,
//     required this.maxSellingQuantity,
//     required this.isAvailable,
//     required this.hasOffer,
//     required this.offerPrice,
//     required this.maxOfferQuantity,
//     required this.offerExpiresAt,
//     required this.images,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     var imagesFromJson = json['image'];
//     List<String> imagesList = [];
//     if (imagesFromJson != null) {
//       imagesList = List<String>.from(imagesFromJson as List);
//     }

//     return Product(
//       id: json['id'] as int,
//       productCategoryId: json['product_category_id'] as int,
//       name: json['name'] as String,
//       description: json['description'] as String,
//       size: json['size'] as int,
//       sizeOf: json['size_of'] as String,
//       price: (json['price'] as num).toDouble(),
//       maxSellingQuantity: json['max_selling_quantity'] as int,
//       isAvailable: json['is_available'] as bool,
//       hasOffer: json['has_offer'] as bool,
//       offerPrice: (json['offer_price'] as num).toDouble(),
//       maxOfferQuantity: json['max_offer_quantity'] as int,
//       offerExpiresAt: json['offer_expires_at'] as String,
//       images: imagesList,
//     );
//   }
// }

// abstract class CategoryState {}

// class CategoryInitial extends CategoryState {}

// class CategoryLoaded extends CategoryState {
//   final List<ProductCategory> categories;

//   CategoryLoaded(this.categories);
// }

// class CategoryError extends CategoryState {
//   final String errorMessage;

//   CategoryError({required this.errorMessage});
// }

// class ProductsLoaded extends CategoryState {
//   final int categoryId;
//   final List<Product> products;

//   ProductsLoaded(this.products, this.categoryId);
// }

// class ProductsLoading extends CategoryState {
//   final int categoryId;

//   ProductsLoading({required this.categoryId});
// }

// class ProductsError extends CategoryState {
//   final String errorMessage;

//   ProductsError({required this.errorMessage});
// }

// class ApiProvider {
//   final Dio _dio = Dio();

//   ApiProvider() {
//     _dio.options.headers['Authorization'] =
//         'Bearer 150|VeSFxkffQ7nQejEbQ6GQxag1f6Tc9w7KjeqFYXUZ32b098e3';
//   }

//   Future<List<ProductCategory>> fetchCategories() async {
//     try {
//       final response = await _dio.get(
//           'https://backend.almowafraty.com/api/v1/markets/suppliers/2?categoryId=1');
//       final data =
//           List<Map<String, dynamic>>.from(response.data['product_categories']);
//       return data.map((json) => ProductCategory.fromJson(json)).toList();
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<List<Product>> fetchProducts(int categoryId) async {
//     try {
//       final response = await _dio.get(
//           'https://backend.almowafraty.com/api/v1/markets/suppliers/2?categoryId=$categoryId');
//       final data = List<Map<String, dynamic>>.from(response.data['products']);
//       return data
//           .where((json) => json['product_category_id'] == categoryId)
//           .map((json) => Product.fromJson(json))
//           .toList();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

// class CategoryCubit extends Cubit<CategoryState> {
//   final ApiProvider apiProvider;

//   CategoryCubit(this.apiProvider) : super(CategoryInitial());

//   void fetchCategories() async {
//     try {
//       final categories = await apiProvider.fetchCategories();

//       emit(CategoryLoaded(categories));
//     } catch (e) {
//       emit(CategoryError(errorMessage: e.toString()));
//       // handle error state
//     }
//   }

//   void fetchProducts(int categoryId) async {
//     try {
//       emit(ProductsLoading(
//           categoryId: categoryId)); // إصدار حالة التحميل مع مُعرف التصنيف
//       final products = await apiProvider.fetchProducts(categoryId);
//       emit(ProductsLoaded(products, categoryId));
//     } catch (e) {
//       emit(ProductsError(errorMessage: e.toString()));
//     }
//   }
// }

// class CategoriesPage extends StatelessWidget {
//   const CategoriesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // تأكد من توفير ApiProvider و CategoryCubit للشجرة
//     return BlocProvider<CategoryCubit>(
//       create: (context) => CategoryCubit(ApiProvider())..fetchCategories(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('التصنيفات والمنتجات'),
//         ),
//         body: Column(
//           children: [
//             const Expanded(
//               flex: 1,
//               child: CategoriesList(),
//             ),
//             Expanded(
//               flex: 3,
//               child: BlocProvider(
//                 create: (context) =>
//                     CategoryCubit(ApiProvider())..fetchProducts(1),
//                 child: const ProductsList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CategoriesList extends StatelessWidget {
//   const CategoriesList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // استخدام BlocBuilder لإعادة بناء القائمة عند تغير الحالة
//     return BlocBuilder<CategoryCubit, CategoryState>(
//       builder: (context, state) {
//         if (state is CategoryLoaded) {
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: state.categories.length,
//             itemBuilder: (context, index) {
//               final category = state.categories[index];
//               return InkWell(
//                 onTap: () {
//                   // عند النقر على تصنيف، جلب المنتجات لهذا التصنيف
//                   context.read<CategoryCubit>().fetchProducts(category.id);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(
//                     label: Text(category.name),
//                   ),
//                 ),
//               );
//             },
//           );
//         } else if (state is CategoryError) {
//           return Center(child: Text('حدث خطأ: ${state.errorMessage}'));
//         } else {
//           return const Center(child: Text('يتم تحميل التصنيفات'));
//         }
//       },
//     );
//   }
// }

// class ProductsList extends StatelessWidget {
//   const ProductsList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // استخدام BlocBuilder لإعادة بناء القائمة عند تغير الحالة
//     return BlocBuilder<CategoryCubit, CategoryState>(
//       builder: (context, state) {
//         if (state is ProductsLoading) {
//           // إظهار CircularProgressIndicator فقط عندما تكون المنتجات قيد التحميل
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is ProductsLoaded) {
//           return ListView.builder(
//             itemCount: state.products.length,
//             itemBuilder: (context, index) {
//               final product = state.products[index];
//               return ListTile(
//                 title: Text(product.name),
//                 subtitle: Text(product.description),
//               );
//             },
//           );
//         } else {
//           // عندما لا تكون المنتجات قيد التحميل ولا يوجد خطأ، يجب ألا يظهر شيء
//           // أو يمكن إظهار رسالة توضيحية أو واجهة افتراضية
//           return const Center(child: Text('الرجاء اختيار تصنيف لعرض المنتجات'));
//         }
//       },
//     );
//   }
// }








// // class CategoriesScreen extends StatelessWidget {
// //   const CategoriesScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // إنشاء مثيل واحد من CategoryCubit في الأعلى
// //     final CategoryCubit categoryCubit = CategoryCubit(ApiProvider());

// //     return BlocProvider(
// //       create: (context) => categoryCubit..fetchCategories(),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('التصنيفات'),
// //         ),
// //         body: BlocBuilder<CategoryCubit, CategoryState>(
// //           builder: (context, state) {
// //             if (state is CategoryLoaded) {
// //               return DefaultTabController(
// //                 length: state.categories.length,
// //                 child: Scaffold(
// //                   appBar: AppBar(
// //                     bottom: TabBar(
// //                       isScrollable: true,
// //                       tabs: state.categories
// //                           .map((category) => Tab(text: category.name))
// //                           .toList(),
// //                     ),
// //                   ),
// //                   body: TabBarView(
// //                     children: state.categories.map((category) {
// //                       // استخدام BlocProvider.value لتمرير الـ cubit الحالي
// //                       return BlocProvider.value(
// //                         value: categoryCubit,
// //                         child: Builder(
// //                           builder: (context) {
// //                             // تحميل المنتجات للفئة الحالية
// //                             context
// //                                 .read<CategoryCubit>()
// //                                 .fetchProducts(category.id);

// //                             return BlocBuilder<CategoryCubit, CategoryState>(
// //                               builder: (context, state) {
// //                                 if (state is ProductsLoaded) {
// //                                   return Expanded(
// //                                     child: ListView.builder(
// //                                       itemCount: state.products.length,
// //                                       itemBuilder: (context, index) {
// //                                         final product = state.products[index];
// //                                         return ListTile(
// //                                           title: Text(product.name),
// //                                           trailing: Text(product.description),
// //                                           // leading: Text('${product.price}'),
// //                                         );
// //                                       },
// //                                     ),
// //                                   );
// //                                 } else if (state is ProductsError) {
// //                                   return Center(
// //                                       child: Text(state.errorMessage));
// //                                 } else {
// //                                   return const Center(child: Text('helloooo'));
// //                                 }
// //                               },
// //                             );
// //                           },
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ),
// //                 ),
// //               );
// //             } else if (state is CategoryError) {
// //               return Center(child: Text(state.errorMessage));
// //             } else {
// //               return const Center(child: Text('ddssddsdsd'));
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
