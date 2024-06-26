// import 'package:eghyptproject/Featuer/cart/presentation/view/widget/quantity_selector.dart';
// import 'package:flutter/material.dart';

// class AddToCart extends StatefulWidget {
//   const AddToCart({super.key});

//   @override
//   _AddToCartState createState() => _AddToCartState();
// }

// class _AddToCartState extends State<AddToCart> {
//   bool isQuantitySelected = false;

//   void toggleSelector() {
//     setState(() {
//       isQuantitySelected = !isQuantitySelected;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         maxWidth: MediaQuery.of(context).size.width, // تقييد العرض بعرض الشاشة
//         maxHeight: MediaQuery.of(context).size.height /
//             2, // تقييد الارتفاع بنصف ارتفاع الشاشة
//       ),
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         transitionBuilder: (Widget child, Animation<double> animation) {
//           return ScaleTransition(scale: animation, child: child);
//         },
//         child: isQuantitySelected
//             ? QuantitySelector(
//                 key: UniqueKey(),
//                 initialValue: 1,
//                 onChanged: (int newQuantity) {
//                   // Handle the quantity change
//                 },
//               )
//             : ElevatedButton(
//                 key: UniqueKey(),
//                 onPressed: toggleSelector,
//                 child: const Text('أضف إلى السلة'),
//               ),
//       ),
//     );
//   }
// }
