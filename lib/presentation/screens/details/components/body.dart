import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/Cart_bloc%20.dart';
import 'package:kamelshop/logic/models/Product.dart';
import 'package:kamelshop/presentation/components/default_button.dart';
import 'package:kamelshop/presentation/screens/cart/cart_screen.dart';
import 'package:kamelshop/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:kamelshop/presentation/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({required this.product});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: Color(0xFFF6F7F9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ColorDots(product: product),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: DefaultButton(
                              text: "Add To Cart",
                              press: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                int? userId = pref.getInt('id');
                                print(userId);
                                String? token = pref.getString('token');
                                print(token);
                                if (token == null) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return SignInScreen();
                                  }));
                                } else {
                                  BlocProvider.of<CartBloc>(context)
                                      .add(AddEvent(id: product.id.toString()));
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          title: Text(
                                              "New item has been added to your cart"),
                                          content: Container(
                                            height: 150.0,
                                            width: 600,
                                            //   color: kBackgroundColor,

                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  //                       child: Text(
                                                  //                         """ New item has been added to your cart
                                                  // """,
                                                  //                         style: TextStyle(
                                                  //                           fontSize: 28.0,
                                                  //                           fontWeight: FontWeight.w600,
                                                  //                           // color: kSecondaryColor,
                                                  //                         ),
                                                  //                       ),
                                                ),
                                                Icon(
                                                  Icons.done_all_outlined,
                                                  size: 30,
                                                  color: Colors.green,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                        child: Text("View cart",
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.blue,
                                                            )),
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                                      CartBloc>(
                                                                  context)
                                                              .add(
                                                                  DoFetchCartItemsEvent());

                                                          Navigator.pushNamed(
                                                              context, '/card');
                                                        } //Navigator.of(context, rootNavigator: true).pop()

                                                        ),
                                                    FlatButton(
                                                        child: const Text(
                                                            "No continue",
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.blue,
                                                            )),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        } //Navigator.of(context, rootNavigator: true).pop()

                                                        ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                        return Text("error");
                                      });
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
