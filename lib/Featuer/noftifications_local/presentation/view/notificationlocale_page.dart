// lib/pages/notification_page.dart
import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/view/bill_view.dart';
import 'package:eghyptproject/Featuer/noftifications_local/presentation/manager/notificationlocal_cubit.dart';
import 'package:eghyptproject/Featuer/noftifications_local/presentation/manager/notificationlocal_state.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/product_list.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NotificationlocalPage extends StatelessWidget {
  const NotificationlocalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorwhit,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColorred,
        centerTitle: true,
        title: const Text(
          'الاشعارات',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: const NotificationView(),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is readNotificationLoaded) {
          showCustomSnackBar(context, state.message, color: Colors.green);
        } else if (state is readNotificationError) {
          showCustomSnackBar(context, state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        if (state is NotificationLoading) {
          return buildLoadingIndicator();
        } else if (state is NotificationLoaded &&
            state.notifications.isNotEmpty) {
          final notifications = state.notifications;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  color: const Color.fromARGB(136, 224, 214, 214),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            BlocProvider.of<NotificationCubit>(context)
                                .readNotifications(notification.id);
                            if (notification.type ==
                                'preparingjj-bill-market') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BillsView(initialTabIndex: 0)),
                              );
                            } else if (notification.type == 'regection-bill' ||
                                notification.type == 'receive-bill') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BillsView(initialTabIndex: 1)),
                              );
                            } else if (notification.type == 'discount') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoriesPageFS(
                                          id: notification.supplier.id,
                                          type:
                                              "${notification.supplier.categoryName}",
                                          supplier: notification.supplier,
                                        )),
                              );
                            }
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                notification.message,
                                style: Styles.textStyleDate(context),
                              ),

                              leading: const Icon(Icons
                                  .notifications_on_outlined), // أيقونة جانبية مثالية
                            ),
                          )
                          //  ListTile(
                          //   title: Text(
                          //     notification.message,
                          //     style: Styles.textStyleDate(context),
                          //   ),
                          //   // subtitle: Text(
                          //   //   'اطلبهم من فاتورة بأسعار في معقول باقوى كاش باك',
                          //   //   style: Styles.textStyleDate(context)
                          //   //       .copyWith(fontSize: 20),
                          //   // ),
                          // ),
                          ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            notification.createdAt,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 48, 46, 46),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       notification.createdAt,
                      //       style: Styles.textStyleDate(context),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
              // ListTile(
              //   title: Text(notification.message),
              // );
            },
          );
        } else if (state is NotificationError) {
          return builError(state.message);
        } else {
          return Center(
              child: SvgPicture.asset('assets/images/No data-pana (2).svg')
              //Image.asset('assets/images/Empty-removebg-preview.png')
              );
        }
      },
    );
  }
}
