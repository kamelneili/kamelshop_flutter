import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/Cart_bloc%20.dart';
import 'package:kamelshop/presentation/screens/cart/cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add((DoFetchCartItemsEvent()));

    super.initState();
  }

  //checklogin
  bool isLoggedIn = false;
  late SharedPreferences sharedPreferences;
  late String token;
  _checkToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Object? token = sharedPreferences.get('token');
    // print(token);
    setState(() {
      if (token == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
    });
  }

  //
  int cartItem(state) {
    if (state.cart == null)
      return 0;
    else
      return state.cart.cartItems.length;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          BlocBuilder<CartBloc, CartStates>(
            builder: (context, state) {
              if (state is CartLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CartItemFetchSuccess) {
                return IconBtnWithCounter(
                    svgSrc: "assets/icons/Cart Icon.svg",
                    numOfitem: cartItem(state),
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CartScreen();
                      }));
                    });
              }
              return IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                numOfitem: 0,
                press: () {},
              );
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
