import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductSearch {
  final num productId;
  final num productCategoryId;
  final String description;
  final String name;
  final num size;
  final String sizeOf;
  final num supplierId;
  final num price;
  final num maxSellingQuantity;
  final List<dynamic> image;
  final String productCategory;

  ProductSearch({
    required this.productId,
    required this.productCategoryId,
    required this.description,
    required this.name,
    required this.size,
    required this.sizeOf,
    required this.supplierId,
    required this.price,
    required this.maxSellingQuantity,
    this.image = const [],
    required this.productCategory,
  });

  factory ProductSearch.fromJson(Map<String, dynamic> json) {
    return ProductSearch(
      productId: json['product_id'],
      productCategoryId: json['product_category_id'],
      description: json['discription'],
      name: json['name'],
      size: json['size'],
      sizeOf: json['size_of'],
      supplierId: json['supplier_id'],
      price: json['price'],
      maxSellingQuantity: json['max_selling_quantity'],
      image: json['image'],
      productCategory: json['product_category'],
    );
  }
}

abstract class ProductStateSearch {}

class ProductSearchInitial extends ProductStateSearch {}

class ProductSearchLoading extends ProductStateSearch {}

class ProductSearchLoaded extends ProductStateSearch {
  final List<ProductSearch> products;
  final int currentPage;
  final int lastPage;

  ProductSearchLoaded(this.products, this.currentPage, this.lastPage);
}

class ProductSearchError extends ProductStateSearch {
  final String message;

  ProductSearchError(this.message);
}

class ProductSearchCubit extends Cubit<ProductStateSearch> {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  ProductSearchCubit() : super(ProductSearchInitial());

  void fetchProducts(String query, int page, String token) async {
    emit(ProductSearchLoading());
    try {
      final response = await _dio.get(
        'https://backend.almowafraty.com/api/v1/markets/products',
        queryParameters: {'search': query, 'page': page},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final data = response.data['products'];
      final products = List<ProductSearch>.from(
        data['data'].map((x) => ProductSearch.fromJson(x)),
      );
      emit(ProductSearchLoaded(
          products, data['current_page'], data['last_page']));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(ProductSearchError(errorMessage));
    } catch (e) {
      emit(ProductSearchError("An unexpected error occurred: ${e.toString()}"));
    }
  }

  void fetchInitialProducts(String token) async {
    fetchProducts('', 1, token);
  }
}

// استبدل هذا بمسار ملف ProductCubit الخاص بك

class ProductSearchDelegate22 extends SearchDelegate<void> {
  ProductSearchDelegate22();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  void _loadTokenAndInitProduct(ProductSearchCubit cubit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(
        'access_token'); // 'token' هو المفتاح الذي تم استخدامه لحفظ الرمز المميز
    if (token != null) {
      cubit.fetchProducts(query, 1, token); // استدعاء الدالة مع الـ token
    } else {
      // يمكنك التعامل مع حالة عدم وجود الرمز المميز هنا
      // مثلاً بإظهار رسالة خطأ أو بالانتقال إلى صفحة تسجيل الدخول
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) {
        final cubit = ProductSearchCubit();
        _loadTokenAndInitProduct(cubit);
        return cubit;
      },
      child: BlocBuilder<ProductSearchCubit, ProductStateSearch>(
        builder: (context, state) {
          if (state is ProductSearchLoading) {
            return buildLoadingIndicator();
          } else if (state is ProductSearchLoaded) {
            if (state.products.isEmpty) {
              return Center(
                  child: Column(
                children: [
                  Text(
                    'لا توجد منتجات بهذا الاسم الرجاء التأكد',
                    style: Styles.textStyle24(context),
                  ),
                ],
              ));
            }
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                // var image = state.products[index].image.first;
                return ProductCardSearch(
                  // image: image,
                  product: state.products[index],
                );
              },
            );
          } else if (state is ProductSearchError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('ابدأ البحث'));
          }
        },
      ),
    );
  }

  void _loadTokenAndInit(ProductSearchCubit cubit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(
        'access_token'); // 'token' هو المفتاح الذي تم استخدامه لحفظ الرمز المميز
    if (token != null) {
      cubit.fetchInitialProducts(token); // استخدام الـ token هنا
    } else {
      // يمكنك التعامل مع حالة عدم وجود الرمز المميز هنا
      // مثلاً بإظهار رسالة خطأ أو بالانتقال إلى صفحة تسجيل الدخول
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MediaQuery.of(context).size.width; // للحصول على حجم الشاشة

    return BlocProvider(
      create: (context) {
        final cubit = ProductSearchCubit();
        _loadTokenAndInit(cubit);
        return cubit;
      },
      child: BlocBuilder<ProductSearchCubit, ProductStateSearch>(
        builder: (context, state) {
          if (state is ProductSearchLoading) {
            return buildLoadingIndicator();
          } else if (state is ProductSearchLoaded) {
            // عرض المنتجات الافتراضية
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                // var image = state.products[index].image.first;
                return ProductCardSearch(
                  // image: image,
                  product: state.products[index],
                );
              },
            );
          } else if (state is ProductSearchError) {
            return Center(child: Text(state.message));
          } else {
            // إذا كانت الحالة ليست ProductLoading أو ProductLoaded أو ProductError
            return const Center(child: Text('ابدأ البحث'));
          }
        },
      ),
    );
  }
}

class ProductCardSearch extends StatelessWidget {
  final ProductSearch product;
  // final dynamic image;
  const ProductCardSearch({
    super.key,
    required this.product,
    // required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width >= 600;

    final double horizontalPadding = screenSize.width * 0.02;
    final double verticalPadding = screenSize.height * 0.02;
    final double spacing = screenSize.height * 0.01;
    final double titleSize = isTablet ? 24 : 18;
    final double bodySize = isTablet ? 20 : 16;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Card(
        elevation: 2.0,
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.20,
                child: const Icon(
                  Icons.image,
                  size: 50,
                ),
                // حوالي 20% من عرض الشاشة
                // child: AspectRatio(
                //   aspectRatio: 1, // النسبة المربعة
                //   child: image != null
                //       ? Image.network(
                //           image,
                //           fit: BoxFit
                //               .cover, // يحافظ على نسب الأبعاد ويملأ المساحة المتاحة
                //         )
                //       : Container(
                //           color: Colors.grey[300], // لون خلفية البديل
                //           child: Icon(
                //             Icons.image, // أيقونة بديلة
                //             color: Colors.grey[700], // لون الأيقونة
                //             size: 50, // حجم الأيقونة
                //           ),
                //         ),
                // ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            product.sizeOf,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: titleSize,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: titleSize,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: bodySize,
                        ),
                      ),
                      SizedBox(height: spacing),
                      Text(
                        product.productCategory,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: bodySize,
                        ),
                      ),
                      Text(
                        '${product.price}ج',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: bodySize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
