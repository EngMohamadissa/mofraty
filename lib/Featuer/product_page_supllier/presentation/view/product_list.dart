// // import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_cubit.dart';
// // import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_state.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // import '../../../cart/presentation/view/cart_view.dart';

// // class ProductsList extends StatefulWidget {
// //   final int categoryId;

// //   const ProductsList({Key? key, required this.categoryId}) : super(key: key);

// //   @override
// //   _ProductsListState createState() => _ProductsListState();
// // }

// // class _ProductsListState extends State<ProductsList> {
// //   double totalCost = 0.0;
// //   double minBill = 1.0; // تحديد قيمة مقبولة للفاتورة الدنيا

// //   @override
// //   Widget build(BuildContext context) {
// //     double screenWidth = MediaQuery.of(context).size.width;
// //     double screenHeight = MediaQuery.of(context).size.height;

// //     double cardMargin = screenWidth * 0.05;
// //     double borderRadius = screenWidth * 0.02;
// //     double paddingAllSides = screenWidth * 0.02;
// //     double imageSize = screenWidth * 0.18;

// //     return BlocConsumer<ProductCubitSupllier, ProductStateSupllier>(
// //       listener: (context, state) {
// //         if (state is ProductsError) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text('حدث خطأ: ${state.errorMessage}')),
// //           );
// //         }
// //       },
// //       builder: (context, state) {
// //         if (state is ProductsLoaded && state.categoryId == widget.categoryId) {
// //           // تحديد طول الشريط التقدمي بناءً على قيمة totalCost
// //           double progressValue = totalCost >= state.supplier!.minBillPrice
// //               ? 1
// //               : totalCost / state.supplier!.minBillPrice;
// //           return Column(
// //             children: [
// //               Expanded(
// //                 child: SingleChildScrollView(
// //                   child: ListView.builder(
// //                     shrinkWrap: true,
// //                     physics: const NeverScrollableScrollPhysics(),
// //                     itemCount: state.products.length,
// //                     itemBuilder: (context, index) {
// //                       final product = state.products[index];
// //                       return Card(
// //                         margin: EdgeInsets.all(cardMargin),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(borderRadius),
// //                         ),
// //                         child: Padding(
// //                           padding: EdgeInsets.all(paddingAllSides),
// //                           child: Row(
// //                             children: [
// //                               // Image.network(
// //                               //   product.images[
// //                               //       index], // افترض أن هناك حقل imageUrl في كلاس Product
// //                               //   width: imageSize, // عرض الصورة
// //                               //   height: imageSize, // ارتفاع الصورة
// //                               //   fit:
// //                               //       BoxFit.cover, // كيفية تغطية المساحة المحددة
// //                               // ),
// //                               const SizedBox(
// //                                   width: 8), // فاصل بين الصورة والمعلومات
// //                               // المعلومات
// //                               Expanded(
// //                                 child: ListTile(
// //                                   title: Text('${product.name}'),
// //                                   subtitle: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       Text(product.discription), // الوصف هنا
// //                                       const SizedBox(
// //                                           height: 4), // فاصل بين الوصف والسعر
// //                                       Row(
// //                                         children: [
// //                                           Text("${product.price}"), // السعر هنا
// //                                           if (product.offerPrice > 0) ...[
// //                                             const SizedBox(
// //                                                 width:
// //                                                     8), // فاصل بين السعر والعرض الخاص
// //                                             Text(
// //                                               "${product.offerPrice}",
// //                                               style: const TextStyle(
// //                                                   color: Colors.green),
// //                                             ),
// //                                             const Text(
// //                                               " عرض خاص",
// //                                               style: TextStyle(
// //                                                   color: Colors.green),
// //                                             ),
// //                                           ],
// //                                         ],
// //                                       ),
// //                                       const SizedBox(
// //                                           height: 8), // فاصل بين السعر والزر
// //                                       ElevatedButton(
// //                                         onPressed: () {
// //                                           setState(() {
// //                                             Cart().addProduct(product,
// //                                                 state.supplier!.firstName);
// //                                             totalCost = Cart()
// //                                                 .calculateTotalAndQuantity();
// //                                           });
// //                                         },
// //                                         style: ElevatedButton.styleFrom(
// //                                           foregroundColor: Colors.white,
// //                                           backgroundColor: Colors
// //                                               .blueGrey, // لون النص داخل الزر
// //                                           minimumSize: const Size(
// //                                               double.infinity, 34), // حجم الزر
// //                                         ),
// //                                         child: const Text('اضف إلى السلة'),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               Text(
// //                 'Total: $totalCost',
// //                 style: const TextStyle(fontSize: 20),
// //               ),
// //               const SizedBox(height: 20),
// //               Stack(
// //                 children: [
// //                   LinearProgressIndicator(
// //                     minHeight: 50,
// //                     value: progressValue, // قيمة التقدم من 0.0 إلى 1.0
// //                     backgroundColor: Colors.grey[200],
// //                     valueColor:
// //                         const AlwaysStoppedAnimation<Color>(Colors.blue),
// //                   ),
// //                   Positioned(
// //                     right: (1 - progressValue) *
// //                             MediaQuery.of(context).size.width -
// //                         24, // تعديل هنا
// //                     top: 0,
// //                     bottom: 0,
// //                     child: const Icon(
// //                       Icons.shopping_cart, // أيقونة سلة التسوق
// //                       size: 24, // حجم الأيقونة
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           );
// //         } else if (state is ProductsLoading) {
// //           return const Center(child: CircularProgressIndicator());
// //         } else {
// //           // Handle other states
// //           return Container();
// //         }
// //       },
// //     );
// //   }
// // }

// import 'dart:convert';

// import 'package:eghyptproject/Featuer/cart/presentation/view/cart_view.dart';
// import 'package:eghyptproject/Featuer/cart/presentation/view/widget/cart.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_cubit.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_state.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/search_view.dart';
// import 'package:eghyptproject/core/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CategoriesPageFS extends StatefulWidget {
//   final int id;
//   final SupplierModel supplier;
//   const CategoriesPageFS({super.key, required this.id, required this.supplier});

//   @override
//   _CategoriesPageFSState createState() => _CategoriesPageFSState();
// }

// class _CategoriesPageFSState extends State<CategoriesPageFS> {
//   List<Product> selectedProducts = [];
//   List<Map<String, dynamic>> orders = [];
//   Map<int, String> supplierNames = {}; // Add this map to store supplier names

//   @override
//   void initState() {
//     super.initState();
//     _loadOrdersFromSharedPreferences();
//     _populateSupplierNames(); // Initialize supplier names
//   }

//   void _populateSupplierNames() {
//     // Add suppliers to the map
//     supplierNames[widget.supplier.id] = widget.supplier.storeName;
//     // Add more suppliers as needed
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         final cubit = CategoryCubit(ApiProvider());
//         _loadTokenAndInit(cubit, widget.id);
//         return cubit;
//       },
//       child: BlocBuilder<CategoryCubit, CategoryState>(
//         builder: (context, state) {
//           if (state is CategoryLoaded) {
//             return DefaultTabController(
//               length: state.categories.length,
//               child: Scaffold(
//                 appBar: AppBar(
//                   actions: [
//                     IconButton(
//                       onPressed: () {
//                         final orderObject = createOrderObject(
//                             widget.supplier.id, selectedProducts);
//                         setState(() {
//                           orders.add(orderObject);
//                         });

//                         //  _saveOrdersToSharedPreferences();
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CartPage(
//                               supplier: widget.supplier,
//                               order: orders,
//                               supplierNames: supplierNames,
//                             ),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.shopping_cart),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         ProductSearchDelegate22();
//                       },
//                       icon: const Icon(Icons.search),
//                     ),
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
//                       create: (context) {
//                         final cubit = ProductCubitSupllier(ApiProvider());
//                         _loadTokenAndInitProduct(category.id, cubit, widget.id);
//                         return cubit;
//                       },
//                       child: ProductsList(
//                         categoryId: category.id,
//                         onProductSelected: (product) {
//                           setState(() {
//                             selectedProducts.add(product);
//                           });
//                           print(selectedProducts);
//                         },
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
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('التصنيفات والمنتجات'),
//               ),
//               body: const Center(
//                 child: CircularProgressIndicator(color: Colors.red),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   // void _loadOrdersFromSharedPreferences() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final String ordersString = prefs.getString('orders');
//   //   if (ordersString != null) {
//   //     setState(() {
//   //       orders = List<Map<String, dynamic>>.from(json.decode(ordersString));
//   //     });
//   //   }
//   // }
//   void _loadOrdersFromSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? ordersString = prefs.getString('orders');
//     if (ordersString != null) {
//       setState(() {
//         orders = List<Map<String, dynamic>>.from(json.decode(ordersString));
//       });
//     }
//   }

//   void _saveOrdersToSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final ordersString = json.encode(orders);
//     await prefs.setString('orders', ordersString);
//   }
// }

// void _loadTokenAndInitProduct(
//     int categoryId, ProductCubitSupllier cubit, int supplierId) async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('access_token');
//   if (token != null) {
//     cubit.fetchProductsByCategory(categoryId, supplierId, token);
//   } else {
//     // Handle token absence
//   }
// }

// void _loadTokenAndInit(CategoryCubit cubit, int categoryId) async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('access_token');
//   if (token != null) {
//     cubit.fetchCategories(categoryId, token);
//   } else {
//     // Handle token absence
//   }
// }

// Map<String, dynamic> createOrderObject(
//     int supplierId, List<Product> selectedProducts) {
//   final Map<int, int> productQuantities = {};

//   for (var product in selectedProducts) {
//     if (productQuantities.containsKey(product.productId)) {
//       productQuantities[product.productId] =
//           productQuantities[product.productId]! + 1;
//     } else {
//       productQuantities[product.productId] = 1;
//     }
//   }

//   return {
//     "supplier_id": supplierId,
//     "payment_method_id": 1,
//     "market_note": "note",
//     "products": productQuantities.entries
//         .map((entry) => {
//               "id": entry.key,
//               "quantity": entry.value,
//             })
//         .toList(),
//   };
// }

// class GlobalFunctions {
//   static void resetTotalCostAndProgress(BuildContext context) {
//     final myAppState = context.findAncestorStateOfType<ProductsListState>();
//     if (myAppState != null) {
//       myAppState.resetTotalCostAndProgress();
//     }
//   }
// }

// class ProductsList extends StatefulWidget {
//   final int categoryId;
//   final Function(Product) onProductSelected;

//   const ProductsList(
//       {Key? key, required this.categoryId, required this.onProductSelected})
//       : super(key: key);

//   @override
//   ProductsListState createState() => ProductsListState();
// }

// class ProductsListState extends State<ProductsList> {
//   double totalCost = 0.0;
//   double progressValue = 0.0;
//   void resetTotalCostAndProgress() {
//     setState(() {
//       totalCost = 0.0;
//       progressValue = 0.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     double cardMargin = screenWidth * 0.05;
//     double borderRadius = screenWidth * 0.02;
//     double paddingAllSides = screenWidth * 0.02;
//     double imageSize = screenWidth * 0.18;

//     return BlocConsumer<ProductCubitSupllier, ProductStateSupllier>(
//       listener: (context, state) {
//         if (state is ProductsError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('حدث خطأ: ${state.errorMessage}')),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is ProductsLoaded && state.categoryId == widget.categoryId) {
//           progressValue = totalCost >= state.supplier!.minBillPrice
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
//                               const SizedBox(width: 8),
//                               Expanded(
//                                   child: ListTile(
//                                 title: Text('${product.name}'),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(product.discription),
//                                     const SizedBox(height: 4),
//                                     Row(
//                                       children: [
//                                         Text("${product.price}"),
//                                         if (product.offerPrice > 0) ...[
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             "${product.offerPrice}",
//                                             style: const TextStyle(
//                                                 color: Colors.green),
//                                           ),
//                                           const Text(
//                                             " عرض خاص",
//                                             style:
//                                                 TextStyle(color: Colors.green),
//                                           ),
//                                         ],
//                                       ],
//                                     ),
//                                     const SizedBox(height: 8),
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           Cart().addProduct(product,
//                                               state.supplier!.firstName);
//                                           totalCost = Cart()
//                                               .calculateTotalAndQuantity();
//                                           widget.onProductSelected(product);
//                                         });
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         foregroundColor: Colors.white,
//                                         backgroundColor: Colors.blueGrey,
//                                         minimumSize:
//                                             const Size(double.infinity, 34),
//                                       ),
//                                       child: const Text('اضف إلى السلة'),
//                                     ),
//                                   ],
//                                 ),
//                               )),
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
//                 'السعر الاجمالي: $totalCost',
//                 style: const TextStyle(fontSize: 20),
//               ),
//               const SizedBox(height: 20),
//               Stack(
//                 children: [
//                   LinearProgressIndicator(
//                     minHeight: 50,
//                     value: progressValue,
//                     backgroundColor: Colors.grey[200],
//                     valueColor:
//                         const AlwaysStoppedAnimation<Color>(Colors.blue),
//                   ),
//                   Positioned(
//                     right:
//                         MediaQuery.of(context).size.width * progressValue - 16,
//                     top: 0,
//                     bottom: 0,
//                     child: const Icon(
//                       Icons.shopping_cart,
//                       size: 32,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         } else if (state is ProductsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_cubit.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../cart/presentation/view/cart_view.dart';

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

//     return BlocConsumer<ProductCubitSupllier, ProductStateSupllier>(
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
//                               //   width: imageSize, // عرض الصورة
//                               //   height: imageSize, // ارتفاع الصورة
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

// ignore_for_file: unused_element

import 'dart:convert';

import 'package:eghyptproject/Featuer/Companies/presentation/view/companies_page.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_cubit.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_state.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/product_supplier_view.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/search_view.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesPageFS extends StatefulWidget {
  final String type;
  final int id;
  final SupplierModel? supplier;
  const CategoriesPageFS(
      {super.key,
      required this.id,
      @required this.supplier,
      required this.type});

  @override
  CategoriesPageFSState createState() => CategoriesPageFSState();
}

class CategoriesPageFSState extends State<CategoriesPageFS> {
  List<Product> selectedProducts = [];
  List<Map<String, dynamic>> orders = [];
  Map<int, String> supplierNames = {}; // Add this map to store supplier names
  late CategoryCubit categoryCubit;
  @override
  void initState() {
    super.initState();
    categoryCubit = CategoryCubit(ApiProvider());

    _loadOrdersFromSharedPreferences();
    _populateSupplierNames(); // Initialize supplier names
  }

  @override
  void dispose() {
    categoryCubit.close();

    super.dispose();
  }

  void _populateSupplierNames() {
    // Add suppliers to the map
    supplierNames[widget.supplier!.id] = widget.supplier!.storeName;
    // Add more suppliers as needed
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CategoryCubit(ApiProvider());
        _loadTokenAndInit(cubit, widget.id);
        return cubit;
      },
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
            return DefaultTabController(
              length: state.categories.length,
              child: PopScope(
                canPop: false,
                onPopInvoked: (didPop) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePagemasa(
                        type: widget.type,
                      ),
                    ),
                  );

                  // logic
                },
                child: Scaffold(
                  appBar: AppBar(
                    // automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        onPressed: () {
                          ProductSearchDelegate22();
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // setState(() {

                        // });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePagemasa(
                              type: widget.type,
                            ),
                          ),
                        );
                      },
                    ),
                    backgroundColor: Colors.red,
                    title: Text(
                      ' ${widget.supplier!.storeName}',
                      style: Styles.textStyle24(context).copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    centerTitle: true,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
                      child: Material(
                        color: Colors.white,
                        child: TabBar(
                          enableFeedback: false,
                          indicatorColor: kPrimaryColorred,
                          labelColor: kPrimaryColorred,
                          unselectedLabelColor:
                              const Color.fromARGB(255, 53, 49, 49),
                          labelStyle: Styles.textStyle18(context),
                          unselectedLabelStyle: Styles.textStyle18(context),
                          isScrollable: true,
                          tabs: state.categories
                              .map((category) => Tab(text: category.name))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: state.categories.map((category) {
                      return BlocProvider(
                        create: (context) {
                          final cubit = ProductCubitSupllier(ApiProvider());
                          _loadTokenAndInitProduct(
                              category.id, cubit, widget.id);
                          return cubit;
                        },
                        child: ProductsList(
                          supplier: widget.supplier,
                          order: orders,
                          supplierNames: supplierNames,
                          minBillPrice: widget.supplier!.minBillPrice,
                          minSellingQuantity:
                              widget.supplier!.minSellingQuantity,
                          categoryId: category.id,
                          onProductSelected: (product) {
                            setState(() {
                              selectedProducts.add(product);
                            });
                          },
                          type: widget.type,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          } else if (state is CategoryError) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.red,
                title: const Text('التصنيفات والمنتجات'),
              ),
              body: Center(child: Text('حدث خطأ: ${state.errorMessage}')),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('التصنيفات والمنتجات'),
              ),
              body: buildLoadingIndicator(),
            );
          }
        },
      ),
    );
  }

  // void _loadOrdersFromSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String ordersString = prefs.getString('orders');
  //   if (ordersString != null) {
  //     setState(() {
  //       orders = List<Map<String, dynamic>>.from(json.decode(ordersString));
  //     });
  //   }
  // }
  void _loadOrdersFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String? ordersString = prefs.getString('orders');
    if (ordersString != null) {
      setState(() {
        orders = List<Map<String, dynamic>>.from(json.decode(ordersString));
      });
    }
  }

  void _saveOrdersToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersString = json.encode(orders);
    await prefs.setString('orders', ordersString);
  }
}

Future<void> _loadTokenAndInitProduct(
    int categoryId, ProductCubitSupllier cubit, int supplierId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  if (token != null) {
    // cubit.fetchProductWithOffer(categoryId, supplierId);
    cubit.fetchProductsByCategory(
      categoryId,
      supplierId,
    );
  } else {
    // Handle token absence
  }
}

void _loadTokenAndInit(CategoryCubit cubit, int categoryId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  if (token != null) {
    cubit.fetchCategories(
      categoryId,
    );
  } else {
    // Handle token absence
  }
}

Map<String, dynamic> createOrderObject(
    int supplierId, List<Product> selectedProducts) {
  final Map<int, int> productQuantities = {};

  for (var product in selectedProducts) {
    if (productQuantities.containsKey(product.productId)) {
      productQuantities[product.productId] =
          productQuantities[product.productId]! + 1;
    } else {
      productQuantities[product.productId] = 1;
    }
  }

  return {
    "supplier_id": supplierId,
    "payment_method_id": 1,
    "market_note": "note",
    "products": productQuantities.entries
        .map((entry) => {
              "id": entry.key,
              "quantity": entry.value,
            })
        .toList(),
  };
}
