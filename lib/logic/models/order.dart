import 'package:kamelshop/logic/models/Cart.dart';

class Order {
  String? id;
  Cart? cart;
  String? date;
  String? code;
  int? total;
  String? status;
  Order(
    this.id,
    // this.cart,
    this.date,
    this.code,
    this.total,
    this.status,
  );

  Order.fromJson(Map<String, dynamic> json) {
    // print(items);

    this.id = json['id'].toString();
    this.date = json['created_at'];
    this.code = json['code'];
    this.total = json['total'];
    this.status = json['status'];

    //  print(this.total);
  }
}
