import 'package:eghyptproject/Featuer/cart/presentation/manger/new_bill_cubit.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/data/product_model.dart';

class SupplierInfo {
  double minBillPrice;
  int minSellingQuantity;

  SupplierInfo({required this.minBillPrice, required this.minSellingQuantity});
}

class Cart {
  static final Cart _singleton = Cart._internal();

  factory Cart() {
    return _singleton;
  }

  Cart._internal();

  final List<Product> _cartProducts = [];
  final Map<String, SupplierInfo> _suppliersInfo = {};

  List<Product> get cartProducts => _cartProducts;
  Map<String, SupplierInfo> get suppliersInfo => _suppliersInfo;
  void addProduct(
    Product product,
    String supplierName,
  ) {
    product.supllierName = supplierName; // Assuming Product has supplierName
    _cartProducts.add(product);
    calculateTotalAndQuantity();
  }

  void addSupplierInfo(
      String supplierName, double minBillPrice, int minSellingQuantity) {
    _suppliersInfo[supplierName] = SupplierInfo(
        minBillPrice: minBillPrice, minSellingQuantity: minSellingQuantity);
  }

  List<Map<String, dynamic>> transformSupplierProductsList(
    List<Map<String, dynamic>> supplierProductsList,
    String note,
  ) {
    return supplierProductsList.map((supplierEntry) {
      // Return the transformed supplier entry
      return {
        'supplier_id': supplierEntry['supplierId'],
        'payment_method_id': 1,
        'market_note': note,
        'products': supplierEntry['products'],
      };
    }).toList();
  }

  List<Map<String, dynamic>> getProductsBySupplier(
      Map<int, String> supplierNames) {
    Map<int, List<Map<String, int>>> supplierProductsMap = {};
    for (var product in _cartProducts) {
      if (!supplierProductsMap.containsKey(product.supplierId)) {
        supplierProductsMap[product.supplierId] = [];
      }
      supplierProductsMap[product.supplierId]?.add({
        'id': product.productId,
        'quantity': product.quantity,
      });
    }

    List<Map<String, dynamic>> supplierProductsList = [];
    supplierProductsMap.forEach((supplierId, products) {
      supplierProductsList.add({
        'supplierId': supplierId,
        'supplierName': supplierNames[supplierId] ?? 'غير معروف',
        'products': products,
      });
    });

    return supplierProductsList;
  }

  void removeProduct(Product product) {
    _cartProducts.remove(product);
    calculateTotalAndQuantity();
    clearSharedPreferences();
  }

  double calculateTotalAndQuantity() {
    double total = _cartProducts.fold(0, (sum, item) {
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
    return total;
  }
}
