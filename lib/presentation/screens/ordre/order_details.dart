import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/Cart_bloc%20.dart';
import 'package:kamelshop/logic/models/Cart.dart';
import 'package:kamelshop/logic/models/order.dart';
import 'package:kamelshop/presentation/components/default_button.dart';
import 'package:kamelshop/presentation/constants.dart';
import 'package:kamelshop/presentation/screens/home/home_screen.dart';
import 'package:kamelshop/presentation/size_config.dart';

class OrderDetails extends StatefulWidget {
  Order order;
  OrderDetails({required this.order});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  //PostsAPI postsAPI = PostsAPI();
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(DoFetchCartItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text('Order Details'),
        ),
        // drawer: NavigationDrawer(),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Text('Code:',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(width: 15),
                  Text(widget.order.code!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(width: 50),
                  Row(
                    children: [
                      Text('Total:',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(width: 15),
                      Text(widget.order.total.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("DT",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
              if (state is CartLoadingState) {
                Future.delayed(Duration(seconds: 1), () {
                  return Center(child: CircularProgressIndicator());
                });
              } else if (state is CartItemFetchSuccess) {
                if (state.cart == null)
                  return Container();
                else
                  //widget.somme=state.cart.total;

                  return ListView.builder(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 50),
                      itemCount: state.cart.cartItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: drawSingleRow(state.cart.cartItems[index]),
                        );
                      });
              }
              //
              //
              //
              //
              //

              return const Center(child: CircularProgressIndicator());
            }),
            SizedBox(height: (20)),
          ],
        ),
        bottomNavigationBar: DefaultButton(
          text: "Back to home",
          press: () {
            // if all are valid then go to success screen
            //KeyboardUtil.hideKeyboard(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeScreen();
              //HomeScreen();
            }));
          },
        ));
  }

  Widget drawSingleRow(CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                //image_location,
                // "assets/images/p1.jpg",
                cartItem.product!.featuredImage,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(cartItem.product!.title),
                    Stack(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(15)),
                          height: getProportionateScreenWidth(46),
                          width: getProportionateScreenWidth(46),
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Center(child: Text(cartItem.qty.toString())),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
