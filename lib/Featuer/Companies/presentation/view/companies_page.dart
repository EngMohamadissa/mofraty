import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_cubit.dart';
import 'package:eghyptproject/Featuer/cart/presentation/view/cart_view.dart';
import 'package:eghyptproject/Featuer/noftifications_local/presentation/manager/notificationlocal_cubit.dart';
import 'package:eghyptproject/Featuer/noftifications_local/presentation/view/notificationlocale_page.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
import 'package:eghyptproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bill_view/presentation/view/bill_view.dart';
import '../../../target/presentation/view/target_view.dart';
import 'companies_page_view.dart';

class HomePagemasa extends StatefulWidget {
  final String type;

  const HomePagemasa({super.key, required this.type});

  @override
  State<HomePagemasa> createState() => _HomePagemasaState();
}

class _HomePagemasaState extends State<HomePagemasa> {
  int currentIndex = 0;
  late final List<Widget> pages;
  SupplierModel supplier = SupplierModel(
    id: 0, // يفترض أن 0 هو قيمة افتراضية صالحة
    supplierCategoryId: 0, // يفترض أن 0 هو قيمة افتراضية صالحة
    cityId: 0, // إذا كان `cityId` يمكن أن يكون 0 كقيمة افتراضية
    firstName: '', // قيمة فارغة كقيمة افتراضية
    middleName: '', // قيمة فارغة كقيمة افتراضية
    lastName: '', // قيمة فارغة كقيمة افتراضية
    storeName: '', // قيمة فارغة كقيمة افتراضية
    phoneNumber: '', // قيمة فارغة كقيمة افتراضية
    minBillPrice: 0.0, // قيمة افتراضية صالحة إذا كانت القيمة يمكن أن تكون 0
    minSellingQuantity: 0, // قيمة افتراضية صالحة إذا كانت القيمة يمكن أن تكون 0
    status: '', // قيمة فارغة كقيمة افتراضية
    createdAt: DateTime.now(), // تاريخ ووقت الإنشاء الافتراضي
    updatedAt: DateTime.now(), location: '',
    image: '', // تاريخ ووقت التحديث الافتراضي
  ); // قم بإنشاء نموذج افتراضي

  List<Map<String, dynamic>> order = []; // قائمة فارغة بشكل افتراضي
  Map<int, String> supplierNames = {}; // قاموس فارغ بشكل افتراضي
  double minBillPrice = 0.0; // قيمة افتراضية
  int minSellingQuantity = 0;

  @override
  void initState() {
    super.initState();
    // تهيئة pages داخل initState
    pages = [
      CompaniesPage(
        type: widget.type,
      ),
      const BillsView(
        initialTabIndex: 0,
      ),
      CartPage(
        supplier: supplier,
        order: order,
        supplierNames: supplierNames,
        minBillPrice: minBillPrice,
        minSellingQuantity: minSellingQuantity,
        totlepriceSupllier: 0,
      ),

      const NotificationlocalPage(),
      // const NotificationsView(
      //   message: null,
      // ),
      const TrargetView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // الآن يمكن الوصول إلى pages بدون مشاكل
    return Scaffold(
      backgroundColor: const Color(0xffE8E2E2),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: kPrimaryColorred,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;

            if (index == 1) {
              BlocProvider.of<BillCubitGet>(context).getBills(BillType.current);
            }
            if (index == 3) {
              BlocProvider.of<NotificationCubit>(context).fetchNotifications();
            }
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: kPrimaryColorwhit,
              icon: Icon(
                Icons.home_outlined,
                // color: Colors.red,
              ),
              label: 'الرئيسية',
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              backgroundColor: kPrimaryColorwhit,
              icon: Icon(
                Icons.receipt_long,
                // color: Colors.red,
              ),
              label: 'فواتيري'),
          BottomNavigationBarItem(
              backgroundColor: kPrimaryColorwhit,
              icon: Icon(
                Icons.shopping_cart,
                // color: Colors.red,
              ),
              label: 'السلة'),
          BottomNavigationBarItem(
              backgroundColor: kPrimaryColorwhit,
              icon: Icon(
                Icons.notifications,
                // color: Colors.red,
              ),
              label: 'الإشعارات'),
          BottomNavigationBarItem(
            backgroundColor: kPrimaryColorwhit,
            icon: Icon(Icons.crisis_alert_outlined),
            label: 'الأهداف',
          ),
        ],
      ),
    );
  }
}
