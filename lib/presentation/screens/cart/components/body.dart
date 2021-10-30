import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kamelshop/logic/blocs/Cart_bloc%20.dart';
import 'dart:async';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
//
  late Timer _timer;

  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add((DoFetchCartItemsEvent()));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (20)),
      child: BlocBuilder<CartBloc, CartStates>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            Future.delayed(Duration(seconds: 1), () {
              return Center(child: CircularProgressIndicator());
            });
          } else if (state is CartItemFetchSuccess) {
            if (state.cart == null)
              return Container();
            else
              return ListView.builder(
                itemCount: state.cart.cartItems.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key:
                        Key(state.cart.cartItems[index].product!.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        state.cart.cartItems.removeAt(index);
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(cartItem: state.cart.cartItems[index]),
                  ),
                ),
              );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),

      //
    );
  }
}
