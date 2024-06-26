import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/regiseter/presentaiton/manager/cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/rigester_view_body.dart';

class RigesterView extends StatelessWidget {
  const RigesterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit(Dio())..fetchMarketCategories(),
      child: const Scaffold(
        body: RigesterViewBody(),
      ),
    );
  }
}
