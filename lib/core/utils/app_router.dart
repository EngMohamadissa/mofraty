import 'package:eghyptproject/Featuer/Auth/forgetpassword/presentation/view/widget/veirfycode_view_body.dart';
import 'package:eghyptproject/Featuer/Auth/login/presentation/view/login_view.dart';
import 'package:eghyptproject/Featuer/noftifications_local/presentation/view/notificationlocale_page.dart';
import 'package:eghyptproject/Featuer/subscrip/presentation/view/supscrieb_view.dart';
import 'package:eghyptproject/Featuer/target/presentation/view/target_view.dart';
import 'package:eghyptproject/animation_page_view.dart';

import 'package:go_router/go_router.dart';

import '../../Featuer/Auth/forgetpassword/presentation/view/forgetpassowrd_view.dart';
import '../../Featuer/Auth/forgetpassword/presentation/view/resetpassword._view.dart';
import '../../Featuer/Auth/regiseter/presentaiton/view/rigester_view.dart';
import '../../Featuer/bill_view/presentation/view/bill_view.dart';
import '../../Featuer/home/presentation/view/home_view.dart';
import '../../Featuer/my_data/presentation/view/my_data_view.dart';

abstract class AppRouter {
  static const ksplashView = '/';
  static const kloginView = '/loginView';

  static const kRigesterView = '/rigesterView';
  static const kForgetView = '/forgetpassowrdView';
  static const kResetpasswordView = '/resetpasswordView';
  static const kVeirfycodeView = '/veirfycodeView';
  static const kHomeView = '/homeView';
  static const kMyDataView = '/mydataView';
  static const kBillsView = '/billsView';
  static const kOrderView = '/orderView';
  static const kProductView = '/productView';
  // static const kNotificationView = '/notificationView';
  static const kNotificationViewLocal = '/notificationlocalView';
  static const kSubscriebView = '/subscriebView';

  // static const khomepagemasaView = '/homepagemasaView';//
  static const ktargetview = '/targetView';
  static const kcompaniesview = '/companiesView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SpashView(),
      ),

      GoRoute(
        path: kloginView,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kRigesterView,
        builder: (context, state) => const RigesterView(),
      ),
      GoRoute(
        path: kForgetView,
        builder: (context, state) => const ForgetpassowrdView(),
      ),
      GoRoute(
        path: kResetpasswordView,
        builder: (context, state) => const ResetpasswordView(),
      ),
      GoRoute(
        path: kVeirfycodeView,
        builder: (context, state) => const VeirfyCodeView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kNotificationViewLocal,
        builder: (context, state) => const NotificationlocalPage(),
      ),
      GoRoute(
        path: kMyDataView,
        builder: (context, state) => const MyData(),
      ),
      GoRoute(
        path: kBillsView,
        builder: (context, state) => const BillsView(
          initialTabIndex: 0,
        ),
      ),
      GoRoute(
        path: ktargetview,
        builder: (context, state) => const TrargetView(),
      ),
      // GoRoute(
      //   path: kcompaniesview,
      //   builder: (context, state) => const CompaniesPage(),
      // ),

      // GoRoute(
      //   path: kProductView,
      //   builder: (context, state) => const CategoriesPageFS(),
      // ),
      // GoRoute(
      //   path: kNotificationView,
      //   builder: (context, state) {
      //     final message = state.extra as RemoteMessage?;
      //     return NotificationsView(
      //       message: message,
      //     );
      //   },
      // ),

      // GoRoute(
      //   path: khomepagemasaView,
      //   builder: (context, state) => const HomePagemasa(type: '',),
      // ),

      GoRoute(
        path: kSubscriebView,
        builder: (context, state) => const SupscriebPage(),
      ),
    ],
  );
}
