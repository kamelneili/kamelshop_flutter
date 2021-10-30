import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kamelshop/logic/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderAPI {
  List<Order> orders = [];

  Future<List<Order>> fetchOrder(String token) async {
    String baseUrl = '192.168.1.20';
    String order = 'flutter2/kamelshopapi/public/api/order';

    Uri uri = Uri.http(baseUrl, '$order');
    var res = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    //int userId = pref.getInt('id');
    //print(res.statusCode);
    //print(res.body);
    List<Order> orders = <Order>[];
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(jsonData);
      var data = jsonData["data"];
      data.map((order) => orders.add(Order.fromJson(order))).toList();
      //  data.map((post)=>posts.add(Post.fromJson(post))).toList();

    }
    print(orders);

    return orders;
  }

  Future<bool> addOrder(int cartId, int total) async {
    //  var id= cartId;
    print(cartId);
    String baseUrl = '192.168.1.20';
    String cart = 'flutter2/kamelshopapi/public/api/order';
    //   var token = data['data']['access_token'];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Uri uri = Uri.http(baseUrl, '$cart');
    //print(cartId);
    var res = await http.post(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      'cart_id': cartId.toString(),
      // 'user_id': userId.toString()
      'total': total.toString(),
    });
    print(res.statusCode);
    //final data = json.decode(res.body);
    if (res.statusCode == 200) {
      return true;
      //  print('true');
    } else {
      print('error to add order');
    }
    return false;
  }

//remove product from cart

}
