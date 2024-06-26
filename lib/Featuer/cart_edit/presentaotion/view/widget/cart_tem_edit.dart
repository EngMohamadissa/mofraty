// import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/bill.dart';
// import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/pivot.dart';
// import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/product.dart';
// import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/supplier.dart';
// import 'package:eghyptproject/Featuer/cart_edit/presentaotion/view/widget/quantity_selector_edit.dart';
// import 'package:flutter/material.dart';

// class CartItemEdit extends StatelessWidget {
//   final VoidCallback onDelete;
//   final Function(num)? onQuantityChanged;
//   final ProductBill bill;
//   final Supplier? supplier;
//   final ProductBill? pivot;
//   final num? quantity;

//   const CartItemEdit({
//     Key? key,
//     required this.onDelete,
//     this.onQuantityChanged,
//     required this.bill,
//     required this.supplier,
//     required this.pivot,
//     required this.quantity,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     var imageSize = screenSize.width * 0.3; // Example: 30% of the screen width

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         child: Row(
//           children: [
//             // Image.asset(
//             //   cartItem.image,
//             //   height: imageSize, // Use dynamic size
//             //   width: imageSize, // Use dynamic size
//             // ),
//             Expanded(
//               child: ListTile(
//                 title: Text(
//                   '${bill.discription}',
//                   style: TextStyle(
//                     fontSize: screenSize.width * 0.04,
//                   ), // Example: 4% of the screen width
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Text('Price: ${cartItem.price}'),
//                     const SizedBox(height: 5),
//                     Text(
//                       ' ${pivot!.pivot!.offerPrice} ج',
//                       style: TextStyle(
//                         fontSize: screenSize.width * 0.035,
//                       ), // Smaller font size for discount text
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       '${pivot!.pivot!.price}  ج',
//                       style: TextStyle(
//                         fontSize: screenSize.width * 0.04,
//                       ), // Consistent font size for price
//                     ),
//                     const SizedBox(height: 10),
//                     QuantitySelectorEdit(
//                         initialValue: quantity ?? 1,
//                         onChanged: (newQuantity) {
//                           if (onQuantityChanged != null) {
//                             onQuantityChanged!(newQuantity);
//                           }
//                         },
//                         maxSillingQuantity: supplier!.minSellingQuantity),
//                   ],
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, color: Colors.red),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/product.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/supplier.dart';
import 'package:eghyptproject/Featuer/cart_edit/presentaotion/view/widget/quantity_selector_edit.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:flutter/material.dart';

class CartItemEdit extends StatelessWidget {
  final VoidCallback onDelete;
  final Function(num)? onQuantityChanged;
  final ProductBill bill;
  final Supplier? supplier;
  final ProductBill? pivot;
  final num? quantity;
  final String image;
  const CartItemEdit({
    super.key,
    required this.onDelete,
    this.onQuantityChanged,
    required this.bill,
    required this.supplier,
    required this.pivot,
    required this.quantity,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;

    // You can define your breakpoints and adjust sizes accordingly
    double imageWidth = screenWidth > 600 ? 120 : 100;
    double imageHeight = screenWidth > 600 ? 180 : 150;
    double paddingAllSides = screenWidth > 600 ? 16 : 8;
    double spaceBetweenItems = screenWidth > 600 ? 12 : 8;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Image.network(
                image,
                height: imageHeight,
                width: imageWidth,
              ),
              Expanded(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${bill.name}', style: Styles.textStyle20(context)),
                      Text(
                        '${bill.discription}',
                        style: Styles.textStyle20(context),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: spaceBetweenItems),
                      if (pivot!.pivot!.offerPrice! > 0) ...[
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "ج${pivot!.pivot!.price}",
                                style: Styles.textStyle18(context),
                              ),
                            ),
                            SizedBox(width: spaceBetweenItems),
                            Flexible(
                              child: Text(
                                "ج${pivot!.pivot!.offerPrice}",
                                style: Styles.textStyle18(context)
                                    .copyWith(color: Colors.green),
                              ),
                            ),
                            SizedBox(width: spaceBetweenItems),
                            Text(
                              "عرض خاص",
                              style: Styles.textStyle18(context).copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ] else ...[
                        Text(
                          "ج${pivot!.pivot!.price}",
                          style: Styles.textStyle18(context),
                        ),
                      ],
                      SizedBox(height: spaceBetweenItems),
                      QuantitySelectorEdit(
                        initialValue: quantity ?? 1,
                        onChanged: (newQuantity) {
                          if (onQuantityChanged != null) {
                            onQuantityChanged!(newQuantity);
                          }
                        },
                        maxSellingQuantity: supplier!.minSellingQuantity,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
