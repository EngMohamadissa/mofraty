import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';

import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_cubit.dart';
import 'package:eghyptproject/Featuer/cart/presentation/manger/new_bill_cubit.dart';
import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';
import 'package:eghyptproject/Featuer/noftifications_local/presentation/manager/notificationlocal_cubit.dart';
import 'package:eghyptproject/api/firebase_api.dart';
import 'package:eghyptproject/api/gitit_storage.dart';
import 'package:eghyptproject/core/api/dio_consumer.dart';
import 'package:eghyptproject/core/cache/cache_helper.dart';
import 'package:eghyptproject/firebase_options.dart';
import 'package:eghyptproject/simple_bloc_observer_copy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/app_router.dart';
// ignore: depend_on_referenced_packages

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initial();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseApi().initNotification();

  /////u1

  // await FirebaseApi().initNotiification();

  Bloc.observer = SimpleBlocObserver();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  CacheHelper().init();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('ar', 'AE')],
      fallbackLocale: const Locale('ar', 'AE'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubitCubit>(
          create: (context) => UserCubitCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(
            create: (context) =>
                NotificationCubit(Dio())..fetchNotifications()),
        BlocProvider(create: (context) => BillCubit()),
        BlocProvider(create: (context) => BillCubitGet(dio: Dio())),
        BlocProvider(create: (context) => OffersCubit(dio: Dio())..getOffers()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
