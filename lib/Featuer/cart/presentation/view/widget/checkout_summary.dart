import 'package:eghyptproject/Featuer/cart/presentation/manger/new_bill_cubit.dart';
import 'package:eghyptproject/Featuer/cart/presentation/manger/new_bill_state.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/styles.dart';

class CheckoutSummary extends StatelessWidget {
  final double total; // المجموع الكلي
  final String chosenPaymentMethod; // طريقة الدفع المختارة
  final Function(String?)
      onPaymentMethodChanged; // الدالة التي ستُستدعى عند تغيير طريقة الدفع
  final VoidCallback onOrderNow;

  const CheckoutSummary({
    Key? key,
    required this.total,
    required this.chosenPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.onOrderNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double buttonHeight = screenWidth > 600 ? 40 : 30;
    double paddingValue = screenWidth > 600 ? 16.0 : 8.0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الإجمالي',
              style: Styles.textStyle24(
                  context), // تأكد من تعريف Styles.textStyle24
            ),
            Text(
              '$totalج',
              style: Styles.textStyle24(context),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'طريقة الدفع:',
            ),
            DropdownButton<String>(
              value: chosenPaymentMethod,
              onChanged: onPaymentMethodChanged,
              items: <String>[' ..', ' الدفع آجل', 'كاش']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Styles.textStyle20(context),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocConsumer<BillCubit, BillState>(
          builder: (context, state) {
            if (state is BillLoading) {
              return buildLoadingIndicator();
            }
            return ElevatedButton(
              onPressed: onOrderNow,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.green),
                elevation: MaterialStateProperty.all(0), // إزالة الظل
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: paddingValue, vertical: 10),
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 25),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, buttonHeight),
                ),
                maximumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 56),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(6), // إزالة الحواف المدورة
                  ),
                ),
              ),
              child: const Text('اطلب الآن'),
            );
          },
          listener: (BuildContext context, BillState state) {
            if (state is BillFailure) {
              showCustomAlertDialog(
                context: context,
                title: 'تحذير',
                content: state.errorMessage,
              );
              showCustomSnackBar(context, state.errorMessage,
                  color: Colors.red);
            } else if (state is BillSuccess) {
              showCustomSnackBar(context, state.message, color: Colors.green);
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
// showCustomAlertDialog(
//   context: context,
//   title: 'تحذير',
//   content: 'هذا هو المحتوى التحذيري.',
//   actions: [
//     ElevatedButton(
//       child: Text('الزر الأول'),
//       onPressed: () {
//         // تصرفات الزر الأول
//       },
//     ),
//     ElevatedButton(
//       child: Text('الزر الثاني'),
//       onPressed: () {
//         // تصرفات الزر الثاني
//       },
//     ),
//     // يمكن إضافة المزيد من الأزرار هنا
//   ],
// );
