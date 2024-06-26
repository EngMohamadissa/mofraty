import 'package:flutter/material.dart';
import '../../../../../core/styles.dart';
import 'container_cash_back_Item.dart';
import 'list_tile_cash_back_item.dart';

class CashBackViewBody extends StatelessWidget {
  const CashBackViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          SizedBox(
            height: isTablet ? 240 : 160,
          ),
          Text(
            'الكاش باك',
            style: isTablet
                ? Styles.textStyle28(context)
                : Styles.textStyle24(context),
          ),
          const ContainerCashBackItem(),
          Text(
            'أزاي تستفيد من الكاش باك ؟',
            style: Styles.textStyle14(context).copyWith(
              color: const Color.fromARGB(255, 107, 100, 100),
              fontWeight: FontWeight.bold,
            ),
          ),
          const ListTileCashBackItem(),
          Text(
            'أكواد الخصم',
            style: isTablet
                ? Styles.textStyle20(context)
                : Styles.textStyle18(context),
          ),
          Text(
            'لا توجد اكواد خصم',
            style: Styles.textStyle14(context)
                .copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
