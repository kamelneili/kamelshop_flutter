import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kamelshop/logic/blocs/Cart_bloc%20.dart';
import 'package:kamelshop/logic/blocs/Order_bloc.dart';
import 'package:kamelshop/presentation/components/default_button.dart';
import 'package:kamelshop/presentation/screens/ordre/orders.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  int somme = 0;

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  int? cartId;
  int? total;
  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add((DoFetchCartItemsEvent()));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: (15),
        horizontal: (30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: (50)),
            BlocBuilder<CartBloc, CartStates>(
              builder: (context, state) {
                if (state is CartLoadingState) {
                  Future.delayed(Duration(seconds: 1), () {
                    return Center(child: CircularProgressIndicator());
                  });
                } else if (state is CartItemFetchSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Total:\n",
                              style: TextStyle(
                                  fontSize: 20,
                                  // fontWeight: FontWeight.w200,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: state.cart.total.toString(),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: DefaultButton(
                            text: "Check Out",
                            press: () {
                              //SharedPreferences pref = await SharedPreferences.getInstance();
                              //  int userId = pref.getInt('id');
                              // print(userId);
                              //String token = pref.getString('token');
                              //print(token);
                              BlocProvider.of<OrderBloc>(context).add(
                                  AddOrderEvent(
                                      cartId: cartId ?? 0, total: total ?? 0));
                              print(cartId);
                              print("order sent");

                              BlocProvider.of<OrderBloc>(context)
                                  .add(OrderFetchEvent());

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return Orders(
                                    cartId: cartId); //cartId:widget.cartId
                              }));
                            }),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
