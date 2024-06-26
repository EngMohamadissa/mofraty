// import 'package:eghyptproject/Featuer/notifications/presentation/view/notifications_view.dart';
// import 'package:eghyptproject/api/gitit_storage.dart';
// import 'package:eghyptproject/core/utils/app_router.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class FirebaseApi {
//   final notificationSettings =
//       FirebaseMessaging.instance.requestPermission(provisional: true);
//   Future<void> initNotiification() async {
//     FirebaseMessaging.instance.requestPermission();
//     try {
//       final apnsToken = await FirebaseMessaging.instance.getToken();
//       storage
//           .get<SharedPreferences>()
//           .setString('deviceToken', apnsToken.toString());
//       if (apnsToken != null) {
//         print('token+$apnsToken');
//         initPushNotification();
//       }
//     } catch (e) {
//       storage.get<SharedPreferences>().setString('deviceToken', 'masa');
//       print(storage.get<SharedPreferences>().getString('deviceToken'));
//       print("Error getting token: $e");
//     }
//   }

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) {
//       return;
//     } else {
//       AppRouter.router.go(
//         AppRouter.kNotificationView,
//         extra: message,
//       );
//       // NavigatorKey.currentState?.pushNamed(AppRouter.KNotification);
//     }
//   }

//   Future initPushNotification() async {
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }
// void _getToken() async {
//   try {
//     String? token = await FirebaseMessaging.instance.getToken();
//     setState(() {
//       _token = token;
//     });
//     print("Firebase Messaging Token: $_token");
//   } catch (e) {
//     print("Error getting token: $e");
//   }
// }
// // }

import 'package:eghyptproject/core/utils/app_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firbaseMassagin = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firbaseMassagin.requestPermission();

    final fCMToken = await _firbaseMassagin.getToken();

    print('Token:$fCMToken');

    intitPushNotification();
  }

  void handleMaassage(RemoteMessage? message) {
    if (message == null) return;

    AppRouter.router.go(AppRouter.kNotificationViewLocal);
  }

  Future intitPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMaassage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMaassage);
  }
}
