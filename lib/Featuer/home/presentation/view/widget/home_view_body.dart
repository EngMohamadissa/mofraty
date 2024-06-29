import 'package:eghyptproject/Featuer/Companies/presentation/view/companies_page.dart';
import 'package:eghyptproject/Featuer/home/presentation/manger/cubit/home_cubit.dart';
import 'package:eghyptproject/Featuer/home/presentation/view/widget/column_circle_avatar_item.dart';
import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';
import 'package:eghyptproject/core/utils/app_router.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/styles.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  var selectIndex = 0;
  final List<String> imagePaths = [
    'assets/images/شركات.png',
    'assets/images/موردين.png',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // إنشاء HomeCubit وتحميل البيانات باستخدام الرمز المميز المحفوظ
        final cubit = HomeCubit();
        loadTokenAndInit(cubit);
        return cubit;
      },
      child: BlocConsumer<HomeCubit, SupplierState>(
        listener: (context, state) {
          if (state is SupplierError) {
            if (state.message == '.الرجاء تسجيل الدخول أولا') {
              GoRouter.of(context).push(AppRouter.kloginView);
            }
            showCustomSnackBar(context, state.message, color: Colors.red);
          } else if (state is SupplierErrortoken) {
            GoRouter.of(context).push(AppRouter.kloginView);
          }
        },
        builder: (context, state) {
          if (state is SupplierLoading) {
            return buildLoadingIndicator();
          } else if (state is SupplierLoaded &&
              state.supplierCategories.isNotEmpty) {
            final sortedCategories = state.supplierCategories
              ..sort((a, b) => a.id.compareTo(b.id));
            return ListView(
              children: [
                // margin: const EdgeInsets.symmetric(vertical: 6.0),
                // height: MediaQuery.of(context).size.width < 600
                //     ? 230
                //     : 200, // Adjust height based on screen width
                // width: MediaQuery.of(context).size.width < 600
                //     ? 200
                //     : 250, // Adjust width based on screen width
                const MyHomePagemove(),

                SizedBox(
                    height: MediaQuery.of(context).size.width < 600
                        ? 16
                        : 20), // Adjust height based on screen width
                Text(
                  'اشتري منتجاتك بأقل الأسعار',
                  style: Styles.textStyle24(context)
                      .copyWith(color: const Color.fromARGB(255, 60, 7, 70)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width < 600 ? 50 : 70),
                ListView.builder(
                  shrinkWrap: true, // لتجنب الأخطاء مع الـ ListView المتداخل
                  physics: const NeverScrollableScrollPhysics(),

                  // لتجنب التمرير الداخلي
                  itemCount: sortedCategories.length,
                  itemBuilder: (context, index) {
                    final category = sortedCategories[index];
                    return ColumnCircleAvatarItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePagemasa(
                                    type: category.type,
                                  )),
                        );
                      },
                      text: category.type,
                      subText: 'اشتري من ${category.type}',
                      imagePath: imagePaths[index % imagePaths.length],
                    );
                  },
                ),
              ],
            );
          } else if (state is SupplierError) {
            return builError(state.message);
          }
          return Container();
        },
      ),
    );
  }
}
