// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import 'Featuer/Auth/cubit/user_cubit_cubit.dart';

// class Product {
//   final int productId;
//   final int productCategoryId;
//   final String description;
//   final String name;
//   final int size;
//   final String sizeOf;
//   final int supplierId;
//   final double price;
//   final int maxSellingQuantity;
//   final List<dynamic> image;
//   final String productCategory;

//   Product({
//     required this.productId,
//     required this.productCategoryId,
//     required this.description,
//     required this.name,
//     required this.size,
//     required this.sizeOf,
//     required this.supplierId,
//     required this.price,
//     required this.maxSellingQuantity,
//     this.image = const [],
//     required this.productCategory,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       productId: json['product_id'],
//       productCategoryId: json['product_category_id'],
//       description: json['discription'],
//       name: json['name'],
//       size: json['size'],
//       sizeOf: json['size_of'],
//       supplierId: json['supplier_id'],
//       price: json['price'],
//       maxSellingQuantity: json['max_selling_quantity'],
//       image: json['image'],
//       productCategory: json['product_category'],
//     );
//   }
// }

// abstract class ProductState {}

// class ProductInitial extends ProductState {}

// class ProductLoading extends ProductState {}

// class ProductLoaded extends ProductState {
//   final List<Product> products;
//   final int currentPage;
//   final int lastPage;

//   ProductLoaded(this.products, this.currentPage, this.lastPage);
// }

// class ProductError extends ProductState {
//   final String message;

//   ProductError(this.message);
// }

// class ProductCubit extends Cubit<ProductState> {
//   final Dio _dio = Dio(
//     BaseOptions(
//       headers: {
//         'Accept': 'application/json',
//         'Authorization':
//             'Bearer 183|3teXQ3iYKGLNlcnABH42mFMMa033wrAeSid26nkyc6151256',
//       },
//     ),
//   );

//   ProductCubit() : super(ProductInitial());

//   void fetchProducts(String query, int page) async {
//     emit(ProductLoading());
//     s {
//       final response = await _dio.get(
//         'https://backend.almowafraty.com/api/v1/markets/products',
//         queryParameters: {'search': query, 'page': page},
//       );
//       final data = response.data['products'];
//       final products = List<Product>.from(
//         data['data'].map((x) => Product.fromJson(x)),
//       );
//       emit(ProductLoaded(products, data['current_page'], data['last_page']));
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       emit(ProductError(errorMessage));
//     } catch (e) {
//       emit(ProductError("An unexpected error occurred: ${e.toString()}"));
//     }
//   }

//   void fetchInitialProducts() async {
//     fetchProducts('', 1);
//   }
// }

// // استبدل هذا بمسار ملف ProductCubit الخاص بك

// class ProductSearchDelegate22 extends SearchDelegate<void> {
//   ProductSearchDelegate22();

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           showSuggestions(context);
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return BlocProvider(
//       create: (context) => ProductCubit()..fetchProducts(query, 1),
//       child: BlocBuilder<ProductCubit, ProductState>(
//         builder: (context, state) {
//           if (state is ProductLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProductLoaded) {
//             if (state.products.isEmpty) {
//               return const Center(
//                   child: Text('لا توجد منتجات بهذا الاسم الرجاء التأكد'));
//             }
//             return ListView.builder(
//               itemCount: state.products.length,
//               itemBuilder: (context, index) {
//                 return ProductCard(
//                   product: state.products[index],
//                 );
//               },
//             );
//           } else if (state is ProductError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const Center(child: Text('ابدأ البحث'));
//           }
//         },
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     MediaQuery.of(context).size.width; // للحصول على حجم الشاشة

//     return BlocProvider(
//       create: (context) => ProductCubit()..fetchInitialProducts(),
//       child: BlocBuilder<ProductCubit, ProductState>(
//         builder: (context, state) {
//           if (state is ProductLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProductLoaded) {
//             // عرض المنتجات الافتراضية
//             return ListView.builder(
//               itemCount: state.products.length,
//               itemBuilder: (context, index) {
//                 return ProductCard(
//                   product: state.products[index],
//                 );
//               },
//             );
//           } else if (state is ProductError) {
//             return Center(child: Text(state.message));
//           } else {
//             // إذا كانت الحالة ليست ProductLoading أو ProductLoaded أو ProductError
//             return const Center(child: Text('ابدأ البحث'));
//           }
//         },
//       ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final Product product;

//   const ProductCard({
//     Key? key,
//     required this.product,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final bool isTablet = screenSize.width >= 600;

//     final double horizontalPadding = screenSize.width * 0.05;
//     final double verticalPadding = screenSize.height * 0.02;
//     final double spacing = screenSize.height * 0.01;
//     final double titleSize = isTablet ? 24 : 18;
//     final double bodySize = isTablet ? 18 : 14;

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//       child: Card(
//         elevation: 2.0,
//         child: Row(
//           children: [
//             SizedBox(
//               width: screenSize.width * 0.20, // حوالي 20% من عرض الشاشة
//               child: AspectRatio(
//                 aspectRatio:
//                     1, // هذه النسبة تعني أن الصورة ستكون مربعة، يمكنك تغييرها حسب الحاجة
//                 child: Image.asset(
//                   'assets/images/girl.png',
//                   fit: BoxFit
//                       .cover, // BoxFit.cover يحافظ على نسب الأبعاد ويملأ المساحة المتاحة
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: verticalPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       product.name,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: titleSize,
//                       ),
//                     ),
//                     SizedBox(height: spacing),
//                     Text(
//                       product.description,
//                       style: TextStyle(
//                         fontSize: bodySize,
//                       ),
//                     ),
//                     SizedBox(height: spacing),
//                     Text(
//                       product.productCategory,
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: bodySize,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchScaffold extends StatelessWidget {
//   const SearchScaffold({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       actions: [
//         IconButton(
//           onPressed: () {
//             showSearch(
//               context: context,
//               delegate: ProductSearchDelegate22(),
//             );
//           },
//           icon: const Icon(Icons.search),
//         ),
//       ],
//     );
//   }
// }
