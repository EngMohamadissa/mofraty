// import 'package:flutter/material.dart';

// class QuantitySelectorEdit extends StatefulWidget {
//   final num initialValue;
//   final ValueChanged<num>? onChanged;
//   final num? maxSillingQuantity;

//   const QuantitySelectorEdit({
//     super.key,
//     required this.initialValue,
//     this.onChanged,
//     this.maxSillingQuantity,
//   });

//   @override
//   _QuantitySelectorEditState createState() => _QuantitySelectorEditState();
// }

// class _QuantitySelectorEditState extends State<QuantitySelectorEdit> {
//   late TextEditingController _controller;
//   late num quantity;

//   @override
//   void initState() {
//     super.initState();
//     quantity = widget.initialValue;

//     _controller = TextEditingController(text: quantity.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(2), // الحواف الداخلية للمربع
//       decoration: BoxDecoration(
//         color: Colors.blueAccent, // لون الخلفية للمربع
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5), // لون الظل
//             spreadRadius: 2, // مدى انتشار الظل
//             blurRadius: 4, // تمويه الظل
//             offset: const Offset(0, 3), // تغيير موقع الظل
//           ),
//         ],
//         borderRadius: BorderRadius.circular(12), // جعل الحواف دائرية
//       ),

//       child: SizedBox(
//         width: 130,
//         child: Row(
//           children: [
//             FloatingActionButton(
//               mini: true,
//               backgroundColor: Colors.white,
//               onPressed: widget.maxSillingQuantity != null &&
//                       quantity < widget.maxSillingQuantity!
//                   ? () {
//                       setState(() {
//                         quantity++;
//                         _controller.text = quantity.toString();
//                         if (widget.onChanged != null) {
//                           widget.onChanged!(quantity);
//                         }
//                       });
//                     }
//                   : null,
//               child: const Icon(Icons.add, color: Colors.blue),
//             ),
//             Expanded(
//               child: TextField(
//                 controller: _controller,
//                 keyboardType: TextInputType.number,
//                 textAlign: TextAlign.center,
//                 onChanged: (value) {
//                   var newQuantity = int.tryParse(value);
//                   if (newQuantity != null &&
//                       (widget.maxSillingQuantity == null ||
//                           newQuantity <= widget.maxSillingQuantity!)) {
//                     setState(() {
//                       quantity = newQuantity;
//                       _controller.text =
//                           quantity.toString(); // تحديث النص في الـ TextField
//                       if (widget.onChanged != null) widget.onChanged!(quantity);
//                     });
//                   } else {
//                     // إذا كان الإدخال غير صالح، يمكنك إعادة تعيين القيمة إلى القيمة السابقة أو إظهار رسالة خطأ
//                     _controller.text = quantity
//                         .toString(); // إعادة تعيين النص إلى القيمة السابقة
//                   }
//                 },
//                 decoration: const InputDecoration(
//                   border: InputBorder.none, // إزالة الحدود
//                   contentPadding: EdgeInsets.zero, // إزالة الحشوة الداخلية
//                 ),
//               ),
//             ),
//             FloatingActionButton(
//               mini: true,
//               backgroundColor: Colors.white,
//               onPressed: () {
//                 setState(() {
//                   if (quantity > 1) {
//                     quantity--;
//                     _controller.text = quantity.toString();
//                     if (widget.onChanged != null) widget.onChanged!(quantity);
//                   }
//                 });
//               },
//               child: const Icon(Icons.remove, color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:eghyptproject/core/utils/funcations/validat_funcation.dart';
import 'package:flutter/material.dart';

class QuantitySelectorEdit extends StatefulWidget {
  final num initialValue;
  final ValueChanged<num>? onChanged;
  final num? maxSellingQuantity;

  const QuantitySelectorEdit({
    super.key,
    required this.initialValue,
    this.onChanged,
    this.maxSellingQuantity,
  });

  @override
  QuantitySelectorEditState createState() => QuantitySelectorEditState();
}

class QuantitySelectorEditState extends State<QuantitySelectorEdit> {
  late TextEditingController _controller;
  late num quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
    _controller = TextEditingController(text: quantity.toString());
  }

  void _incrementQuantity() {
    if (widget.maxSellingQuantity == null ||
        quantity < widget.maxSellingQuantity!) {
      setState(() {
        quantity++;
        _controller.text = quantity.toString();
        if (widget.onChanged != null) {
          widget.onChanged!(quantity);
        }
      });
    }
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        _controller.text = quantity.toString();
        if (widget.onChanged != null) {
          widget.onChanged!(quantity);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth > 600 ? 8 : 2;
    double boxWidth = screenWidth > 600 ? 160 : 130;
    bool isLargeScreen = screenWidth > 600;
    return Container(
      padding: EdgeInsets.all(paddingValue),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: boxWidth,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                playSound(
                    'sounds/zapsplat_multimedia_button_click_001_68773.mp3');
                _incrementQuantity;
              },
              child: FloatingActionButton(
                heroTag: null,
                mini: !isLargeScreen,
                backgroundColor: Colors.white,
                onPressed: null,
                child: const Icon(Icons.add, color: Colors.blue),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  var newQuantity = int.tryParse(value);
                  if (newQuantity != null &&
                      newQuantity > 0 &&
                      (widget.maxSellingQuantity == null ||
                          newQuantity < widget.maxSellingQuantity!)) {
                    setState(() {
                      quantity = newQuantity;
                      _controller.text = quantity.toString();
                      if (widget.onChanged != null) widget.onChanged!(quantity);
                    });
                  } else {
                    _controller.text = quantity.toString();
                  }
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                playSound(
                    'sounds/zapsplat_multimedia_button_click_005_68777.mp3');
                _decrementQuantity;
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
