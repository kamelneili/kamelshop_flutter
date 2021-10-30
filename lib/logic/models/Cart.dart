import 'package:kamelshop/logic/models/Product.dart';

class CartItem {
  Product? product;
  String? qty;

  CartItem(
    this.product,
    this.qty,
  );

  CartItem.fromJson(Map<String, dynamic> json) {
    // print(json);
    //print(json['product']);
    this.product = Product.fromJson(json['product']);
    this.qty = json['qty'].toString();

    //int.tryParse(json['qty']);
    print(this.qty);
  }
}

class Cart {
  List<CartItem> cartItems = [];
  int id = 1;
  int total = 0;
  Cart(
    this.id,
    this.total,
    this.cartItems,
  );

  Cart.fromJson(Map<String, dynamic> json) {
    cartItems = [];
    var items = json['cart_items'];
    // print(items);
    for (var item in items) {
      cartItems.add(CartItem.fromJson(item));
    }
    this.id = json['id'];
    this.total = json['total'];
    //  print(this.total);
  }
}
