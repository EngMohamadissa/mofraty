import 'dart:convert';

import 'package:eghyptproject/Featuer/cart/presentation/manger/new_bill_cubit.dart';
import 'package:eghyptproject/Featuer/cart/presentation/manger/new_bill_state.dart';
import 'package:eghyptproject/Featuer/cart/presentation/view/widget/cart.dart';
import 'package:eghyptproject/Featuer/cart/presentation/view/widget/cart_item_widget.dart';
import 'package:eghyptproject/Featuer/cart/presentation/view/widget/checkout_summary.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';
import 'package:eghyptproject/constant.dart';

import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/utils/funcations/validat_funcation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems = Cart().cartProducts;
  final SupplierModel? supplier;
  List<Map<String, dynamic>>? order;
  final Map<int, String>? supplierNames;
//  final Map<int, String>? supplierNames;
  final double? minBillPrice;
  final int? minSellingQuantity;
  final num totlepriceSupllier;

  CartPage({
    super.key,
    required this.supplier,
    required this.order,
    required this.supplierNames,
    required this.minBillPrice,
    required this.minSellingQuantity,
    required this.totlepriceSupllier,
  });

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late SupplierInfo supplierInfo;
  String _chosenPaymentMethod = 'كاش';
  double total = 0;
  int totalQuantity = 0;
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    super.initState();
    _calculateTotalAndQuantity();
  }

  void _removeCartItem(Product product, String supplierName) {
    int index = widget.cartItems.indexWhere((cartItem) =>
        cartItem.id == product.id && cartItem.supllierName == supplierName);
    if (index != -1) {
      setState(() {
        widget.cartItems.removeAt(index);
        _calculateTotalAndQuantity();
      });
    }
  }

  void _deleteOrderFromSharedPreferences(
      Product product, String supplierName) async {
    final prefs = await SharedPreferences.getInstance();
    final String? ordersString = prefs.getString('orders');
    if (ordersString != null) {
      final List<Map<String, dynamic>> ordersList = json.decode(ordersString);
      int index = ordersList.indexWhere((order) =>
          order['productId'] == product.id &&
          order['supplierName'] == supplierName);
      if (index != -1) {
        ordersList.removeAt(index);
        await prefs.setString('orders', json.encode(ordersList));
        setState(() {
          widget.order = ordersList;
        });
      }
    }
  }

  Product findCartItemForProduct(Product product, String supplierName) {
    // ابحث في قائمة العناصر في السلة عن المنتج والمورد المحددين.
    // هذا يفترض أن لديك طريقة لمطابقة المنتج والمورد مع CartItem.
    for (var cartItem in widget.cartItems) {
      if (cartItem.id == product.id && cartItem.supllierName == supplierName) {
        return cartItem;
      }
    }
    throw Exception(
        'CartItem not found'); // أو يمكنك إرجاع قيمة null أو CartItem فارغ إذا كان ذلك أفضل لمنطقك.
  }

  void _calculateTotalAndQuantity() {
    total = widget.cartItems.fold(0, (sum, item) {
      if (item.hasOffer) {
        int offerQuantity = item.maxOfferQuantity;
        int restQuantity = item.quantity - offerQuantity;
        if (restQuantity > 0) {
          return sum +
              (offerQuantity * item.offerPrice) +
              (restQuantity * item.price);
        } else {
          return sum + (item.quantity * item.offerPrice);
        }
      } else {
        return sum + (item.quantity * item.price);
      }
    });
    totalQuantity =
        widget.cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void _clearCart() {
    setState(() {
      widget.cartItems.clear();
      _calculateTotalAndQuantity();
      clearSharedPreferences();
    });
  }

  int calculateTotalItemsForSupplier(List<Product> supplierProducts) {
    return supplierProducts.length;
  }

  double _calculateTotalForSupplier(List<Product> supplierProducts) {
    return supplierProducts.fold(0, (sum, product) {
      double totalForProduct;

      if (product.hasOffer && product.quantity > product.maxOfferQuantity) {
        int offerQuantity = product.maxOfferQuantity;
        int restQuantity = product.quantity - offerQuantity;
        totalForProduct = (offerQuantity * product.offerPrice) +
            (restQuantity * product.price);
      } else if (product.hasOffer) {
        totalForProduct = product.quantity * product.offerPrice;
      } else {
        totalForProduct = product.quantity * product.price;
      }

      return sum + totalForProduct;
    });
  }

  Future<void> _storeTotalForSupplier(double total) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('total', total);
  }

  // Future<void> _onOrderNow(BillCubit cubit) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('access_token');

  //   if (token != null) {
  //     cubit.createBill();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Product>> productsBySupplier = {};
    for (var product in Cart().cartProducts) {
      if (!productsBySupplier.containsKey(product.supllierName)) {
        productsBySupplier[product.supllierName] = [];
      }
      productsBySupplier[product.supllierName]?.add(product);
    }
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var padding = screenWidth * 0.02;
    var totalItems = widget.cartItems.length;

    var supplierProductsList =
        Cart().getProductsBySupplier(widget.supplierNames!);
    var transferProductsList =
        Cart().transformSupplierProductsList(supplierProductsList, note.text);

    return BlocConsumer<BillCubit, BillState>(
      listener: (context, state) {
        if (state is BillSuccess) {
          _clearCart();
          playSound('sounds/Cash Purchase Sound Effects(MP3_128K).mp3');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.red,
            title: Text(
              'سلة الطلبات',
              style: Styles.textStyle24(context).copyWith(color: Colors.white),
            ),
            actions: [
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  showCustomAlertDialog(
                    context: context,
                    title: 'تحذير',
                    content:
                        'هل أنت متأكد من أنك تريد حذف جميع المنتجات من السلة؟',
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
                        child: GestureDetector(
                          onTap: () {
                            playSound(
                                'sounds/zapsplat_household_wire_brush_scrub_clean_dry_concrete_single_003_107476.mp3');
                            _clearCart();
                            Navigator.of(context).pop();
                          },
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          kPrimaryColorred)),

                              //  ElevatedButton.styleFrom(
                              //     backgroundColor: Colors.red),
                              onPressed: null,
                              child: Text(
                                'حذف',
                                style: Styles.textStyle18(context)
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                      ),
                      // يمكن إضافة المزيد من الأزرار هنا
                    ],

                    // buttonText: 'حذف',
                    // onButtonPressed: () {
                    //   _clearCart();
                    //   Navigator.of(context).pop();
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
          body: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                if (productsBySupplier.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.supplier!.firstName,
                        style: Styles.textStyle20(context).copyWith(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'الإجمالي: $total ج.م',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'العدد: $totalItems',
                        style: Styles.textStyle18(context),
                      ),
                    ],
                  ),
                ],
                Expanded(
                  child: ListView.builder(
                    itemCount: productsBySupplier.length,
                    itemBuilder: (BuildContext context, int index) {
                      String supplierName =
                          productsBySupplier.keys.elementAt(index);
                      List<Product> supplierProducts =
                          productsBySupplier[supplierName]!;

                      supplierInfo = Cart().suppliersInfo[supplierName]!;

                      double totalForSupplier =
                          _calculateTotalForSupplier(supplierProducts);
                      int totalItemSupllier =
                          calculateTotalItemsForSupplier(supplierProducts);
                      _storeTotalForSupplier(totalForSupplier);

                      return Column(
                        key: ValueKey(supplierName),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible:
                                totalForSupplier < supplierInfo.minBillPrice,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.yellow.shade100,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'المنتجات التي أضيفت من '),
                                    TextSpan(
                                      text: supplierName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' أقل من ${supplierInfo.minBillPrice} كحد أدنى للشراء.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: totalItemSupllier <
                                supplierInfo.minSellingQuantity,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.yellow.shade100,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'عدد المنتجات التي أضيفت من '),
                                    TextSpan(
                                      text: supplierName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' أقل من ${supplierInfo.minSellingQuantity} منتجات كحد أدنى للشراء.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    supplierName,
                                    style: Styles.textStyle18(context)
                                        .copyWith(color: Colors.red),
                                  ),
                                  ResponsiveSizedBox.responsiveWidth(context),
                                  const Icon(Icons.store, color: Colors.green),
                                  Text(
                                    'الحد الادنى للسعر: ${supplierInfo.minBillPrice}',
                                    style: Styles.textStyle18(context),
                                  ),
                                  ResponsiveSizedBox.responsiveWidth(context),
                                  const Icon(Icons.shopping_cart,
                                      color: Colors.blue),
                                  Text(
                                    'الحد الادنى للكمية: ${supplierInfo.minSellingQuantity}',
                                    style: Styles.textStyle18(context),
                                  ),
                                  Text(
                                    'الإجمالي لـ $supplierName: $totalForSupplier',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: supplierProducts.length,
                            itemBuilder: (context, productIndex) {
                              var product = supplierProducts[productIndex];
                              var cartItem =
                                  findCartItemForProduct(product, supplierName);
                              return CartItem(
                                key: ValueKey('${supplierName}_$productIndex'),
                                cartItem: cartItem,
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
                                          backgroundColor: Colors.green,
                                        ),
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
                                        child: GestureDetector(
                                          onTap: () {
                                            playSound(
                                                'sounds/zapsplat_household_wire_brush_scrub_clean_dry_concrete_single_003_107476.mp3');
                                            _removeCartItem(
                                                product, supplierName);
                                            _deleteOrderFromSharedPreferences(
                                                product, supplierName);
                                            Navigator.of(context).pop();
                                          },
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          kPrimaryColorred)),
                                              onPressed: null
                                              //  () {
                                              //   _removeCartItem(
                                              //       product, supplierName);
                                              //   _deleteOrderFromSharedPreferences(
                                              //       product, supplierName);
                                              //   Navigator.of(context).pop();
                                              // },
                                              ,
                                              child: Text(
                                                'حذف',
                                                style:
                                                    Styles.textStyle18(context)
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                              )),
                                        ),
                                      ),
                                      // يمكن إضافة المزيد من الأزرار هنا
                                    ],

                                    // buttonText: 'حذف',
                                    // onButtonPressed: () {
                                    //   _removeCartItem(product, supplierName);
                                    //   _deleteOrderFromSharedPreferences(
                                    //       product, supplierName);
                                    //   Navigator.of(context)
                                    //       .pop(); // إغلاق الحوار بعد الحذف
                                    // },
                                  );
                                },
                                onQuantityChanged: (newQuantity) {
                                  setState(() {
                                    widget.totlepriceSupllier;
                                    cartItem.quantity = newQuantity;
                                    _calculateTotalAndQuantity();
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                if (productsBySupplier.isEmpty) ...[
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
                if (productsBySupplier.isNotEmpty) ...[
                  CheckoutSummary(
                    total: total,
                    chosenPaymentMethod: _chosenPaymentMethod,
                    onPaymentMethodChanged: (newValue) {
                      setState(() {
                        _chosenPaymentMethod = newValue!;
                      });
                    },
                    onOrderNow: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'الإجمالي: $total',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
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
                                            _chosenPaymentMethod = newValue!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextField(
                                            controller: note,
                                            maxLines: 2,
                                            decoration: const InputDecoration(
                                              hintText: 'أضف ملاحظاتك هنا',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        minimumSize:
                                            const Size(double.infinity, 60),
                                        elevation: 10,
                                        shape: const RoundedRectangleBorder(),
                                      ),
                                      onPressed: () {
                                        final cubit = context.read<BillCubit>();

                                        print(productsBySupplier);
                                        print(supplierInfo.minSellingQuantity);

                                        cubit.createBill(transferProductsList);
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
                          );
                        },
                      );
                    },
                    // onOrderNow: () {
                    // final cubit = context.read<BillCubit>();
                    // cubit.createBill(transferProductsList);
                    // },
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}

class ResponsiveSizedBox {
  static SizedBox responsiveWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define your breakpoints and size scaling
    double boxWidth = 16; // Default width for small screens (phones)
    if (screenWidth > 1200) {
      // Large screens (large tablets, desktops)
      boxWidth = 32; // Adjust the width as needed for larger screens
    } else if (screenWidth > 600) {
      // Medium screens (tablets)
      boxWidth = 24; // Adjust the width as needed for medium screens
    }

    // Return the SizedBox with the adjusted width
    return SizedBox(width: boxWidth);
  }
}
