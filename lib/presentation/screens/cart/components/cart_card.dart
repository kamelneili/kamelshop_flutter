import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/Cart_bloc%20.dart';
import 'package:kamelshop/logic/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    required this.cartItem,
  });

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all((10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                cartItem.product!.featuredImage,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.product!.title.substring(0, 3) + '...',
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: cartItem.product!.price,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 20),
          child: Expanded(
            child: Row(children: <Widget>[
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    height: getProportionateScreenWidth(46),
                    width: getProportionateScreenWidth(46),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {},
                  ),
                ],
              ),
              Text(cartItem.qty.toString()),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    height: getProportionateScreenWidth(46),
                    width: getProportionateScreenWidth(46),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(AddEvent(id: cartItem.product!.id.toString()));
                        BlocProvider.of<CartBloc>(context)
                            .add(DoFetchCartItemsEvent());
                      }),
                ],
              ),
            ]),
          ),
        )
      ],
    );
  }
}
