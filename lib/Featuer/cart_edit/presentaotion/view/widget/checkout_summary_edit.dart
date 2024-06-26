import 'package:eghyptproject/core/styles.dart';
import 'package:flutter/material.dart';

class CheckoutSummaryEdit extends StatelessWidget {
  final num? total; // المجموع الكلي
  final String chosenPaymentMethod; // طريقة الدفع المختارة
  final Function(String?)
      onPaymentMethodChanged; // الدالة التي ستُستدعى عند تغيير طريقة الدفع
  final VoidCallback
      onCouponTap; // الدالة التي ستُستدعى عند النقر على كوبون الخصم
  final VoidCallback onOrderNow; // الدالة التي ستُستدعى عند النقر على زر الطلب

  const CheckoutSummaryEdit({
    Key? key,
    required this.total,
    required this.chosenPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.onCouponTap,
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
              style: Styles.textStyle20(
                  context), // تأكد من تعريف Styles.textStyle20
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'طريقة الدفع:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: chosenPaymentMethod,
              onChanged: onPaymentMethodChanged,
              items: <String>[' ..', ' الدفع آجل', 'كاش']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingValue),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // لون النص للزر
              minimumSize: Size(double.infinity, buttonHeight),
              elevation: 10, // ارتفاع الظل
              shape: const RoundedRectangleBorder(
                  // تغيير شكل الزر
                  ), // عرض الزر يأخذ الحجم الكامل للشاشة وارتفاع 60
            ),
            onPressed: onOrderNow,
            child: const Text(
              'اطلب الآن',
              style: TextStyle(fontSize: 20), // يمكنك تخصيص النص كما تريد
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
