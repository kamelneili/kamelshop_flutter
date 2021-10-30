import 'dart:convert';
import 'package:kamelshop/logic/models/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartAPI {
  Future<Cart?> fetchCart(String token) async {
    String baseUrl = '192.168.1.20';
    String cart = 'flutter2/kamelshopapi/public/api/cart';

    Uri uri = Uri.http(baseUrl, '$cart');
    var res = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    //int userId = pref.getInt('id');
    print(res.statusCode);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      print(data);

      Cart.fromJson(data);
      print(Cart.fromJson(data));

      return Cart.fromJson(data);
    } else {
      print('error cart not displayed');
    }
  }

  Future<bool> addProductToCart(String productId) async {
    print("cartapi");
    String pId = productId;
    print(pId);
    String baseUrl = '192.168.1.20';
    String cart = 'flutter2/kamelshopapi/public/api/cart';
    //   var token = data['data']['access_token'];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Uri uri = Uri.http(baseUrl, '$cart');
    //print(token);
    var res = await http.post(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      'product_id': productId,
      'qty': 1.toString()
    });
    print(res.statusCode);
    //final data = json.decode(res.body);
    if (res.statusCode == 200) {
      return true;
      //  print('true');
    } else {
      return false;
      print('error to add product');
    }
  }

//remove product from cart

  Future<bool> removeProductToCart(String productId) async {
    String pId = productId;
    // print(pId);
    String baseUrl = '192.168.1.20';
    String cart = 'flutter2/kamelshopapi/public/api/cart/remove';
    //   var token = data['data']['access_token'];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Uri uri = Uri.http(baseUrl, '$cart');
    //print(token);
    var res = await http.post(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      'product_id': productId.toString(),
      //  'qty': 1.toString()
    });
    // print(res.statusCode);
    //final data = json.decode(res.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
      print('error');
    }
  }
}
