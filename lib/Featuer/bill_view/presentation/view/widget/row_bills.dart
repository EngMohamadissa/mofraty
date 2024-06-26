// import 'package:eghypt_c/Featuer/bill_view/presentation/manager/cubit/bill_cubit.dart';
// import 'package:eghypt_c/Featuer/bill_view/presentation/modelbill/bill.dart';
// import 'package:eghypt_c/Featuer/bill_view/presentation/modelbill/product.dart';
// import 'package:eghypt_c/Featuer/bill_view/presentation/modelbill/supplier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../manager/cubit/bill_state.dart';

// class RowBills extends StatelessWidget {
//   final Product? billpruduct;
//   final Bill? bill;
//   final Supplier? billsupllier;

//   const RowBills({
//     super.key,
//     this.billpruduct,
//     this.bill,
//     this.billsupllier,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BillCubit, BillState>(
//       builder: (context, state) {
//         if (state is BillLoaded) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${billpruduct?.name}      ${billpruduct?.pivot?.quantity}X',
//                 style: const TextStyle(fontSize: 20),
//               ),
//               // if (billpruduct!.pivot!.hasOffer == true) ...[
//               //   Row(
//               //     children: [
//               //       Text(
//               //         '${billpruduct!.pivot!.price} ' '\$' '',
//               //         style: const TextStyle(
//               //           decoration: TextDecoration.lineThrough,
//               //         ),
//               //       ),
//               //       const SizedBox(
//               //         width: 8,
//               //       ),
//               //       Text(
//               //         '${billpruduct!.pivot!.offerPrice} ' '\$' '',
//               //         style: const TextStyle(color: Colors.green),
//               //       ),
//               //     ],
//               //   ),
//               // ] else ...[
//               //   Text('${billpruduct!.pivot!.price} ' '\$' ''),
//               // ],
//             ],
//           );
//         }

//         return Container();
//       },
//     );
//   }
// }







// {
//     "bills": [
//         {
//             "id": 55,
//             "market_id": 15,
//             "supplier_id": 2,
//             "payment_method_id": 1,
//             "total_price": 5500,
//             "recieved_price": 0,
//             "status": "انتظار",
//             "has_additional_cost": 1,
//             "market_note": "noote",
//             "rejection_reason": "",
//             "delivery_duration": "",
//             "created_at": "2024-05-14T15:37:24.000000Z",
//             "updated_at": "2024-05-14T15:37:24.000000Z",
//             "created_from": "منذ 14 ساعة",
//             "payment_method": "كاش",
//             "additional_price": 5582.5,
//             "waffarnalak": 0,
//             "updatable": false,
//             "products": [
              
//                 {
//                     "id": 37,
//                     "product_category_id": 9,
//                     "name": "بيبسي كنز ستار - 330 مل",
//                     "discription": "بالتة 6 عبوة",
//                     "size": 300,
//                     "size_of": "مل",
//                     "created_at": "2024-05-12T12:59:34.000000Z",
//                     "updated_at": "2024-05-12T12:59:34.000000Z",
//                     "image": [
//                         "https://backend.almowafraty.com/storage/Product/6640bd369f2f7_GywO1Kaj4PTH8ZxuRMSCYlkvWD0iQsmhg_bBtqp5zoEXI6cVrf."
//                     ],
//                     "product_category": "مشروبات ساقعة",
//                     "pivot": {
//                         "bill_id": 55,
//                         "product_id": 37,
//                         "quantity": 5
//                     }
//                 }
//             ],
//             "supplier": {
//                 "id": 2,
//                 "supplier_category_id": 1,
//                 "city_id": 1,
//                 "first_name": "Ransom",
//                 "middle_name": "Marina",
//                 "last_name": "Ward",
//                 "store_name": "Esteban Mills",
//                 "phone_number": "(615) 219-3913",
//                 "min_bill_price": 3930.32,
//                 "min_selling_quantity": 3,
//                 "delivery_duration": null,
//                 "status": "نشط",
//                 "created_at": "2024-05-11T00:26:17.000000Z",
//                 "updated_at": "2024-05-11T00:26:17.000000Z",
//                 "products": [
                  
//                     {
//                         "id": 37,
//                         "product_category_id": 9,
//                         "name": "بيبسي كنز ستار - 330 مل",
//                         "discription": "بالتة 6 عبوة",
//                         "size": 300,
//                         "size_of": "مل",
//                         "created_at": "2024-05-12T12:59:34.000000Z",
//                         "updated_at": "2024-05-12T12:59:34.000000Z",
//                         "image": [
//                             "https://backend.almowafraty.com/storage/Product/6640bd369f2f7_GywO1Kaj4PTH8ZxuRMSCYlkvWD0iQsmhg_bBtqp5zoEXI6cVrf."
//                         ],
//                         "product_category": "مشروبات ساقعة",
//                         "pivot": {
//                             "supplier_id": 2,
//                             "product_id": 37,
//                             "id": 39,
//                             "price": 200,
//                             "has_offer": 0,
//                             "offer_price": 0,
//                             "max_offer_quantity": 0,
//                             "offer_expires_at": "9999-01-01",
//                             "max_selling_quantity": 10,
//                             "is_available": 1
//                         }
//                     }
//                 ]
//             }
//         }]}