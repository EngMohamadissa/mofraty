import 'package:eghyptproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/styles.dart';
import '../../../../../../core/utils/app_router.dart';

class RowNavigatortoRigesterView extends StatelessWidget {
  const RowNavigatortoRigesterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'إنشاء حساب جديد      > ',
          style: Styles.textStyle18(context)
              .copyWith(fontWeight: FontWeight.bold)
              .copyWith(color: Colors.black),
        ),
        InkWell(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kRigesterView);
            },
            child: Text('  تسجيل',
                style: Styles.textStyle18(context).copyWith(
                    fontWeight: FontWeight.bold, color: kPrimaryColorred))),
      ],
    );
  }
}
