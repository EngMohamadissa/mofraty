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
