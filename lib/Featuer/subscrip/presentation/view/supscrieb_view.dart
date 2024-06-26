import 'package:eghyptproject/Featuer/subscrip/presentation/manager/cubit/supscrieb_cubit.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupscriebPage extends StatelessWidget {
  const SupscriebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorwhit,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'الموفراتي',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              'سوق   التجار',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Image.asset(
        //           'assets/images/photo_2024-05-28_04-23-01-removebg-preview (1).png')
        //       //    cosnst Icon(
        //       //     Icons.wechat_sharp,
        //       //     color: Colors.blue,
        //       //   ),
        //       )
        // ],
        backgroundColor: kPrimaryColorred,
      ),
      body: BlocProvider(
        create: (context) => SupscriebCubit(),
        child: const SupscriebBodyPage(),
      ),
    );
  }
}

class SupscriebBodyPage extends StatelessWidget {
  const SupscriebBodyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        //color: Colors.grey,
        child: ListView(
          children: [
            const SizedBox(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مميزات الأشتراك الشهري مع الموفراتي',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    '☝️وفرنالك كل منتجات المحل بأسعار الجملة الحقيقية بدون إضافة عمولة للتطبيق عند كل التجار بأرخص سعر في السوق علشان يهمنا زيادة أرباحك ✌️وفرنالك مجمع اكبر التجار علشان توفر كل احتياجات المحل 💰كاش باك على عدد فواتير خلال الشهر 🫵 خلال 8 شهور سيتم فتح نظام الآجل بقيمة 1.14% فقط و هيكون حسابك من أوائل العملاء هيتم قبول طلبك بشرط الانتظام في دفع الاشتراك الشهري في اول كل شهر ولك حرية اختيار نظام الدفع',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'سعر الأشتراك  100 ج',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'للأشتراك يرجى ارسال 100 ج الى الرقم:',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '(01013244640)',
                    style: TextStyle(
                        fontSize: 24,
                        color: kPrimaryColorred,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: BlocConsumer<SupscriebCubit, SupscriepState>(
                listener: (context, state) {
                  if (state is SubscripSucces) {
                    showCustomSnackBar(context, state.message,
                        color: Colors.green);
                  } else if (state is SubscpriFailure) {
                    showCustomSnackBar(context, state.massage,
                        color: Colors.red);
                  }
                },
                builder: (context, state) {
                  if (state is SubscripLoading) {
                    return buildLoadingIndicator();
                  }

                  //  else if (state is SubscpriFailure) {
                  //   return Center(child: Text(state.massage));
                  // }

                  // return Container();
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<SupscriebCubit>(context).getsupscrieb();
                    },
                    style: ButtonStyle(
                        // padding: MaterialStateProperty.all<EdgeInsets>(
                        //     const EdgeInsets.all(10)),
                        fixedSize:
                            WidgetStateProperty.all<Size>(const Size(144, 44)),
                        iconSize: WidgetStateProperty.all<double>(22),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16)))),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(kPrimaryColorred)),
                    child: const Text(
                      'أشترك الآن',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
