// // ignore_for_file: invalid_use_of_protected_member

// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiProvider {
//   final Dio dio = Dio();

//   ApiProvider();

//   Future<SupplierModel> fetchSupplier(int id, String token) async {
//     dio.options.headers['Authorization'] = 'Bearer $token';
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     return SupplierModel.fromJson(response.data['supplier']);
//   }

//   Future<List<ProductCategory>> fetchCategories(int id, String token) async {
//     dio.options.headers['Authorization'] = 'Bearer $token';

//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     final List<dynamic> categoriesJson = response.data['product_categories'];
//     return categoriesJson
//         .map((json) => ProductCategory.fromJson(json))
//         .toList();
//   }

//   Future<List<Product>> fetchAllProducts(int id, String token) async {
//     dio.options.headers['Authorization'] = 'Bearer $token';

//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     final List<dynamic> productsJson = response.data['products_without_offer'];
//     return productsJson.map((json) => Product.fromJson(json)).toList();
//   }

//   Future<List<Product>> fetchProductsByCategory(
//       int categoryId, int id, String token) async {
//     dio.options.headers['Authorization'] = 'Bearer $token';

//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     final List<dynamic> productsJson = response.data['products_without_offer'];
//     return productsJson
//         .where((json) => json['product_category_id'] == categoryId)
//         .map((json) => Product.fromJson(json))
//         .toList();
//   }
// }

// class CategoryCubit extends Cubit<CategoryState> {
//   final ApiProvider apiProvider;

//   CategoryCubit(this.apiProvider) : super(CategoryInitial());

//   void fetchCategories(int id, String token) async {
//     try {
//       emit(CategoryLoading());
//       final categories = await apiProvider.fetchCategories(id, token);
//       // إضافة فئة افتراضية لـ "الكل"
//       final allCategory = ProductCategory(id: 0, name: 'الكل');
//       emit(CategoryLoaded([allCategory, ...categories]));
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       emit(CategoryError(errorMessage));
//     } catch (e) {
//       emit(CategoryError("An unexpected error occurred: ${e.toString()}"));
//     }
//   }
// }

// class ProductCubitSupllier extends Cubit<ProductStateSupllier> {
//   final ApiProvider apiProvider;

//   ProductCubitSupllier(this.apiProvider) : super(ProductsInitial());

// // ProductCubit.dart continuation
//   void fetchProductsByCategory(int categoryId, int id, String token) async {
//     try {
//       emit(ProductsLoading());
//       List<Product> products;
//       SupplierModel? supplier;

//       if (categoryId == 0) {
//         // إذا كان categoryId يساوي 0، نريد جلب جميع المنتجات
//         products = await apiProvider.fetchAllProducts(id, token);
//       } else {
//         // وإلا، نجلب المنتجات حسب الفئة
//         products =
//             await apiProvider.fetchProductsByCategory(categoryId, id, token);
//       }
//       // جلب معلومات المورد
//       supplier = await apiProvider.fetchSupplier(id, token);
//       emit(ProductsLoaded(products, categoryId, supplier));
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       emit(ProductsError(errorMessage));
//     } catch (e) {
//       emit(ProductsError("An unexpected error occurred: ${e.toString()}"));
//     }
//   }

//   Future<List<Product>> fetchProductWithOffer(int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs
//         .getString('access_token'); // Retrieve token from shared preferences

//     dio.options.headers['Authorization'] = 'Bearer $token';

//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     final List<dynamic> productsJson = response.data['products_with_offer'];
//     return productsJson.map((json) => Product.fromJson(json)).toList();
//   }
// }

// ignore_for_file: invalid_use_of_protected_member

import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/product_supllier_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ApiProvider {
//   final Dio dio = Dio();

//   ApiProvider();

//   Future<SupplierModel> fetchSupplier(int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs
//         .getString('access_token'); // Retrieve token from shared preferences

//     dio.options.headers['Authorization'] = 'Bearer $token';
//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     return SupplierModel.fromJson(response.data['supplier']);
//   }

//   Future<List<ProductCategory>> fetchCategories(int id, String token) async {
//     dio.options.headers['Authorization'] = 'Bearer $token';

//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     final List<dynamic> categoriesJson = response.data['product_categories'];
//     return categoriesJson
//         .map((json) => ProductCategory.fromJson(json))
//         .toList();
//   }

//   Future<List<Product>> fetchAllProducts(int id, String token) async {
//     dio.options.headers['Authorization'] = 'Bearer $token';

//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     final List<dynamic> productsJson = response.data['products_without_offer'];
//     return productsJson.map((json) => Product.fromJson(json)).toList();
//   }

//   Future<List<Product>> fetchProductsByCategory(
//       int categoryId, int id, String token) async {
//     dio.options.headers['Authorization'] = 'Bearer $token';

//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     final List<dynamic> productsJson = response.data['products_without_offer'];
//     return productsJson
//         .where((json) => json['product_category_id'] == categoryId)
//         .map((json) => Product.fromJson(json))
//         .toList();
//   }

//   Future<List<Product>> fetchProductWithOffer(int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs
//         .getString('access_token'); // Retrieve token from shared preferences

//     dio.options.headers['Authorization'] = 'Bearer $token';

//     final response = await dio
//         .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
//     final List<dynamic> productsJson = response.data['products_with_offer'];
//     return productsJson.map((json) => Product.fromJson(json)).toList();
//   }
// }

// // class CategoryCubit extends Cubit<CategoryState> {
// //   final ApiProvider apiProvider;

// //   CategoryCubit(this.apiProvider) : super(CategoryInitial());

// //   void fetchCategories(int id, String token) async {
// //     try {
// //       emit(CategoryLoading());
// //       final categories = await apiProvider.fetchCategories(id, token);
// //       // إضافة فئة افتراضية لـ "الكل"
// //       final allCategory = ProductCategory(id: 0, name: 'الكل');
// //       emit(CategoryLoaded([allCategory, ...categories]));
// //     } on DioException catch (e) {
// //       String errorMessage = ErrorHandler.handleDioError(e);
// //       emit(CategoryError(errorMessage));
// //     } catch (e) {
// //       emit(CategoryError("An unexpected error occurred: ${e.toString()}"));
// //     }
// //   }
// // }

// // /////////////////////////////////////////////,,,,,,,,,

// class CategoryCubit extends Cubit<CategoryState> {
//   final ApiProvider apiProvider;

//   CategoryCubit(this.apiProvider) : super(CategoryInitial());

//   void fetchCategories(int id, String token) async {
//     try {
//       emit(CategoryLoading());
//       final categories = await apiProvider.fetchCategories(id, token);
//       final allCategory = ProductCategory(id: 0, name: 'الكل');

//       if (!isClosed) emit(CategoryLoaded([allCategory, ...categories]));
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       if (!isClosed) emit(CategoryError(errorMessage));
//     } catch (e) {
//       if (!isClosed) {
//         emit(CategoryError("An unexpected error occurred: ${e.toString()}"));
//       }
//     }
//   }

//   @override
//   bool get isClosed => state is! CategoryInitial && state is! CategoryLoading;
// }

// // class ProductCubitSupllier extends Cubit<ProductStateSupllier> {
// //   final ApiProvider apiProvider;

// //   ProductCubitSupllier(this.apiProvider) : super(ProductsInitial());

// // // ProductCubit.dart continuation
// //   void fetchProductsByCategory(int categoryId, int id, String token) async {
// //     try {
// //       emit(ProductsLoading());
// //       List<Product> products;
// //       SupplierModel? supplier;

// //       if (categoryId == 0) {
// //         products = await apiProvider.fetchAllProducts(id, token);
// //       } else {
// //         products =
// //             await apiProvider.fetchProductsByCategory(categoryId, id, token);
// //       }
// //       supplier = await apiProvider.fetchSupplier(id);
// //       emit(ProductsLoaded(products, categoryId, supplier));
// //     } on DioException catch (e) {
// //       String errorMessage = ErrorHandler.handleDioError(e);
// //       emit(ProductsError(errorMessage));
// //     } catch (e) {
// //       emit(ProductsError("An unexpected error occurred: ${e.toString()}"));
// //     }
// //   }

// //   void fetchProductWithOffer(int id) async {
// //     try {
// //       emit(WithOfferLoading());
// //       List<Product> products;
// //       SupplierModel? supplier;
// //       products = await apiProvider.fetchProductWithOffer(id);
// //       supplier = await apiProvider.fetchSupplier(id);
// //       emit(WithOfferSuccess(products, supplier));
// //     } on DioException catch (e) {
// //       String errorMessage = ErrorHandler.handleDioError(e);
// //       emit(WithOfferError(errorMessage));
// //     } catch (e) {
// //       emit(WithOfferError("An unexpected error occurred: ${e.toString()}"));
// //     }
// //   }
// // }
// class ProductCubitSupllier extends Cubit<ProductStateSupllier> {
//   final ApiProvider apiProvider;

//   ProductCubitSupllier(this.apiProvider) : super(ProductsInitial());

//   Future<void> fetchProductsByCategory(
//       int categoryId, int id, String token) async {
//     try {
//       emit(ProductsLoading());
//       List<Product> products;
//       SupplierModel? supplier;

//       if (categoryId == 0) {
//         products = await apiProvider.fetchAllProducts(id, token);
//       } else {
//         products =
//             await apiProvider.fetchProductsByCategory(categoryId, id, token);
//       }
//       supplier = await apiProvider.fetchSupplier(id);

//       if (!isClosed) emit(ProductsLoaded(products, categoryId, supplier));
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       if (!isClosed) emit(ProductsError(errorMessage));
//     } catch (e) {
//       if (!isClosed)
//         emit(ProductsError("An unexpected error occurred: ${e.toString()}"));
//     }
//   }

//   void fetchProductWithOffer(int id) async {
//     try {
//       emit(WithOfferLoading());
//       List<Product> products = await apiProvider.fetchProductWithOffer(id);
//       SupplierModel? supplier = await apiProvider.fetchSupplier(id);

//       if (!isClosed) emit(WithOfferSuccess(products, supplier));
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       if (!isClosed) emit(WithOfferError(errorMessage));
//     } catch (e) {
//       if (!isClosed)
//         emit(WithOfferError("An unexpected error occurred: ${e.toString()}"));
//     }
//   }

//   @override
//   bool get isClosed =>
//       state is! ProductsInitial &&
//       state is! ProductsLoading &&
//       state is! WithOfferLoading;
// }

///////////////////////........///
///
///
///
///

class ApiProvider {
  final Dio dio = Dio();

  ApiProvider();

  Future<Map<String, dynamic>> fetchSupplierData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences

    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio
        .get('https://backend.almowafraty.com/api/v1/markets/suppliers/$id');
    return response.data;
  }
}

class CategoryCubit extends Cubit<CategoryState> {
  final ApiProvider apiProvider;

  CategoryCubit(this.apiProvider) : super(CategoryInitial());

  void fetchCategories(int id) async {
    try {
      emit(CategoryLoading());
      final response = await apiProvider.fetchSupplierData(id);
      final List<dynamic> categoriesJson = response['product_categories'];
      final categories =
          categoriesJson.map((json) => ProductCategory.fromJson(json)).toList();
      // إضافة فئة افتراضية لـ "الكل"
      final allCategory = ProductCategory(id: 0, name: 'الكل');
      emit(CategoryLoaded([allCategory, ...categories]));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      print('fetchCategories$e');
      emit(CategoryError(errorMessage));
    } catch (e) {
      print('fetchCategories$e');

      emit(CategoryError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}

class ProductCubitSupllier extends Cubit<ProductStateSupllier> {
  final ApiProvider apiProvider;

  ProductCubitSupllier(this.apiProvider) : super(ProductsInitial());

  void fetchProductsByCategory(int categoryId, int id) async {
    try {
      emit(ProductsLoading());
      final response = await apiProvider.fetchSupplierData(id);
      final supplier = SupplierModel.fromJson(response['supplier']);
      final List<dynamic> productsJson = response['products_without_offer'];
      final List<Product> products = productsJson
          .where((json) =>
              categoryId == 0 || json['product_category_id'] == categoryId)
          .map((json) => Product.fromJson(json))
          .toList();
      emit(ProductsLoaded(products, categoryId, supplier));
    } on DioException catch (e) {
      print('fetchProductsByCategory$e');

      String errorMessage = ErrorHandler.handleDioError(e);
      emit(ProductsError(errorMessage));
    } catch (e) {
      print('fetchProductsByCategory$e');
      emit(ProductsError("An unexpected error occurred: ${e.toString()}"));
    }
  }

  void fetchProductWithOffer(int categoryId, int id) async {
    try {
      emit(WithOfferLoading());
      final response = await apiProvider.fetchSupplierData(id);
      final supplier = SupplierModel.fromJson(response['supplier']);
      final List<dynamic> productsJson = response['products_with_offer'];
      final List<Product> products = productsJson
          .where((json) =>
              categoryId == 0 || json['product_category_id'] == categoryId)
          .map((json) => Product.fromJson(json))
          .toList();
      // final products =
      //     productsJson.map((json) => Product.fromJson(json)).toList();
      emit(WithOfferSuccess(products, categoryId, supplier));
    } on DioException catch (e) {
      print('fetchProductsByCategory$e');
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(WithOfferError(errorMessage));
    } catch (e) {
      print('fetchProductsByCategory$e');
      emit(WithOfferError("An unexpected error occurred: ${e.toString()}"));
    }
  }

  void getOffersSlider(int id) async {
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('access_token');

    try {
      emit(OffersSliderLoading());
      // final options = Options(
      //   headers: {
      //     'Authorization': 'Bearer $token',
      //   },
      // );
      // استخدم dio مع الـ headers لجلب البيانات من الـ API
      final response = await apiProvider.fetchSupplierData(id);

      final offers = (response['slider_offers'] as List)
          .map((e) => Offer.fromJson(e))
          .toList();

      emit(OffersSliderLoaded(offers: offers));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      print('fetchCategories$e');
      emit(OffersSliderError(message: errorMessage));
    } catch (e) {
      emit(OffersSliderError(message: e.toString()));
    }
  }
}

// class OffersSliderCubit extends Cubit<ProductStateSupllier> {
//   final ApiProvider apiProvider;

//   OffersSliderCubit(this.apiProvider) : super(ProductsInitial());

//   void getOffersSlider(int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');

//     try {
//       emit(OffersSliderLoading());
//       final options = Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       // استخدم dio مع الـ headers لجلب البيانات من الـ API
//       final response = await apiProvider.fetchSupplierData(id);

//       final offers = (response['slider_offers'] as List)
//           .map((e) => Offer.fromJson(e))
//           .toList();

//       emit(OffersSliderLoaded(offers: offers));
//     } catch (e) {
//       emit(OffersSliderError(message: e.toString()));
//     }
//   }
// }
