// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Product {
//   final int productId;
//   final int productCategoryId;
//   final String description;
//   final String name;
//   final int size;
//   final String sizeOf;
//   final int supplierId;
//   final int price;
//   final int maxSellingQuantity;
//   final List<dynamic> image;

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
//     required this.image,
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
//     );
//   }
// }

// class ProductCubit extends Cubit<ProductState> {
//   final String token;
//   ProductCubit({required this.token}) : super(ProductInitial());

//   void getProducts() async {
//     emit(ProductLoading());
//     try {
//       var dio = Dio();
//       dio.options.headers['Authorization'] =
//           'Bearer $token'; 
//       var response = await dio
//           .get('https://almowafraty.com/api/v1/markets/products?search=');
//       List<Product> products = (response.data['products'] as List)
//           .map((product) => Product.fromJson(product))
//           .toList();
//       emit(ProductLoaded(products));
//     } catch (e) {
//       emit(ProductError(e.toString()));
//     }
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

// class ProductsPage extends StatelessWidget {
//   const ProductsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // يجب توفير ProductCubit إلى الشجرة باستخدام BlocProvider في مكان ما في التطبيق
//     return BlocProvider(
//       create: (context) => ProductCubit(
//           token: '169|usNUR4Sd9P4faorIsen1WTJ1F52ZB5dEvGJfy6SU05985a2b')
//         ..getProducts(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('المنتجات')),
//         body: BlocBuilder<ProductCubit, ProductState>(
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
//                     subtitle: Text("${product.price}"),
//                     // إضافة المزيد من التفاصيل حسب الحاجة
//                   );
//                 },
//               );
//             } else if (state is ProductError) {
//               return Center(child: Text('Error: ${state.message}'));
//             } else {
//               return const Center(child: Text('Start loading products...'));
//             }
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => context.read<ProductCubit>().getProducts(),
//           tooltip: 'Load Products',
//           child: const Icon(Icons.refresh),
//         ),
//       ),
//     );
//   }
// }
