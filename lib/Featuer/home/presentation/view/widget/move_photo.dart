import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePagemove extends StatefulWidget {
  const MyHomePagemove({
    super.key,
  });

  @override
  MyHomePagemoveState createState() => MyHomePagemoveState();
}

class MyHomePagemoveState extends State<MyHomePagemove> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _offerLength = 0; // متغير لحفظ طول القائمة

  @override
  void initState() {
    super.initState();

    // نستخدم addPostFrameCallback لضمان تحميل الويدجت
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        if (_pageController.hasClients && _offerLength > 0) {
          int nextPage = _pageController.page!.round() + 1;
          if (nextPage >= _offerLength) {
            nextPage = 0; // عودة إلى البداية
          }
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersState>(
      builder: (context, state) {
        if (state is OffersLoading) {
          return buildLoadingIndicator();
        } else if (state is OffersLoaded && state.offers.isNotEmpty) {
          _offerLength = state.offers.length; // تحديث طول القائمة
          return AspectRatio(
            aspectRatio: 7 / 4,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _offerLength,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    // تأثيرات تحريك للانتقال بين الصور
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * .5))
                          .clamp(0.0, 1.0); // تغيير القيمة لتأثير أكثر نعومة
                    }
                    return Center(
                      child: SizedBox(
                        // تعديل الأبعاد لجعل الصورة والحاوية أكبر
                        height: Curves.easeOut.transform(value) *
                            MediaQuery.of(context).size.height,
                        width: Curves.easeOut.transform(value) *
                            MediaQuery.of(context).size.width,
                        child: child,
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        // إزالة الهوامش
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(20), // حدود منحنية
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://backend.almowafraty.com/storage/${state.offers[index].image}'),
                            fit: BoxFit.cover, // لتغطية الحاوية بالكامل
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 20,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                      ),

                      // يمكن إضافة المزيد من العناصر هنا إذا لزم الأمر
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is OffersError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container(
          height: 0,
        ); // حالة البداية أو حالات أخرى
      },
    );
  }
}

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

//   @override
//   String toString() {
//     return 'Offer{id: $id, supplierId: $supplierId, image: $image}';
//   }
// }

class Offer {
  final int id;
  final int supplierId;
  final String image;

  Offer({required this.id, required this.supplierId, required this.image});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] ?? 0, // تعيين قيمة افتراضية إذا كانت القيمة مساوية لـ Null
      supplierId: json['supplier_id'] ??
          0, // تعيين قيمة افتراضية إذا كانت القيمة مساوية لـ Null
      image: json['image'] ??
          '', // تعيين قيمة افتراضية إذا كانت القيمة مساوية لـ Null
    );
  }

  @override
  String toString() {
    return 'Offer{id: $id, supplierId: $supplierId, image: $image}';
  }
}

class SupplierCategory {
  final int id;
  final String type;

  SupplierCategory({required this.id, required this.type});

  factory SupplierCategory.fromJson(Map<String, dynamic> json) {
    return SupplierCategory(
      id: json['id'],
      type: json['type'],
    );
  }
}

class OffersCubit extends Cubit<OffersState> {
  final Dio _dio;

  OffersCubit({Dio? dio})
      : _dio = dio ?? Dio(),
        super(OffersInitial());

  void getOffers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    try {
      emit(OffersLoading());
      final options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      // استخدم dio مع الـ headers لجلب البيانات من الـ API
      final response = await _dio.get(
        'https://backend.almowafraty.com/api/v1/markets/starting-page',
        options: options,
      );

      // final offers = (response.data['offers'] as List)
      //     .map((e) => Offer.fromJson(e))
      //     .toList();

      final offers = (response.data['offers'] as List)
          .map((e) => Offer.fromJson(e))
          .toList();

      final categories = (response.data['supplier_categories'] as List)
          .map((e) => SupplierCategory.fromJson(e))
          .toList();
      emit(OffersLoaded(offers: offers, categories: categories));
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(OffersError(message: errorMessage));
    } catch (e) {
      emit(OffersError(message: e.toString()));
    }
  }
}

abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersLoaded extends OffersState {
  final List<Offer> offers;
  final List<SupplierCategory> categories;

  OffersLoaded({required this.offers, required this.categories});
}

class OffersError extends OffersState {
  final String message;

  OffersError({required this.message});
}
