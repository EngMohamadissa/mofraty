// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../../core/styles.dart';

class ContainerCashBackItem extends StatelessWidget {
  const ContainerCashBackItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 14), // تعديل القيمة حسب الحاجة
            child: Text(
              'رصيد الكاش باك',
              style: Styles.textStyle14(context),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 14), // تعديل القيمة حسب الحاجة
            child: Text(
              '0 ج ',
              style: Styles.textStyle14(context).copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 14), // تعديل القيمة حسب الحاجة
            child: Text(
              'رصيد الشهر السابق:0',
              style: Styles.textStyle14(context),
            ),
          ),
        ],
      ),
    );
  }
}
