import 'package:flutter/material.dart';
import 'package:kamelshop/logic/models/Product.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  //static String routeName = "/details";
  Product product;
  DetailsScreen({required this.product});
  @override
  Widget build(BuildContext context) {
    final Object? agrs = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        //  title: Text('Orders'),
      ),
      //appBar: CustomAppBar(rating: agrs!.product.rating),
      body: Body(product: this.product),
    );
  }
}
