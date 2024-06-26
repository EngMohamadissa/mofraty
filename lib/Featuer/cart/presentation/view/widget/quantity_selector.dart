import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/utils/funcations/validat_funcation.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;
  final num? maxSillingQuantity;
  final num maxOfferQuantity;

  const QuantitySelector({
    super.key,
    required this.initialValue,
    this.onChanged,
    this.maxSillingQuantity,
    required this.maxOfferQuantity,
  });

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  late TextEditingController _controller;
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
    _controller = TextEditingController(text: quantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    bool alertShown = false;
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth > 600 ? 8 : 2;
    double boxWidth = screenWidth > 600 ? 160 : 130;
    bool isLargeScreen = screenWidth > 600;
    return Container(
      padding: EdgeInsets.all(paddingValue), // الحواف الداخلية للمربع
      decoration: BoxDecoration(
        color: Colors.blueAccent, // لون الخلفية للمربع
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // لون الظل
            spreadRadius: 2, // مدى انتشار الظل
            blurRadius: 4, // تمويه الظل
            offset: const Offset(0, 3), // تغيير موقع الظل
          ),
        ],
        borderRadius: BorderRadius.circular(12), // جعل الحواف دائرية
      ),
      child: SizedBox(
        width: boxWidth, //
        child: Row(
          children: [
            GestureDetector(
              onTap: widget.maxSillingQuantity != null &&
                      quantity < widget.maxSillingQuantity!
                  ? () {
                      playSound(
                          'sounds/zapsplat_multimedia_button_click_001_68773.mp3');
                      setState(() {
                        quantity++;
                        _controller.text = quantity.toString();
                        if (widget.onChanged != null) {
                          widget.onChanged!(quantity);
                        }
                      });

                      if (quantity == widget.maxOfferQuantity) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showCustomAlertDialog(
                            context: context,
                            title: 'ملاحظة',
                            content:
                                'لقد استكملت الحد الأقصى للاستفادة من العرض. باقي الكمية ستشتريها بسعر المنتج الأصلي',
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: Text(
                                    'موافق',
                                    style: Styles.textStyle18(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          );
                        });
                      }
                    }
                  : null,
              child: FloatingActionButton(
                heroTag: null,
                mini: !isLargeScreen,
                backgroundColor: Colors.white,
                onPressed: null,
                child: const Icon(Icons.add, color: Colors.green),
              ),
            ),
            Expanded(
              child: TextField(
                style:
                    Styles.textStyle20(context).copyWith(color: Colors.white),
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  var newQuantity = int.tryParse(value);
                  if (newQuantity != null &&
                      (widget.maxSillingQuantity == null ||
                          newQuantity <= widget.maxSillingQuantity!)) {
                    setState(() {
                      quantity = newQuantity;
                      _controller.text =
                          quantity.toString(); // تحديث النص في الـ TextField
                      if (widget.onChanged != null) widget.onChanged!(quantity);
                    });
                  } else {
                    // إذا كان الإدخال غير صالح، يمكنك إعادة تعيين القيمة إلى القيمة السابقة أو إظهار رسالة خطأ
                    _controller.text = quantity
                        .toString(); // إعادة تعيين النص إلى القيمة السابقة
                  }
                },
                decoration: const InputDecoration(
                  border: InputBorder.none, // إزالة الحدود
                  contentPadding: EdgeInsets.zero, // إزالة الحشوة الداخلية
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                playSound(
                    'sounds/zapsplat_multimedia_button_click_005_68777.mp3');
                print(widget.maxOfferQuantity);
                print(widget.maxSillingQuantity);

                setState(() {
                  if (quantity > 1) {
                    quantity--;
                    _controller.text = quantity.toString();
                    if (widget.onChanged != null) widget.onChanged!(quantity);
                  }
                });
              },
              child: FloatingActionButton(
                heroTag: null,
                mini: !isLargeScreen,
                backgroundColor: Colors.white,
                onPressed: null,
                child: const Icon(Icons.remove, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
