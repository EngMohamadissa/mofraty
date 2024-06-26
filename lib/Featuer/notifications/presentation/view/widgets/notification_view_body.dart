import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '../../../../../core/styles.dart';

class NotificationViewBody extends StatelessWidget {
  final RemoteMessage message;
  const NotificationViewBody({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Center(
      child: Column(
        children: [
          const Text('لا يوجد إشعارات حاليا'),
          Text(message.notification!.title.toString()),
          Text(message.notification!.body.toString()),
          Text(message.data.toString()),
        ],
      ),
    );

    // return ListView.builder(
    //   itemCount: 8,
    //   itemBuilder: (context, index) {
    //     return const NotifcationViewBodyItem();
    //   },
    // );
  }
}

class NotifcationViewBodyItem extends StatelessWidget {
  const NotifcationViewBodyItem({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String period = DateFormat('a').format(now);
    String dayPeriod = period == 'AM' ? 'ص' : 'م';
    String formattedTime = DateFormat('kk:mm').format(now);

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        color: const Color.fromARGB(136, 224, 214, 214),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'تم استلام الطلبية',
                style: Styles.textStyleDate(context),
              ),
              subtitle: Text(
                'اطلبهم من فاتورة بأسعار في معقول باقوى كاش باك',
                style: Styles.textStyleDate(context).copyWith(fontSize: 20),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$formattedDate – $formattedTime $dayPeriod',
                  style: Styles.textStyleDate(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
