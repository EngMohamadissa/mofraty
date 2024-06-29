// import 'package:eghyptproject/Featuer/cart/presentation/view/widget/quantity_selector.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
// import 'package:flutter/material.dart';

// class CartItem extends StatelessWidget {
//   final Product cartItem;
//   final VoidCallback onDelete;
//   final Function(int)? onQuantityChanged;

//   const CartItem({
//     Key? key,
//     required this.cartItem,
//     required this.onDelete,
//     this.onQuantityChanged,
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
//                   '${cartItem.name}',
//                   style: TextStyle(
//                       fontSize: screenSize.width *
//                           0.04), // Example: 4% of the screen width
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Text('Price: ${cartItem.price}'),
//                     const SizedBox(height: 5),
//                     Text(
//                       '${cartItem.offerPrice} ج',
//                       style: TextStyle(
//                           fontSize: screenSize.width *
//                               0.035), // Smaller font size for discount text
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       '${cartItem.price} ج',
//                       style: TextStyle(
//                           fontSize: screenSize.width *
//                               0.04), // Consistent font size for price
//                     ),
//                     const SizedBox(height: 10),
//                     QuantitySelector(
//                       initialValue: cartItem.quantity,
//                       onChanged: (newQuantity) {
//                         if (onQuantityChanged != null) {
//                           onQuantityChanged!(newQuantity);
//                         }
//                       },
//                       maxSillingQuantity: cartItem.maxSellingQuantity,
//                     ),
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

import 'package:eghyptproject/Featuer/cart/presentation/view/widget/quantity_selector.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final Product cartItem;
  final VoidCallback onDelete;
  final Function(int)? onQuantityChanged;

  const CartItem({
    super.key,
    required this.cartItem,
    required this.onDelete,
    this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // You can define your breakpoints and adjust sizes accordingly
    double imageWidth = screenWidth > 600 ? 120 : 100;
    double imageHeight = screenWidth > 600 ? 180 : 150;
    double paddingAllSides = screenWidth > 600 ? 16 : 8;
    double spaceBetweenItems = screenWidth > 600 ? 12 : 8;
    var image = widget.cartItem.images!.first!;
    return Card(
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Container(
                color: Colors.white,
                height: imageHeight,
                width: imageWidth,
                child: Image.network(
                  image,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported_outlined),
                  // fit: BoxFit.cover,
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(paddingAllSides),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.cartItem.name}',
                      style: Styles.textStyle24(context),
                      // overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spaceBetweenItems),
                    Text(
                      widget.cartItem.discription,
                      style: Styles.textStyle20(context),
                      // overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spaceBetweenItems),
                    if (widget.cartItem.offerPrice > 0) ...[
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "${widget.cartItem.price}ج",
                              style: Styles.textStyle18(context),
                            ),
                          ),
                          SizedBox(width: spaceBetweenItems),
                          Flexible(
                            child: Text(
                              "ج${widget.cartItem.offerPrice}",
                              style: Styles.textStyle18(context)
                                  .copyWith(color: Colors.green),
                            ),
                          ),
                          SizedBox(width: spaceBetweenItems),
                          Text(
                            "عرض خاص",
                            style: Styles.textStyle18(context).copyWith(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        "${widget.cartItem.price}ج",
                        style: Styles.textStyle18(context),
                      ),
                    ],
                    SizedBox(height: spaceBetweenItems),
                    QuantitySelector(
                      initialValue: widget.cartItem.quantity,
                      onChanged: (newQuantity) {
                        if (widget.onQuantityChanged != null) {
                          widget.onQuantityChanged!(newQuantity);
                        }
                      },
                      maxSillingQuantity: widget.cartItem.maxSellingQuantity,
                      maxOfferQuantity: widget.cartItem.maxOfferQuantity,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
