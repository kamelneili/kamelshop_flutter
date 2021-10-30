import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kamelshop/logic/models/Product.dart';
//import 'package:technoshop/utilities/api_utilities.dart';

class ProductsAPI {
  List<Product> products = [];
  Future<List<Product>> fetchPosts() async {
    //  List<PostModel> posts = [];
    String baseUrl = '192.168.1.20';
    String products_api = 'flutter2/kamelshopapi/public/api/products';

    Uri uri = Uri.http(baseUrl, '$products_api');

    var response = await http.get(uri);
    // ignore: deprecated_member_use
    List<Product> products = <Product>[];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      data.map((product) => products.add(Product.fromJson(product))).toList();
      //  data.map((post)=>posts.add(Post.fromJson(post))).toList();

    }
    //  print (products);

    return products;
  }

  // search function
  Future<List<Product>> searchProducts(key) async {
    List<Product> products = [];
    //List<Product>p=[];
    print(key);
    String all_products_api = 'flutter2/kamelshopapi/public/api/products/$key';
    String baseUrl = '192.168.1.20';

    Uri uri = Uri.http(baseUrl, '$all_products_api');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      var data = jsondata["data"];
      data.map((product) => products.add(Product.fromJson(product))).toList();
      print(products);
      //print (key);
      return products;
    } else
      return [];
  }
}
