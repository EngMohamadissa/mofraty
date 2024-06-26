import 'package:eghyptproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/styles.dart';
import '../manager/cubit/mydata_cubit_cubit.dart';
import 'widget/my_data_view_body.dart';

class MyData extends StatelessWidget {
  const MyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: kPrimaryColorred,
        title: Text(
          'بياناتي',
          style: Styles.textStyle20(context)
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) => MydataCubit()..getMarket(),
        child: const MyDataViewBody(),
      ),
    );
  }
}
