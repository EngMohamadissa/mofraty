// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/Companies/data/company_model.dart';
// import 'package:eghyptproject/Featuer/cart/presentation/view/cart_view.dart';
// import 'package:eghyptproject/core/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductCategory {
//   final int id;
//   final String name;

//   ProductCategory({required this.id, required this.name});

//   factory ProductCategory.fromJson(Map<String, dynamic> json) {
//     return ProductCategory(
//       id: json['id'],
//       name: json['name'],
//     );
//   }
// }

// class Product {
//   int? id;
//   int? productCategoryId;
//   String? name;
//   String? discription;
//   int? size;
//   String? sizeOf;
//   int? productId;
//   int? supplierId;
//   num? price;
//   num? maxSellingQuantity;
//   bool? isAvailable;
//   bool? hasOffer;
//   double? offerPrice;
//   num? maxOfferQuantity;
//   String? offerExpiresAt;
//   List<String>? images;
//   String? productCategoryName;
//   int quantity;

//   Product({
//     this.id,
//     this.productCategoryId,
//     this.name,
//     this.discription,
//     this.size,
//     this.sizeOf,
//     this.productId,
//     this.supplierId,
//     this.price,
//     this.maxSellingQuantity,
//     this.isAvailable,
//     this.hasOffer,
//     this.offerPrice,
//     this.maxOfferQuantity,
//     this.offerExpiresAt,
//     this.images,
//     this.productCategoryName,
//     this.quantity = 1,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       productCategoryId: json['product_category_id'],
//       name: json['name'],
//       discription: json['discription'], // تأكد من تطابق اسم الخاصية مع الـ JSON
//       size: json['size'],
//       sizeOf: json['size_of'],
//       productId: json['product_id'],
//       supplierId: json['supplier_id'],
//       price: json['price']?.toDouble(),
//       maxSellingQuantity: json['max_selling_quantity'],
//       isAvailable: json['is_available'] == 1,
//       hasOffer: json['has_offer'] == 1,
//       offerPrice: json['offer_price']?.toDouble(),
//       maxOfferQuantity: json['max_offer_quantity'],
//       offerExpiresAt: json['offer_expires_at'],
//       images: List<String>.from(json['images'] ?? []),
//       productCategoryName: json['product_category_name'],
//     );
//   }
// }

// class ApiProvider {
//   final Dio dio = Dio();

//   ApiProvider() {
//     dio.options.headers['Authorization'] =
//         'Bearer 183|3teXQ3iYKGLNlcnABH42mFMMa033wrAeSid26nkyc6151256';
//   }

//   Future<List<ProductCategory>> fetchCategories() async {
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/4');
//     final List<dynamic> categoriesJson = response.data['product_categories'];
//     return categoriesJson
//         .map((json) => ProductCategory.fromJson(json))
//         .toList();
//   }

//   Future<List<Product>> fetchAllProducts() async {
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/4');
//     final List<dynamic> productsJson = response.data['products'];
//     return productsJson.map((json) => Product.fromJson(json)).toList();
//   }

//   Future<List<Product>> fetchProductsByCategory(int categoryId) async {
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/4');
//     final List<dynamic> productsJson = response.data['products'];
//     return productsJson
//         .where((json) => json['product_category_id'] == categoryId)
//         .map((json) => Product.fromJson(json))
//         .toList();
//   }
// }

// // CategoryState.dart
// abstract class CategoryState {}

// class CategoryInitial extends CategoryState {}

// class CategoryLoading extends CategoryState {}

// class CategoryLoaded extends CategoryState {
//   final List<ProductCategory> categories;

//   CategoryLoaded(this.categories);
// }

// class CategoryError extends CategoryState {
//   final String errorMessage;

//   CategoryError(this.errorMessage);
// }

// // CategoryCubit.dart
// class CategoryCubit extends Cubit<CategoryState> {
//   final ApiProvider apiProvider;

//   CategoryCubit(this.apiProvider) : super(CategoryInitial());

//   void fetchCategories() async {
//     try {
//       emit(CategoryLoading());
//       final categories = await apiProvider.fetchCategories();
//       // إضافة فئة افتراضية لـ "الكل"
//       final allCategory = ProductCategory(id: 0, name: 'الكل');
//       emit(CategoryLoaded([allCategory, ...categories]));
//     } catch (e) {
//       emit(CategoryError(e.toString()));
//     }
//   }
// }

// // ProductState.dart
// abstract class ProductState {}

// class ProductsInitial extends ProductState {}

// class ProductsLoading extends ProductState {}

// class ProductsLoaded extends ProductState {
//   final List<Product> products;
//   final int categoryId;

//   ProductsLoaded(this.products, this.categoryId);
// }

// class ProductsError extends ProductState {
//   final String errorMessage;

//   ProductsError(this.errorMessage);
// }

// // ProductCubit.dart
// class ProductCubit extends Cubit<ProductState> {
//   final ApiProvider apiProvider;

//   ProductCubit(this.apiProvider) : super(ProductsInitial());

//   void fetchProductsByCategory(int categoryId) async {
//     try {
//       emit(ProductsLoading());
//       List<Product> products;
//       if (categoryId == 0) {
//         // إذا كان categoryId يساوي 0، نريد جلب جميع المنتجات
//         products = await apiProvider.fetchAllProducts();
//       } else {
//         // وإلا، نجلب المنتجات حسب الفئة
//         products = await apiProvider.fetchProductsByCategory(categoryId);
//       }
//       emit(ProductsLoaded(products, categoryId));
//     } catch (e) {
//       emit(ProductsError(e.toString()));
//     }
//   }
// }

// class CategoriesPageFS extends StatefulWidget {
//   // final Supplier supplier;
//   // const CategoriesPageFS({super.key, @required this.supplier});

//   @override
//   _CategoriesPageFSState createState() => _CategoriesPageFSState();
// }

// class _CategoriesPageFSState extends State<CategoriesPageFS> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CategoryCubit(ApiProvider())..fetchCategories(),
//       child: BlocBuilder<CategoryCubit, CategoryState>(
//         builder: (context, state) {
//           if (state is CategoryLoaded) {
//             return DefaultTabController(
//               length: state.categories.length,
//               child: Scaffold(
//                 appBar: AppBar(
//                   actions: [
//                     IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => CartPage(),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.card_travel))
//                   ],
//                   backgroundColor: Colors.red,
//                   title: const Text(
//                     'التصنيفات والمنتجات',
//                     style: Styles.textStyle20,
//                   ),
//                   centerTitle: true,
//                   bottom: TabBar(
//                     isScrollable: true,
//                     tabs: state.categories
//                         .map((category) => Tab(text: category.name))
//                         .toList(),
//                   ),
//                 ),
//                 body: TabBarView(
//                   children: state.categories.map((category) {
//                     return BlocProvider(
//                       create: (context) => ProductCubit(ApiProvider())
//                         ..fetchProductsByCategory(category.id),
//                       child: ProductsList(
//                         categoryId: category.id,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             );
//           } else if (state is CategoryError) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('التصنيفات والمنتجات'),
//               ),
//               body: Center(child: Text('حدث خطأ: ${state.errorMessage}')),
//             );
//           } else {
//             // CategoryLoading state
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('التصنيفات والمنتجات'),
//               ),
//               body: const Center(child: CircularProgressIndicator()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class ProductsList extends StatelessWidget {
//   final int categoryId;

//   final List<Product> cartProducts = [];
//   String appBarTitle = 'اسم المنتج';

//   ProductsList({Key? key, required this.categoryId}) : super(key: key);

//   void addToCart(Product product) {
//     // إضافة المنتج إلى القائمة
//     cartProducts.add(product);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     double cardMargin =
//         screenWidth * 0.05; // 5% of screen width for card margin
//     double borderRadius =
//         screenWidth * 0.02; // 2% of screen width for border radius
//     double paddingAllSides =
//         screenWidth * 0.02; // Padding for all sides is 2% of screen width
//     double imageSize = screenWidth * 0.18; // Image size is 18% of screen width

//     return BlocConsumer<ProductCubit, ProductState>(
//       listener: (context, state) {
//         if (state is ProductsError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('حدث خطأ: ${state.errorMessage}')),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is ProductsLoaded && state.categoryId == categoryId) {
//           return ListView.builder(
//             itemCount: state.products.length,
//             itemBuilder: (context, index) {
//               final product = state.products[index];
//               return Card(
//                 margin: EdgeInsets.all(cardMargin),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(paddingAllSides),
//                   child: Row(
//                     children: [
//                       // Container(
//                       //   width: imageSize,
//                       //   height: imageSize,
//                       //   decoration: BoxDecoration(
//                       //     borderRadius: BorderRadius.circular(borderRadius),
//                       //     image: DecorationImage(
//                       //       fit: BoxFit.cover,
//                       //       image: NetworkImage(product.images![
//                       //           0]), // Assuming each product has an imageUrl field
//                       //     ),
//                       //   ),
//                       // ),
//                       Expanded(
//                         child: ListTile(
//                           title: Text("${product.name}"),
//                           subtitle: Column(
//                             children: [
//                               Text("${product.discription}"),
//                               Text("${product.price}"),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Cart().addProduct(product);
//                                   print(product.quantity);
//                                   // Navigator.push(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //     builder: (context) =>
//                                   //         CartPage(cartProducts: cartProducts),
//                                   //   ),
//                                   // );
//                                 },
//                                 child: const Text('اضف إلى السلة'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         } else if (state is ProductsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           // ProductsInitial or any other state
//           return const Center(child: Text('لايوجد منتجات'));
//         }
//       },
//     );
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/Companies/data/company_model.dart';
// import 'package:eghyptproject/Featuer/cart/presentation/view/cart_view.dart';
// import 'package:eghyptproject/core/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SupplierModel {
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
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   SupplierModel({
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

//   factory SupplierModel.fromJson(Map<String, dynamic> json) {
//     return SupplierModel(
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
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }

// class ProductCategory {
//   final int id;
//   final String name;

//   ProductCategory({
//     required this.id,
//     required this.name,
//   });

//   factory ProductCategory.fromJson(Map<String, dynamic> json) {
//     return ProductCategory(
//       id: json['id'],
//       name: json['name'],
//     );
//   }
// }

// class Product {
//   final int id;
//   final int productCategoryId;
//   String? name;
//   final String discription;
//   final int size;
//   final String sizeOf;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int productId;
//   final int supplierId;
//   final double price;
//   final int maxSellingQuantity;
//   final bool isAvailable;
//   final bool hasOffer;
//   final double offerPrice;
//   final int maxOfferQuantity;
//   final DateTime offerExpiresAt;
//   final List<String> images;
//   final String productCategory;
//   int quantity;

//   Product({
//     required this.id,
//     required this.productCategoryId,
//     required this.name,
//     required this.discription,
//     required this.size,
//     required this.sizeOf,
//     this.createdAt,
//     this.updatedAt,
//     required this.productId,
//     required this.supplierId,
//     required this.price,
//     required this.maxSellingQuantity,
//     required this.isAvailable,
//     required this.hasOffer,
//     required this.offerPrice,
//     required this.maxOfferQuantity,
//     required this.offerExpiresAt,
//     required this.images,
//     required this.productCategory,
//     this.quantity = 1,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       productCategoryId: json['product_category_id'],
//       name: json['name'],
//       discription: json['discription'],
//       size: json['size'],
//       sizeOf: json['size_of'],
//       createdAt: json['created_at'] != null
//           ? DateTime.parse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//       productId: json['product_id'],
//       supplierId: json['supplier_id'],
//       price: json['price'].toDouble(),
//       maxSellingQuantity: json['max_selling_quantity'],
//       isAvailable: json['is_available'] == 1,
//       hasOffer: json['has_offer'] == 1,
//       offerPrice: json['offer_price'].toDouble(),
//       maxOfferQuantity: json['max_offer_quantity'],
//       offerExpiresAt: DateTime.parse(json['offer_expires_at']),
//       images: List<String>.from(json['image']),
//       productCategory: json['product_category'],
//     );
//   }
// }

// class ApiProvider {
//   final Dio dio = Dio();

//   ApiProvider() {
//     dio.options.headers['Authorization'] =
//         'Bearer 188|G37q8HRwRaMmg3iv0v5lJaoe7UDbn3kAX4aos1pa25e89a39';
//   }

//   Future<SupplierModel> fetchSupplier() async {
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/4');
//     return SupplierModel.fromJson(response.data['supplier']);
//   }

//   Future<List<ProductCategory>> fetchCategories() async {
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/4');
//     final List<dynamic> categoriesJson = response.data['product_categories'];
//     return categoriesJson
//         .map((json) => ProductCategory.fromJson(json))
//         .toList();
//   }

//   Future<List<Product>> fetchAllProducts() async {
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/4');
//     final List<dynamic> productsJson = response.data['products'];
//     return productsJson.map((json) => Product.fromJson(json)).toList();
//   }

//   Future<List<Product>> fetchProductsByCategory(int categoryId) async {
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/4');
//     final List<dynamic> productsJson = response.data['products'];
//     return productsJson
//         .where((json) => json['product_category_id'] == categoryId)
//         .map((json) => Product.fromJson(json))
//         .toList();
//   }
// }

// // CategoryState.dart
// abstract class CategoryState {}

// class CategoryInitial extends CategoryState {}

// class CategoryLoading extends CategoryState {}

// class CategoryLoaded extends CategoryState {
//   final List<ProductCategory> categories;

//   CategoryLoaded(this.categories);
// }

// class CategoryError extends CategoryState {
//   final String errorMessage;

//   CategoryError(this.errorMessage);
// }

// // CategoryCubit.dart

// class CategoryCubit extends Cubit<CategoryState> {
//   final ApiProvider apiProvider;

//   CategoryCubit(this.apiProvider) : super(CategoryInitial());

//   void fetchCategories() async {
//     try {
//       emit(CategoryLoading());
//       final categories = await apiProvider.fetchCategories();
//       // إضافة فئة افتراضية لـ "الكل"
//       final allCategory = ProductCategory(id: 0, name: 'الكل');
//       emit(CategoryLoaded([allCategory, ...categories]));
//     } catch (e) {
//       emit(CategoryError(e.toString()));
//     }
//   }
// }

// // ProductState.dart
// abstract class ProductState {}

// class ProductsInitial extends ProductState {}

// class ProductsLoading extends ProductState {}

// class ProductsLoaded extends ProductState {
//   final List<Product> products;
//   final int categoryId;
//   final SupplierModel? supplier;

//   ProductsLoaded(this.products, this.categoryId, this.supplier);
// }

// class ProductsError extends ProductState {
//   final String errorMessage;

//   ProductsError(this.errorMessage);
// }

// // ProductCubit.dart
// class ProductCubit extends Cubit<ProductState> {
//   final ApiProvider apiProvider;

//   ProductCubit(this.apiProvider) : super(ProductsInitial());

// // ProductCubit.dart continuation
//   void fetchProductsByCategory(int categoryId) async {
//     try {
//       emit(ProductsLoading());
//       List<Product> products;
//       SupplierModel? supplier;

//       if (categoryId == 0) {
//         // إذا كان categoryId يساوي 0، نريد جلب جميع المنتجات
//         products = await apiProvider.fetchAllProducts();
//       } else {
//         // وإلا، نجلب المنتجات حسب الفئة
//         products = await apiProvider.fetchProductsByCategory(categoryId);
//       }
//       // جلب معلومات المورد
//       supplier = await apiProvider.fetchSupplier();
//       emit(ProductsLoaded(products, categoryId, supplier));
//     } catch (e) {
//       emit(ProductsError(e.toString()));
//     }
//   }
// }

// class CategoriesPageFS extends StatefulWidget {
//   const CategoriesPageFS({super.key});

//   // final Supplier supplier;
//   // const CategoriesPageFS({super.key, @required this.supplier});

//   @override
//   _CategoriesPageFSState createState() => _CategoriesPageFSState();
// }

// class _CategoriesPageFSState extends State<CategoriesPageFS> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CategoryCubit(ApiProvider())..fetchCategories(),
//       child: BlocBuilder<CategoryCubit, CategoryState>(
//         builder: (context, state) {
//           if (state is CategoryLoaded) {
//             return DefaultTabController(
//               length: state.categories.length,
//               child: Scaffold(
//                 appBar: AppBar(
//                   actions: [
//                     IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => CartPage(),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.card_travel))
//                   ],
//                   backgroundColor: Colors.red,
//                   title: const Text(
//                     'التصنيفات والمنتجات',
//                     style: Styles.textStyle20,
//                   ),
//                   centerTitle: true,
//                   bottom: TabBar(
//                     isScrollable: true,
//                     tabs: state.categories
//                         .map((category) => Tab(text: category.name))
//                         .toList(),
//                   ),
//                 ),
//                 body: TabBarView(
//                   children: state.categories.map((category) {
//                     return BlocProvider(
//                       create: (context) => ProductCubit(ApiProvider())
//                         ..fetchProductsByCategory(category.id),
//                       child: ProductsList(
//                         categoryId: category.id,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             );
//           } else if (state is CategoryError) {
//             return Scaffold(
//               appBar: AppBar(
//                 backgroundColor: Colors.red,
//                 title: const Text('التصنيفات والمنتجات'),
//               ),
//               body: Center(child: Text('حدث خطأ: ${state.errorMessage}')),
//             );
//           } else {
//             // CategoryLoading state
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('التصنيفات والمنتجات'),
//               ),
//               body: const Center(child: CircularProgressIndicator()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class ProductsList extends StatelessWidget {
//   final int categoryId;

//   final List<Product> cartProducts = [];
//   String appBarTitle = 'اسم المنتج';

//   ProductsList({Key? key, required this.categoryId}) : super(key: key);

//   void addToCart(Product product) {
//     // إضافة المنتج إلى القائمة
//     cartProducts.add(product);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     double cardMargin =
//         screenWidth * 0.05; // 5% of screen width for card margin
//     double borderRadius =
//         screenWidth * 0.02; // 2% of screen width for border radius
//     double paddingAllSides =
//         screenWidth * 0.02; // Padding for all sides is 2% of screen width
//     double imageSize = screenWidth * 0.18; // Image size is 18% of screen width

//     return BlocConsumer<ProductCubit, ProductState>(
//       listener: (context, state) {
//         if (state is ProductsError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('حدث خطأ: ${state.errorMessage}')),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is ProductsLoaded && state.categoryId == categoryId) {
//           return ListView.builder(
//             itemCount: state.products.length,
//             itemBuilder: (context, index) {
//               final product = state.products[index];
//               return Card(
//                 margin: EdgeInsets.all(cardMargin),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(paddingAllSides),
//                   child: Row(
//                     children: [
//                       // Container(
//                       //   width: imageSize,
//                       //   height: imageSize,
//                       //   decoration: BoxDecoration(
//                       //     borderRadius: BorderRadius.circular(borderRadius),
//                       //     image: DecorationImage(
//                       //       fit: BoxFit.cover,
//                       //       image: NetworkImage(product.images![
//                       //           0]), // Assuming each product has an imageUrl field
//                       //     ),
//                       //   ),
//                       // ),
//                       Expanded(
//                         child: ListTile(
//                           title: Text(product.name),
//                           subtitle: Column(
//                             children: [
//                               Text('${product.offerPrice}'),
//                               Text("${product.price}"),

//                               ElevatedButton(
//                                 onPressed: () {
//                                   Cart().addProduct(product);
//                                 },
//                                 child: const Text('اضف إلى السلة'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         } else if (state is ProductsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           // ProductsInitial or any other state
//           return const Center(child: Text('لايوجد منتجات'));
//         }
//       },
//     );
//   }
// }
///////// up bacic
// class ProductsList extends StatelessWidget {
//   final int categoryId;
//   final Cart cart = Cart();

//   ProductsList({Key? key, required this.categoryId}) : super(key: key);

//   double calculateTotalPrice(List<Product> products) {
//     double total = 0;
//     for (var product in products) {
//       total += product.offerPrice;
//     }
//     return total;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProductCubit, ProductState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         double progress = 0.0;
//         double total = 0.0;

//         if (state is ProductsLoaded) {
//           total = calculateTotalPrice(state.products);
//           if (total >= state.products[0].offerPrice) {
//             progress = 1.0;
//           } else {
//             progress = total / state.products[0].offerPrice;
//           }

//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount:
//                       state is ProductsLoaded ? state.products.length : 0,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(state.products[index].name),
//                       subtitle: Text(
//                           'Price: ${state.products[index].price}, Offer Price: ${state.products[index].offerPrice}'),
//                       trailing: ElevatedButton(
//                         onPressed: () {
//                           cart.addProduct(state.products[index]);
//                           cart.calculateTotalAndQuantity(); // Calculate total and quantity
//                         },
//                         child: const Text('Add to Cart'),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               LinearProgressIndicator(
//                 value: progress,
//                 backgroundColor: Colors.grey,
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Total: $total',
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ],
//           );
//         }
//         return const Icon(Icons.on_device_training);
//       },
//     );
//   }
// }

// class ProductsList extends StatefulWidget {
//   final int categoryId;

//   const ProductsList({Key? key, required this.categoryId}) : super(key: key);

//   @override
//   _ProductsListState createState() => _ProductsListState();
// }

// class _ProductsListState extends State<ProductsList> {
//   double totalCost = 0.0;
//   double minBill = 1.0; // تحديد قيمة مقبولة للفاتورة الدنيا

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     double cardMargin = screenWidth * 0.05;
//     double borderRadius = screenWidth * 0.02;
//     double paddingAllSides = screenWidth * 0.02;
//     double imageSize = screenWidth * 0.18;

//     return BlocConsumer<ProductCubit, ProductState>(
//       listener: (context, state) {
//         if (state is ProductsError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('حدث خطأ: ${state.errorMessage}')),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is ProductsLoaded && state.categoryId == widget.categoryId) {
//           // تحديد طول الشريط التقدمي بناءً على قيمة totalCost
//           double progressValue = totalCost >= state.supplier!.minBillPrice
//               ? 1
//               : totalCost / state.supplier!.minBillPrice;
//           return Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: state.products.length,
//                     itemBuilder: (context, index) {
//                       final product = state.products[index];
//                       return Card(
//                         margin: EdgeInsets.all(cardMargin),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(borderRadius),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(paddingAllSides),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: ListTile(
//                                   title: Text(product.name),
//                                   subtitle: Column(
//                                     children: [
//                                       Text('${product.offerPrice}'),
//                                       Text("${product.price}"),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             Cart().addProduct(product);
//                                             totalCost = Cart()
//                                                 .calculateTotalAndQuantity();
//                                           });
//                                         },
//                                         child: const Text('اضف إلى السلة'),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Total: $totalCost',
//                 style: const TextStyle(fontSize: 20),
//               ),
//               const SizedBox(height: 20),
//               LinearProgressIndicator(
//                 minHeight: 50,
//                 value: progressValue,
//               ),
//             ],
//           );
//         } else if (state is ProductsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return const Center(child: Text('لايوجد منتجات'));
//         }
//       },
//     );
//   }
// // }

// class ProductsList extends StatefulWidget {
//   final int categoryId;

//   const ProductsList({Key? key, required this.categoryId}) : super(key: key);

//   @override
//   _ProductsListState createState() => _ProductsListState();
// }

// class _ProductsListState extends State<ProductsList> {
//   double totalCost = 0.0;
//   double minBill = 1.0; // تحديد قيمة مقبولة للفاتورة الدنيا

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     double cardMargin = screenWidth * 0.05;
//     double borderRadius = screenWidth * 0.02;
//     double paddingAllSides = screenWidth * 0.02;
//     double imageSize = screenWidth * 0.18;

//     return BlocConsumer<ProductCubit, ProductState>(
//       listener: (context, state) {
//         if (state is ProductsError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('حدث خطأ: ${state.errorMessage}')),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is ProductsLoaded && state.categoryId == widget.categoryId) {
//           // تحديد طول الشريط التقدمي بناءً على قيمة totalCost
//           double progressValue = totalCost >= state.supplier!.minBillPrice
//               ? 1
//               : totalCost / state.supplier!.minBillPrice;
//           return Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: state.products.length,
//                     itemBuilder: (context, index) {
//                       final product = state.products[index];
//                       return Card(
//                         margin: EdgeInsets.all(cardMargin),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(borderRadius),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(paddingAllSides),
//                           child: Row(
//                             children: [
//                               // Image.network(
//                               //   product.images[
//                               //       index], // افترض أن هناك حقل imageUrl في كلاس Product
//                               //   width: 100, // عرض الصورة
//                               //   height: 100, // ارتفاع الصورة
//                               //   fit:
//                               //       BoxFit.cover, // كيفية تغطية المساحة المحددة
//                               // ),
//                               const SizedBox(
//                                   width: 8), // فاصل بين الصورة والمعلومات
//                               // المعلومات
//                               Expanded(
//                                 child: ListTile(
//                                   title: Text('${product.name}'),
//                                   subtitle: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(product.discription), // الوصف هنا
//                                       const SizedBox(
//                                           height: 4), // فاصل بين الوصف والسعر
//                                       Row(
//                                         children: [
//                                           Text("${product.price}"), // السعر هنا
//                                           if (product.offerPrice > 0) ...[
//                                             const SizedBox(
//                                                 width:
//                                                     8), // فاصل بين السعر والعرض الخاص
//                                             Text(
//                                               "${product.offerPrice}",
//                                               style: const TextStyle(
//                                                   color: Colors.green),
//                                             ),
//                                             const Text(
//                                               " عرض خاص",
//                                               style: TextStyle(
//                                                   color: Colors.green),
//                                             ),
//                                           ],
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                           height: 8), // فاصل بين السعر والزر
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             Cart().addProduct(product,
//                                                 state.supplier!.firstName);
//                                             totalCost = Cart()
//                                                 .calculateTotalAndQuantity();
//                                           });
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           foregroundColor: Colors.white,
//                                           backgroundColor: Colors
//                                               .blueGrey, // لون النص داخل الزر
//                                           minimumSize: const Size(
//                                               double.infinity, 34), // حجم الزر
//                                         ),
//                                         child: const Text('اضف إلى السلة'),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Total: $totalCost',
//                 style: const TextStyle(fontSize: 20),
//               ),
//               const SizedBox(height: 20),
//               Stack(
//                 children: [
//                   LinearProgressIndicator(
//                     minHeight: 50,
//                     value: progressValue, // قيمة التقدم من 0.0 إلى 1.0
//                     backgroundColor: Colors.grey[200],
//                     valueColor:
//                         const AlwaysStoppedAnimation<Color>(Colors.blue),
//                   ),
//                   Positioned(
//                     right: (1 - progressValue) *
//                             MediaQuery.of(context).size.width -
//                         24, // تعديل هنا
//                     top: 0,
//                     bottom: 0,
//                     child: const Icon(
//                       Icons.shopping_cart, // أيقونة سلة التسوق
//                       size: 24, // حجم الأيقونة
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           );
//         } else if (state is ProductsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           // Handle other states
//           return Container();
//         }
//       },
//     );
//   }
// }
