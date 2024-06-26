import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/Featuer/Companies/presentation/manger/company_cubit.dart';
import 'package:eghyptproject/Featuer/Companies/presentation/view/slidarcompanies.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/product_list.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/search_view.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../company_repo/comany_repo._implement.dart';
import '../manger/company_state.dart';

class CompaniesPage extends StatefulWidget {
  final String type;
  const CompaniesPage({super.key, required this.type});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawerMethod(),

      backgroundColor: const Color.fromARGB(136, 224, 214, 214),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffE32020),
        title: Text(widget.type,
            style:
                Styles.textStyle24(context).copyWith(color: kPrimaryColorwhit)),
        actions: [
          // IconButton(
          //   color: Colors.white,
          //   onPressed: () {
          //     showSearch(
          //       context: context,
          //       delegate: ProductSearchDelegate22(),
          //     );
          //   },
          //   icon: const Icon(Icons.search),
          // ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  color: Colors.white,
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => HomePagemasa(
            //             type: widget.type,
            //           )),
            // );
            //  GoRouter.of(context).pop(AppRouter.kHomeView);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        centerTitle: true,
      ),

      body: BlocProvider(
        create: (context) {
          final cubit = DataCubitCompany(
              DataRepository(widget.type)); // مؤقتًا، سنترك الـ token فارغًا
          _loadTokenAndInit(cubit);
          return cubit;
        },
        child: BlocBuilder<DataCubitCompany, DataState>(
          builder: (context, state) {
            if (state is DataLoaded) {
              return Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double crossAxisSpacing = 1;
                    double mainAxisSpacing = 2;
                    int crossAxisCount = (constraints.maxWidth / 200).floor();
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: ProductSearchDelegate22(),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            color: kPrimaryColorred,
                            child: Container(
                              height: 54,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2, // عرض الإطار الأحمر
                                ),
                                borderRadius: BorderRadius.circular(
                                    12), // زوايا مستديرة أكثر
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // يضيف الظل أسفل الـContainer
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        16.0), // إضافة بعض المساحة حول المحتوى
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // ترتيب العناصر بأقصى الجوانب
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      'قارن أسعارك من هنا',
                                      textAlign: TextAlign.start,
                                      style:
                                          Styles.textStyle20(context).copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight
                                            .bold, // جعل النص عريضًا لتحسين ظهوره
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 9 / 4,
                          child: MySliderCompanyPagemove(
                            type: widget.type,
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: state.suppliers.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: mainAxisSpacing,
                                crossAxisSpacing: crossAxisSpacing,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                var supplier = state.suppliers[index];

                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoriesPageFS(
                                                    id: supplier.id,
                                                    supplier: supplier,
                                                    type: widget.type,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: SizedBox(
                                        width: 130,
                                        height: 300,
                                        child: Card(
                                          borderOnForeground: true,
                                          color: Colors.white,
                                          elevation: 1,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                132, 80, 2),
                                                        radius: 35,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                supplier.image,
                                                                scale: 1.0),
                                                        onBackgroundImageError:
                                                            (exception,
                                                                stackTrace) {}, // استبدل offer.imageUrl بالمتغير الذي يحتوي على عنوان URL للصورة
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 90,
                                                      height: 30,
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          supplier.storeName,
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3),
                                                  child: Text(supplier.location,
                                                      style: Styles.textStyle18(
                                                          context)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3),
                                                  child: Text(
                                                      '${supplier.deliveryDuration}',
                                                      style: Styles.textStyle18(
                                                          context)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3),
                                                  child: Text(
                                                      'الحد الأدنى: ${supplier.minBillPrice}',
                                                      style: Styles.textStyle18(
                                                          context)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3),
                                                  child: Text(
                                                      'اقل عدد منتجات:${supplier.minSellingQuantity}',
                                                      style: Styles.textStyle18(
                                                          context)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              }),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else if (state is DataLoading) {
              return buildLoadingIndicator();
            } else if (state is DataError) {
              return builError(state.message);
            }
            return Center(
                child: SvgPicture.asset('assets/images/No data-pana (2).svg'));
          },
        ),
      ),
      // floatingActionButton: CircleAvatar(child: FlutterLogo(),),
    );
  }

  Drawer drawerMethod() {
    return Drawer(
      child: FutureBuilder<String?>(
        future: _getFirstName(),
        builder: (context, snapshot) {
          final savedFirstName = snapshot.data;
          return ListView(
            children: [
              Container(
                height: 130,
                color: const Color(0xffE32020),
                child: Center(
                  child: Text(
                      savedFirstName != null
                          ? 'أهلا بك $savedFirstName'
                          : 'أهلا بك',
                      style: Styles.textStyle28(context).copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),

              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Color(0xffE32020),
                ),
                title: const Text('بياناتي'),
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kMyDataView);
                },
              ),
              // ListTile(
              //   leading:
              //       const Icon(Icons.call_outlined, color: Color(0xffE32020)),
              //   title: const Text(' اتصل بنا'),
              //   onTap: () {},
              // ),
              ListTile(
                leading: const Icon(Icons.add, color: Color(0xffE32020)),
                title: const Text('اشترك'),
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kSubscriebView);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 180, 32, 22),
                ),
                title: BlocConsumer<UserCubitCubit, UserCubitState>(
                  listener: (context, state) {
                    if (state is LogoutFailure) {
                      showCustomSnackBar(context, state.errorMessage,
                          color: Colors.red);
                    } else if (state is LogoutSuccess) {
                      showCustomSnackBar(context, state.message,
                          color: Colors.green);
                    }
                  },
                  builder: (context, state) {
                    if (state is LogoutLoading) {
                      return buildLoadingIndicator();
                    }
                    return const Text(
                      'تسجيل الخروج',
                    );
                  },
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('تأكيد تسجيل الخروج',
                            style: TextStyle(color: Colors.red)),
                        content: const Text(
                            'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                            style: TextStyle(color: Colors.black)),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('إلغاء',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop(); // Dismiss the dialog
                            },
                          ),
                          TextButton(
                            child: const Text('تسجيل الخروج',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              // Call the logout method here
                              BlocProvider.of<UserCubitCubit>(context).logout();
                              Navigator.of(dialogContext)
                                  .pop(); // Dismiss the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<String?> _getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('first_name');
  }

  void _loadTokenAndInit(DataCubitCompany cubit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(
        'access_token'); // 'token' هو المفتاح الذي تم استخدامه لحفظ الرمز المميز
    if (token != null) {
      cubit.fetchData(); // تعيين الـ token في الـ repository
    } else {
      // يمكنك التعامل مع حالة عدم وجود الرمز المميز هنا
      // مثلاً بإظهار رسالة خطأ أو بالانتقال إلى صفحة تسجيل الدخول
    }
  }
}
