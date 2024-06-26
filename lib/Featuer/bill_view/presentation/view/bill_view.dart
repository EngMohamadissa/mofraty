import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_cubit.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_state.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/view/widget/bill_body.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class BillsView extends StatelessWidget {
//   const BillsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: const Color(0xffE8E2E2),
//         appBar: AppBar(
//           title: const Center(
//             child: Text('فواتيري',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//           ),
//           automaticallyImplyLeading: false,
//           backgroundColor: const Color(0xffE32020),
//           bottom: TabBar(
//             labelStyle:
//                 const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             dividerColor: Colors.white,
//             indicatorColor: Colors.black,
//             labelColor: Colors.black,
//             indicatorSize: TabBarIndicatorSize.label,
//             unselectedLabelColor: const Color.fromARGB(255, 61, 60, 60),
//             onTap: (index) {
//               final billCubit = context.read<BillCubitGet>();
//               if (index == 0) {
//                 billCubit.getBills(BillType.current); // للفواتير الحالية
//               } else {
//                 billCubit.getBills(BillType.previous); // للفواتير السابقة
//               }
//             },
//             tabs: const [
//               Tab(text: 'الفواتير الحالية'),
//               Tab(text: 'الفواتير السابقة'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // استخدام BlocBuilder لإعادة بناء الواجهة عند تغيير الحالة
//             BlocBuilder<BillCubitGet, BillStateGet>(
//               builder: (context, state) {
//                 if (state is BillLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is BillLoaded && state.statusBill == 'حالية') {
//                   return const BillBody();
//                 } else if (state is BillError) {
//                   return Center(child: Text(state.message));
//                 }
//                 return const Center(child: Text('لا توجد فواتير حالية'));
//               },
//             ),
//             BlocBuilder<BillCubitGet, BillStateGet>(
//               builder: (context, state) {
//                 if (state is BillLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is BillLoaded && state.statusBill == 'سابقة') {
//                   return const BillBody(); // يجب تمرير البيانات إلى BillBody
//                 } else if (state is BillError) {
//                   return Center(child: Text(state.message));
//                 }
//                 return const Center(child: Text('لا توجد فواتير سابقة'));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class BillsView extends StatelessWidget {
  final int initialTabIndex;
  const BillsView({super.key, required this.initialTabIndex});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialTabIndex,
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffE8E2E2),
        appBar: AppBar(
          title: const Center(
            child: Text('فواتيري',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: kPrimaryColorwhit)),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColorred,
          bottom: TabBar(
            labelStyle: const TextStyle(
              fontSize: 22,
            ),
            dividerColor: kPrimaryColorwhit,
            indicatorColor: kPrimaryColorwhit,
            labelColor: kPrimaryColorwhit,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: kPrimaryColorwhit,
            onTap: (index) {
              final billCubit = context.read<BillCubitGet>();
              if (index == 0) {
                billCubit.getBills(BillType.current); // للفواتير الحالية
              } else {
                billCubit.getBills(BillType.previous); // للفواتير السابقة
              }
            },
            tabs: const [
              Tab(text: 'الفواتير الحالية'),
              Tab(text: 'الفواتير السابقة'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // استخدام BlocBuilder لإعادة بناء الواجهة عند تغيير الحالة
            BlocBuilder<BillCubitGet, BillStateGet>(
              builder: (context, state) {
                if (state is BillLoading) {
                  return buildLoadingIndicator();
                } else if (state is BillLoaded && state.statusBill == 'حالية') {
                  return const BillBody();
                } else if (state is BillError) {
                  return Center(child: Text(state.message));
                }
                return buildLoadingIndicator();
              },
            ),
            BlocBuilder<BillCubitGet, BillStateGet>(
              builder: (context, state) {
                if (state is BillLoading) {
                  return buildLoadingIndicator();
                } else if (state is BillLoaded && state.statusBill == 'سابقة') {
                  return const BillBody(); // يجب تمرير البيانات إلى BillBody
                } else if (state is BillError) {
                  return Center(child: Text(state.message));
                }
                return buildLoadingIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
