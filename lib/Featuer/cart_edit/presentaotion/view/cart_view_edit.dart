// import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/bill.dart';
// import 'package:eghyptproject/Featuer/cart_edit/presentaotion/view/widget/cartI_tem_edit.dart';
// import 'package:eghyptproject/Featuer/cart_edit/presentaotion/view/widget/checkout_summary_edit.dart';
// import 'package:flutter/material.dart';

// class CartEditView extends StatefulWidget {
//   final Bill bill;

//   const CartEditView({super.key, required this.bill});

//   @override
//   State<CartEditView> createState() => _CartEditViewState();
// }

// class _CartEditViewState extends State<CartEditView> {
//   String _chosenPaymentMethod = 'كاش';

//   void _deleteItem(int index) {
//     setState(() {
//       double deletedItemPrice =
//           widget.bill.products![index].pivot!.price?.toDouble() ?? 0.0;
//       widget.bill.products!.removeAt(index);

//       // Recalculate the total price
//       double newTotalPrice = 0.0;
//       for (var product in widget.bill.products!) {
//         newTotalPrice += product.pivot?.price?.toDouble() ?? 0.0;
//       }
//       widget.bill.totalPrice = newTotalPrice;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var refBill = widget.bill;
//     var reFSubblier = widget.bill.supplier;
//     var screenSize = MediaQuery.of(context).size;
//     var screenWidth = screenSize.width;
//     var padding = screenWidth * 0.02;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.red,
//         title: const Text('سلة الطلبات'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete_outline),
//             onPressed: () {
//               setState(() {
//                 widget.bill.products!.clear();
//                 widget.bill.totalPrice = 0;
//               });
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(padding),
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 refBill.supplier!.firstName!,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//               Text(
//                 'الإجمالي: ${refBill.totalPrice} ج.م',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'العدد: ${refBill.products!.length}',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//           ListView.builder(
//             // key: PageStorageKey<int>(index),
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             padding: EdgeInsets.zero,
//             itemCount: refBill.products!.length,
//             itemBuilder: (context, productIndex) {
//               var refProduct = refBill.products![productIndex];
//               var refPivot = widget.bill.supplier?.products![productIndex];
//               var refQauntity = refProduct.pivot!.quantity;
//               return CartItemEdit(
//                 onDelete: () => _deleteItem(productIndex),
//                 onQuantityChanged: (newQuantity) {},
//                 bill: refProduct,
//                 supplier: reFSubblier,
//                 pivot: refPivot,
//                 quantity: refQauntity,
//               );
//             },
//           ),
//           const Spacer(),
//           CheckoutSummaryEdit(
//             total: refBill.totalPrice,
//             chosenPaymentMethod: _chosenPaymentMethod,
//             onPaymentMethodChanged: (newValue) {
//               setState(() {
//                 _chosenPaymentMethod = newValue!;
//               });
//             },
//             onCouponTap: () {},
//             onOrderNow: () {},
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_cubit.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_state.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/bill.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/modelbill/product.dart';
import 'package:eghyptproject/Featuer/cart_edit/presentaotion/view/widget/cart_tem_edit.dart';
import 'package:eghyptproject/Featuer/cart_edit/presentaotion/view/widget/checkout_summary_edit.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/utils/funcations/validat_funcation.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartEditView extends StatefulWidget {
  final Bill bill;

  const CartEditView({
    super.key,
    required this.bill,
  });

  @override
  State<CartEditView> createState() => _CartEditViewState();
}

class _CartEditViewState extends State<CartEditView> {
  final BillCubitGet _cartCubit = BillCubitGet(dio: Dio());
  String _chosenPaymentMethod = 'كاش';
  TextEditingController note = TextEditingController();

  void _deleteItem(int index) {
    setState(() {
      widget.bill.products!.removeAt(index);
      _recalculateTotalPrice();
    });
  }

  void _confirmOrder() {
    final num supplierId =
        widget.bill.supplier?.id ?? 0; // Assuming supplier ID is available

    final List<Map<String, dynamic>> products = widget.bill.products!
        .map((product) => {
              "id": product.id,
              "quantity": product.pivot!.quantity,
            })
        .toList();

    final Map<String, dynamic> data = {
      "supplier_id": supplierId,
      "payement_method_id": 1,
      "market_note": note,
      "products": products,
    };
    _cartCubit.updateInvoice(data, widget.bill.id);

    // Convert to JSON string and print the data
    // final String jsonData = jsonEncode(data);
    // print(jsonData);
  }

  void _recalculateTotalPrice() {
    num newTotalPrice = 0;

    if (widget.bill.products != null &&
        widget.bill.supplier!.products != null) {
      for (var product in widget.bill.products!) {
        var pivot = product.pivot;
        if (pivot != null) {
          var supplierProduct = widget.bill.products!.firstWhere(
            (supplierProduct) => supplierProduct.id == pivot.productId,
            orElse: () => ProductBill(), // Default values if not found
          );

          num? price = supplierProduct.pivot!.hasOffer! &&
                  pivot.quantity! <= supplierProduct.pivot!.maxOfferQuantity!
              ? supplierProduct.pivot!.offerPrice
              : supplierProduct.pivot!.price;
          newTotalPrice += price! * pivot.quantity!;
        }
      }
    }

    setState(() {
      widget.bill.totalPrice = newTotalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var refBill = widget.bill;
    // var reFSubblier = widget.bill.supplier;
    // var screenSize = MediaQuery.of(context).size;
    // var screenWidth = screenSize.width;
    // var padding = screenWidth * 0.02;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text('سلة الطلبات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              // استدعاء الدالة لإظهار التحذير
              showCustomAlertDialog(
                context: context,
                title: 'تحذير',
                content:
                    'هل أنت متأكد من أنك تريد إزالة جميع المنتجات من الفاتورة؟',

                actions: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      'إلغاء',
                      style: Styles.textStyle18(context)
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        'حذف',
                        style: Styles.textStyle18(context)
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        // إجراء مسح المنتجات وتحديث السعر الكلي
                        setState(() {
                          playSound(
                              'sounds/zapsplat_household_wire_brush_scrub_clean_dry_concrete_single_003_107476.mp3');
                          widget.bill.products!.clear();
                          widget.bill.totalPrice = 0;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // يمكن إضافة المزيد من الأزرار هنا
                ],
                // buttonText: 'إزالة',
                // onButtonPressed: () {
                //   // إجراء مسح المنتجات وتحديث السعر الكلي
                //   setState(() {
                //     widget.bill.products!.clear();
                //     widget.bill.totalPrice = 0;
                //   });
                //   Navigator.of(context).pop(); // إغلاق الحوار بعد الإجراء
                // },
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => _cartCubit,
        child: BlocConsumer<BillCubitGet, BillStateGet>(
          listener: (context, state) {
            if (state is InvoiceError) {
              showCustomSnackBar(context, state.error, color: Colors.red);
            }
            if (state is InvoiceSuccess) {
              playSound('sounds/Cash Purchase Sound Effects(MP3_128K).mp3');
              showCustomSnackBar(context, state.message, color: Colors.green);
              setState(() {
                widget.bill.products!.clear();
                widget.bill.totalPrice = 0;
              });
            }
          },
          builder: (context, state) {
            if (state is InvoiceLoading) {
              return buildLoadingIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        if (widget.bill.products!.isEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.bill.supplier!.firstName ?? '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                'الإجمالي: ${widget.bill.totalPrice}ج.م',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'العدد: ${widget.bill.products!.length}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.bill.products!.length,
                          itemBuilder: (context, productIndex) {
                            var refProduct =
                                widget.bill.products![productIndex];
                            var refPivot = widget.bill.products![productIndex];
                            var refQuantity = refProduct.pivot!.quantity;
                            var image = refProduct.image!.first;
                            return CartItemEdit(
                              onDelete: () {
                                // استدعاء الدالة لإظهار التحذير
                                showCustomAlertDialog(
                                  context: context,
                                  title: 'تحذير',
                                  content:
                                      'هل أنت متأكد من أنك تريد حذف هذا المنتج؟',
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      child: Text(
                                        'إلغاء',
                                        style: Styles.textStyle18(context)
                                            .copyWith(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        child: Text(
                                          'حذف',
                                          style: Styles.textStyle18(context)
                                              .copyWith(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          playSound(
                                              'sounds/zapsplat_household_wire_brush_scrub_clean_dry_concrete_single_003_107476.mp3');
                                          _deleteItem(productIndex);

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    // يمكن إضافة المزيد من الأزرار هنا
                                  ],
                                  // buttonText: 'حذف',
                                  // onButtonPressed: () {
                                  //   // إجراء حذف المنتج وتحديث البيانات
                                  //   _deleteItem(productIndex);
                                  //   Navigator.of(context)
                                  //       .pop(); // إغلاق الحوار بعد الحذف
                                  // },
                                );
                              },
                              onQuantityChanged: (newQuantity) {
                                setState(() {
                                  refProduct.pivot!.quantity = newQuantity;
                                  _recalculateTotalPrice();
                                });
                              },
                              bill: refProduct,
                              supplier: widget.bill.supplier,
                              pivot: refPivot,
                              quantity: refQuantity,
                              image: image,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  if (widget.bill.products!.isEmpty) ...[
                    Center(
                        child: Column(
                      children: [
                        SvgPicture.asset(
                            width: 400,
                            height: 400,
                            'assets/images/No data-pana (2).svg'),
                        Text(
                          'سلة الطلبات فارغة',
                          style: Styles.textStyle24(context)
                              .copyWith(color: Colors.red),
                        )
                      ],
                    ))
                  ],
                  if (widget.bill.products!.isEmpty) ...[
                    CheckoutSummaryEdit(
                      total: widget.bill.totalPrice,
                      chosenPaymentMethod: _chosenPaymentMethod,
                      onPaymentMethodChanged: (newValue) {
                        setState(() {
                          _chosenPaymentMethod = newValue!;
                        });
                      },
                      onCouponTap: () {},
                      onOrderNow: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            // الحصول على بيانات الارتفاع والإدراجات الحالية
                            final bottomInset =
                                MediaQuery.of(context).viewInsets.bottom;
                            final availableHeight =
                                MediaQuery.of(context).size.height -
                                    bottomInset;

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    bottomInset, // إضافة المساحة المتاحة عند ظهور لوحة المفاتيح
                              ),
                              child: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: availableHeight,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'الإجمالي: ${widget.bill.totalPrice.toString()}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            'طريقة الدفع:',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          DropdownButton<String>(
                                            value: _chosenPaymentMethod,
                                            items: <String>[
                                              'كاش',
                                              'الدفع آجل',
                                              '..'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _chosenPaymentMethod =
                                                    newValue!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller: note,
                                        maxLines: 3,
                                        decoration: const InputDecoration(
                                          hintText: 'أضف ملاحظاتك هنا',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.green,
                                            minimumSize:
                                                const Size(double.infinity, 60),
                                            elevation: 10,
                                            shape:
                                                const RoundedRectangleBorder(),
                                          ),
                                          onPressed: () {
                                            _confirmOrder();
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'تأكيد الطلب',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

      
//       body: BlocProvider(
//         create: (context) => BillCubitGet(dio: Dio()),
//         child: BlocConsumer<BillCubitGet, BillStateGet>(
//           listener: (context, state) {
//             if (state is InvoiceError) {
//               showCustomSnackBar(context, state.error, color: kPrimaryColorred);
//             }
//             if (state is InvoiceSuccess) {
//               showCustomSnackBar(context, state.message, color: Colors.green);
//               setState(() {
//                 widget.bill.products!.clear();
//                 widget.bill.totalPrice = 0;
//               });
//             }
//           },
//           builder: (context, state) {
//             if (state is InvoiceLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(color: kPrimaryColorred),
//               );
//             }
//             return Padding(
//               padding: const EdgeInsets.all(2),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView(children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             refBill.supplier!.firstName!,
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           Text(
//                             'الإجمالي: ${widget.bill.totalPrice} ج.م',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'العدد: ${refBill.products!.length}',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         itemCount: refBill.products!.length,
//                         itemBuilder: (context, productIndex) {
//                           var refProduct = refBill.products![productIndex];
//                           var refPivot =
//                               widget.bill.supplier?.products![productIndex];
//                           var refQuantity = refProduct.pivot!.quantity;
//                           return CartItemEdit(
//                             onDelete: () => _deleteItem(productIndex),
//                             onQuantityChanged: (newQuantity) {
//                               setState(() {
//                                 refProduct.pivot!.quantity = newQuantity;
//                                 _recalculateTotalPrice();
//                               });
//                             },
//                             bill: refProduct,
//                             supplier: reFSubblier,
//                             pivot: refPivot,
//                             quantity: refQuantity,
//                           );
//                         },
//                       ),
//                     ]),
//                   ),
//                   CheckoutSummaryEdit(
//                     total: refBill.totalPrice,
//                     chosenPaymentMethod: _chosenPaymentMethod,
//                     onPaymentMethodChanged: (newValue) {
//                       setState(() {
//                         _chosenPaymentMethod = newValue!;
//                       });
//                     },
//                     onCouponTap: () {},
//                     onOrderNow: () {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Text(
//                                   ' الإجمالي: ${refBill.totalPrice.toString()}',
//                                   style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     const Text(
//                                       'طريقة الدفع:',
//                                       style: TextStyle(fontSize: 18),
//                                     ),
//                                     DropdownButton<String>(
//                                       value: _chosenPaymentMethod,
//                                       items: <String>['كاش', ' الدفع آجل', '..']
//                                           .map<DropdownMenuItem<String>>(
//                                               (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                       onChanged: (String? newValue) {
//                                         setState(() {
//                                           _chosenPaymentMethod = newValue!;
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 16),
//                                 const TextField(
//                                   maxLines: 3,
//                                   decoration: InputDecoration(
//                                     hintText: 'أضف ملاحظاتك هنا',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8.0),
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       foregroundColor: Colors.white,
//                                       backgroundColor:
//                                           Colors.green, // لون النص للزر
//                                       minimumSize:
//                                           const Size(double.infinity, 60),
//                                       elevation: 10, // ارتفاع الظل
//                                       shape: const RoundedRectangleBorder(
//                                           // تغيير شكل الزر
//                                           ), // عرض الزر يأخذ الحجم الكامل للشاشة وارتفاع 60
//                                     ),
//                                     onPressed: () {
//                                       _confirmOrder();
//                                       Navigator.pop(context);
//                                     },
//                                     child: const Text(
//                                       ' تأكيد الطلب',
//                                       style: TextStyle(
//                                           fontSize:
//                                               20), // يمكنك تخصيص النص كما تريد
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
