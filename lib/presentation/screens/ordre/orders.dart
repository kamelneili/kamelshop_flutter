import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/Order_bloc.dart';
import 'package:kamelshop/logic/models/order.dart';
import 'package:kamelshop/presentation/constants.dart';
import 'package:kamelshop/presentation/screens/ordre/order_details.dart';
import 'package:timeago/timeago.dart' as timeago;

class Orders extends StatefulWidget {
  int? cartId;
  Orders({this.cartId});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //PostsAPI postsAPI = PostsAPI();
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(OrderFetchEvent());

    super.initState();
  }

  String parseHumanDateTime(String dateTime) {
    Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
    DateTime theDifference = DateTime.now().subtract(timeAgo);
    return timeago.format(theDifference);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EFF1),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Orders'),
      ),
      // drawer: NavigationDrawer(),
      body: BlocBuilder<OrderBloc, OrderStates>(builder: (context, state) {
        if (state is OrderLoadingState) {
          Future.delayed(Duration(seconds: 1), () {
            return Center(child: CircularProgressIndicator());
          });
        } else if (state is OrderFetchSuccess) {
          return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return Card(
                  child: drawSingleRow(state.orders[index]),
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
    //

    //
  }

  Widget drawSingleRow(Order order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                //  Text(order.cart.id.toString()),
                Row(
                  children: [
                    Text('Code:'),
                    SizedBox(width: 15),
                    Text(order.code!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text('Date:'),
                    SizedBox(width: 15),
                    Text(
                      order.date!,
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Text('Status:'),
                    SizedBox(width: 15),
                    Text(
                      order.status!,
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),

                // color: Colors.red,
              ],
            ),
          ),

          // backgroundColor:Colors.white,
          // heroTag: Text("btn1"),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(
                  //  horizontal: kDefaultPadding * 1, // 30 px padding
                  // vertical: kDefaultPadding / 3, // 5 px padding
                  ),
              decoration: BoxDecoration(
                //   color: kSecondaryColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  InkWell(
                    // backgroundColor:Colors.white,
                    // heroTag: Text("btn1"),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              10, //kDefaultPadding * 1, // 30 px padding
                          vertical: 5 //kDefaultPadding / 3, // 5 px padding
                          ),
                      decoration: BoxDecoration(
                        //  color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          Text('Show'),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),

                    // color: Colors.red,

                    onTap: () {
                      //Navigator.pushNamed(context, '/catalogue');
                      // Navigator.pushNamed(context, '/h');
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return OrderDetails(order: order);
                      }));
                      //  Navigator.of(context).pushNamed('/catalogue');
                    },
                    // color: Colors.red,
                  )
                ],
              ),
            ),

            // color: Colors.red,

            onTap: () {
              //Navigator.pushNamed(context, '/catalogue');
              // Navigator.pushNamed(context, '/h');
              // Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   // return SingleProduct(heroTag:product.featuredImage,product:product);
              // }
              // ));
              //  Navigator.of(context).pushNamed('/catalogue');
            },
            // color: Colors.red,
          )
        ],
      ),
    );
  }
}
