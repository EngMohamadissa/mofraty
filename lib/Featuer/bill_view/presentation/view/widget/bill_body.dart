// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_cubit.dart';
import 'package:eghyptproject/Featuer/bill_view/presentation/manager/cubit/bill_state.dart';
import 'package:eghyptproject/Featuer/cart_edit/presentaotion/view/cart_view_edit.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/utils/funcations/validat_funcation.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

// class BillBody extends StatelessWidget {
//   const BillBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool fromEdit = false;
//     String formattedDate =
//         DateFormat('EEEE, MMMM d, y, hh:mm a', 'ar_AE').format(DateTime.now());

//     final screenWidth = MediaQuery.of(context).size.width;
//     final isTablet = screenWidth >= 600;

//     return BlocBuilder<BillCubitGet, BillStateGet>(
//       builder: (context, state) {
//         if (state is BillLoaded) {
//           return ListView.builder(
//             itemCount: state.bills.length,
//             itemBuilder: (context, index) {
//               final bill = state.bills[index];
//               var billid = bill.id;
//               return Container(
//                 margin: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   color: const Color.fromARGB(255, 215, 207, 207),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: isTablet ? 530 : 165,
//                           ),
//                           Expanded(
//                             // استخدم Expanded للسماح للنص بالتوسع
//                             child: Text(
//                               'رقم الفاتورة: ${bill.id}',
//                               style: TextStyle(
//                                 fontSize: isTablet ? 28.0 : 24.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               // overflow: TextOverflow
//                               //     .ellipsis, // استخدم ellipsis لتجنب النص الطويل جدا
//                             ),
//                           ),
//                           SizedBox(
//                             width: isTablet ? 450 : 90,
//                           ),
//                           Expanded(
//                             // استخدم Expanded هنا أيضا إذا كان النص يمكن أن يكون طويلا
//                             child: Text(
//                               'الحالة: ${bill.status}',
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontSize: isTablet ? 16.0 : 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               // overflow: TextOverflow
//                               //     .ellipsis, // استخدم ellipsis هنا أيضا
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'تم الانشاء ${bill.createdFrom}',
//                         style: TextStyle(
//                           fontSize: isTablet ? 18.0 : 16.0,
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),
//                       Text(
//                         'طريقه الدفع :${bill.paymentMethod}',
//                         style: TextStyle(
//                           fontSize: isTablet ? 20.0 : 18.0,
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),
//                       Text(
//                         'الشراء:من تجار',
//                         style: TextStyle(
//                           fontSize: isTablet ? 20.0 : 18.0,
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       const Divider(
//                         color: Colors.black,
//                       ),
//                       Text(
//                         'ملخص الفاتورة:',
//                         style: TextStyle(
//                           fontSize: isTablet ? 24.0 : 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: bill.products?.length,
//                         itemBuilder: (context, productindex) {
//                           // final bill = state.bills[index];
//                           var product = bill.products![productindex];
//                           var splier = bill.supplier?.products![productindex];
//                           // الوصول إلى اسم المنتج
//                           var productName = product.name;
//                           // الوصول إلى الكمية من كائن pivot
//                           var productQuantity = product.pivot?.quantity;

//                           return BlocBuilder<BillCubitGet, BillStateGet>(
//                             builder: (context, state) {
//                               if (state is BillLoaded) {
//                                 return Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       '$productName      ${productQuantity}X',
//                                       style: const TextStyle(fontSize: 20),
//                                     ),
//                                     if (product.pivot!.hasOffer == true) ...[
//                                       Row(
//                                         children: [
//                                           Text(
//                                             '${splier?.pivot!.price} ' 'ج' '',
//                                             style: const TextStyle(
//                                               decoration:
//                                                   TextDecoration.lineThrough,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 8,
//                                           ),
//                                           Text(
//                                             '${splier?.pivot!.offerPrice} '
//                                             '\$'
//                                             '',
//                                             style: const TextStyle(
//                                                 color: Colors.green),
//                                           ),
//                                         ],
//                                       ),
//                                     ] else ...[
//                                       Text('${splier?.pivot!.price} ' 'ج' ''),
//                                     ],
//                                   ],
//                                 );
//                               }

//                               return Container();
//                             },
//                           );
//                         },
//                       ),
//                       const Divider(
//                         color: Colors.black,
//                       ),
//                       Text(
//                         ' السعر الاجمالي ' 'ج' '${bill.totalPrice}',
//                         style: TextStyle(
//                           fontSize: isTablet ? 24.0 : 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'وفرنالك 😊:  ' '\$' '${bill.waffarnalak}',
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                       if (bill.updatable == true && state.statusBill == 'حالية')
//                         // buildActionIcons(context),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.edit,
//                             color: Color.fromARGB(255, 40, 117, 42),
//                           ),
//                           onPressed: () async {
//                             fromEdit = true;
//                             SharedPreferences prefs =
//                                 await SharedPreferences.getInstance();
//                             prefs.setBool('fromEdit', fromEdit);
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) =>
//         CartEditView(bill: state.bills[index]),

//   ),
// );
//                           },
//                         ),
//                       if (bill.updatable == true && state.statusBill == 'حالية')
// BlocConsumer<BillCubitGet, BillStateGet>(
//   listener: (context, state) {
//     if (state is BillDeletFailure) {
//       showCustomSnackBar(context, state.errorMessage,
//           color: kPrimaryColorred);
//     } else if (state is BillDeletSuccess) {
//       showCustomSnackBar(context, state.message,
//           color: Colors.green);
//     }
//   },
//   builder: (context, state) {
//     return IconButton(
//       onPressed: () {
//         BlocProvider.of<BillCubitGet>(context)
//             .deleteBill(billid!);

//         BlocProvider.of<BillCubitGet>(context)
//             .getBills(BillType.current);
//       },
//       icon: const Icon(Icons.delete),
//     );
//   },
// )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         } else if (state is BillLoading) {
//           return buildLoadingIndicator();
//         } else if (state is BillError) {
//           return Text('Error: ${state.message}');
//         }
//         return Container();
//       },
//     );
//   }

//   Widget buildActionIcons(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         IconButton(
//           icon: const Icon(
//             Icons.delete,
//             color: Color.fromRGBO(244, 67, 54, 1),
//           ),
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return ConfirmDialog(
//                   title: 'تأكيد الحذف',
//                   content:
//                       'هل أنت متأكد من أنك تريد حذف هذه الفاتورة لا يمكن التراجع عن هذا الإجراء.',
//                   onConfirm: () {
//                     // إضافة الوظيفة الخاصة بالحفظ
//                     // ... كود الحفظ
//                   },
//                   onCancel: () {
//                     // إغلاق الحوار
//                   },
//                 );
//               },
//             );
//           },
//         ),
//         IconButton(
//             icon: const Icon(
//               Icons.edit,
//               color: Color.fromARGB(255, 40, 117, 42),
//             ),
//             onPressed: () {}),
//       ],
//     );
//   }
// }

// class CartPage2 extends StatelessWidget {
//   final num? idF;

//   const CartPage2({super.key, this.idF});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('$idF')),
//     );
//   }
// }

class BillBody extends StatelessWidget {
  const BillBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //String formattedDate =
    //  DateFormat('EEEE, MMMM d, y, hh:mm a', 'ar_AE').format(DateTime.now());

    // String formattedDate =
    //   DateFormat('d // y ', 'ar_AE').format(DateTime.now());

    String formattedDate = DateFormat('M/d/ y', 'ar_AE').format(DateTime.now());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Define breakpoints for responsive design
    const tabletBreakpoint = 600.0;
    const desktopBreakpoint = 1200.0;

    // Determine device type
    final isTablet =
        screenWidth >= tabletBreakpoint && screenWidth < desktopBreakpoint;
    final isDesktop = screenWidth >= desktopBreakpoint;

    // You can adjust the values for padding, margins, font size, etc., based on the device type
    double sidePadding = isDesktop
        ? 16.0
        : isTablet
            ? 12.0
            : 8.0;
    double fontSize = isDesktop
        ? 24.0
        : isTablet
            ? 20.0
            : 16.0;

    return BlocBuilder<BillCubitGet, BillStateGet>(
      builder: (context, state) {
        if (state is BillLoaded && state.bills.isNotEmpty) {
          return ListView.builder(
            itemCount: state.bills.length,
            itemBuilder: (context, index) {
              final bill = state.bills[index];
              var billid = bill.id;
              // final finalprice =
              //     (bill.additionalPrice! + bill.totalpriceafterdiscount);
              // DateTime createdAt = bill.createdAt!;

              // String formattedDate =
              //     '${createdAt.year}-${createdAt.month.toString().padLeft(
              //           2,
              //           '0',
              //         )}-${createdAt.day.toString().padLeft(
              //           2,
              //           '0',
              //         )}';

              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromARGB(255, 221, 215, 215),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            'رقم الفاتورة: ${bill.id}',
                            style: TextStyle(
                              fontSize: isTablet ? 24.0 : 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            // overflow: TextOverflow
                            //     .ellipsis, // استخدم ellipsis لتجنب النص الطويل جدا
                          ),
                          const Spacer(),
                          if (bill.status == 'انتظار') ...[
                            Container(
                              color: const Color.fromARGB(255, 243, 227, 85),
                              child: Text(
                                ' ${bill.status}',

                                style: TextStyle(
                                  fontSize: isTablet ? 16.0 : 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                // overflow: TextOverflow
                                //     .ellipsis, // استخدم ellipsis هنا أيضا
                              ),
                            )
                          ] else if (bill.status == 'ملغية' ||
                              bill.status == 'رفض الاستلام') ...[
                            Container(
                              color: const Color.fromARGB(255, 240, 72, 60),
                              child: Text(
                                ' ${bill.status}',

                                style: TextStyle(
                                  fontSize: isTablet ? 16.0 : 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                // overflow: TextOverflow
                                //     .ellipsis, // استخدم ellipsis هنا أيضا
                              ),
                            )
                          ] else ...[
                            Container(
                              color: const Color.fromARGB(255, 141, 215, 144),
                              child: Text(
                                ' ${bill.status}',

                                style: TextStyle(
                                  fontSize: isTablet ? 16.0 : 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                // overflow: TextOverflow
                                //     .ellipsis, // استخدم ellipsis هنا أيضا
                              ),
                            )
                          ]
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        ' تم الطلب بتارخ  ${bill.createdFrom}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'طريقه الدفع :${bill.paymentMethod}',
                        style: TextStyle(
                            fontSize: isTablet ? 20.0 : 18.0,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'الشراء: من تجار',
                        style: TextStyle(
                            fontSize: isTablet ? 20.0 : 18.0,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 16.0),
                      const Divider(
                        color: Colors.black,
                      ),
                      Text(
                        'ملخص الفاتورة:',
                        style: TextStyle(
                          fontSize: isTablet ? 24.0 : 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bill.products?.length,
                        itemBuilder: (context, productindex) {
                          // final bill = state.bills[index];
                          var product = bill.products![productindex];
                          //  var splier = bill.supplier?.products?[productindex];

                          var splier = (bill.supplier?.products != null &&
                                  bill.supplier!.products!.length >
                                      productindex)
                              ? bill.supplier!.products![productindex]
                              : null;

                          // الوصول إلى اسم المنتج
                          var productName = product.name;
                          // الوصول إلى الكمية من كائن pivot
                          var productQuantity = product.pivot?.quantity;

                          return BlocBuilder<BillCubitGet, BillStateGet>(
                            builder: (context, state) {
                              if (state is BillLoaded &&
                                  state.bills.isNotEmpty) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Wrap(
                                              children: [
                                                Container(
                                                  color: const Color.fromARGB(
                                                      255, 169, 166, 166),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    ' X$productQuantity ',
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Text(
                                                  '  $productName',
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ),
                                          if (product.pivot!.hasOffer ==
                                              true) ...[
                                            Row(
                                              children: [
                                                Text(
                                                  '${product.pivot!.price} ج',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.red,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '${product.pivot!.offerPrice} ج',
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 44, 139, 47)),
                                                ),
                                              ],
                                            ),
                                          ] else ...[
                                            Text(
                                              '${product.pivot!.price} ج',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        //color: Colors.black,
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return Container();
                            },
                          );
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      if (bill.goaldiscount == 0) ...[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            ' السعر الاجمالي' ': ' '${bill.totalPrice}' 'ج',
                            style: TextStyle(
                              fontSize: isTablet ? 24.0 : 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ] else ...[
                        Align(
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      children: [
                                        const Text(
                                          'السعر الأجمالي' ':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          '${bill.totalPrice}' 'ج',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 78
                                              : double.infinity,
                                        ),
                                        const Text(
                                          'خصم التاجر' ':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          '${bill.goaldiscount}' ' ج',
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 44, 139, 47),
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              if (bill.hasAdditionalCost == 1) ...[
                                Text(
                                  'خدمة التوفير :${bill.additionalPrice}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 44, 139, 47),
                                      fontSize: 16),
                                )
                              ],
                              Text(
                                'السعر النهائي: ${(bill.totalpriceafterdiscount! + bill.additionalPrice!.toDouble()).toString()} ج',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        )
                      ],
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 141, 215, 144),
                        ),
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'الموفراتي وفر لك 😊:  '
                            '${bill.waffarnalak}'
                            ' ج',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (bill.updatable == true && state.statusBill == 'حالية')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showCustomAlertDialog(
                                    context: context,
                                    title: 'ملاحظة',
                                    content: 'هل أنت متأكد من حذف هذه الفاتورة',
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
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: BlocConsumer<BillCubitGet,
                                              BillStateGet>(
                                            listener: (context, state) {
                                              if (state is BillDeletFailure) {
                                                showCustomSnackBar(
                                                    context, state.errorMessage,
                                                    color: kPrimaryColorred);
                                              } else if (state
                                                  is BillDeletSuccess) {
                                                playSound(
                                                    'sounds/zapsplat_household_wire_brush_scrub_clean_dry_concrete_single_003_107476.mp3');

                                                showCustomSnackBar(
                                                    context, state.message,
                                                    color: Colors.green);
                                              }
                                            },
                                            builder: (context, state) {
                                              return Text(
                                                'حذف',
                                                style:
                                                    Styles.textStyle18(context)
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                              );
                                            },
                                          ),
                                          onPressed: () {
                                            BlocProvider.of<BillCubitGet>(
                                                    context)
                                                .deleteBill(billid!);

                                            BlocProvider.of<BillCubitGet>(
                                                    context)
                                                .getBills(BillType.current);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ]);
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.width < 600
                                    ? 50
                                    : 70,
                                color: Colors.red,
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'إلغاء الطلبية',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.delete, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CartEditView(bill: state.bills[index]),
                                  ),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.width < 600
                                    ? 50
                                    : 70,
                                color: Colors.green,
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('تعديل الطلبية',
                                        style: TextStyle(color: Colors.white)),
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is BillLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BillError) {
          return builError(state.message);
        } else {
          return Center(
              child: SvgPicture.asset('assets/images/No data-pana (2).svg'));
        }
      },
      //assets/images/Empty.jpg
    );
  }

//   Widget buildActionIcons(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         IconButton(
//           icon: const Icon(
//             Icons.delete,
//             color: Color.fromRGBO(244, 67, 54, 1),
//           ),
//           onPressed: () {
//             showCustomAlertDialog(
//                 context: context,
//                 title: 'ملاحظة',
//                 content: 'هل أنت متأكد من حذف هذه الفاتورة',actions: [   Padding(
//                         padding: const EdgeInsets.only(left: 25),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green),
//                           child: Text(
//                             'إالغاء',
//                             style: Styles.textStyle18(context)
//                                 .copyWith(color: Colors.white),
//                           ),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red),
//                         child: Text(
//                           'حذف',
//                           style: Styles.textStyle18(context)
//                               .copyWith(color: Colors.white),
//                         ),
//                         onPressed: () {

//                           Navigator.of(context).pop();
//                         },
//                       ),

//                 ]);
//           },
//         ),
//         IconButton(
//           icon: const Icon(
//             Icons.edit,
//             color: Color.fromARGB(255, 40, 117, 42),
//           ),
//           onPressed: () {},
//         )
//       ],
//     );
//   }
// }
}
