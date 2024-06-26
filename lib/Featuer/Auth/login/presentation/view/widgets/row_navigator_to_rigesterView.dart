// ignore_for_file: file_names

import 'package:eghyptproject/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/styles.dart';

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
          'Create a new account  > ',
          style:
              Styles.textStyle14(context).copyWith(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kRigesterView);
            },
            child: Text('Rigester',
                style: Styles.textStyle14(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 42, 42, 42)))),
      ],
    );
  }
}
