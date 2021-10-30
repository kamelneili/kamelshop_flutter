import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/search_bloc.dart';
import 'package:kamelshop/logic/models/Product.dart';
import 'package:kamelshop/presentation/screens/details/details_screen.dart';
import 'package:kamelshop/presentation/screens/home/home_screen.dart';

class SearchProducts extends StatefulWidget {
  String k = '';
  SearchProducts(this.k);
  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  //PostsAPI postsAPI = PostsAPI();
  //Category category ;

  @override
  void initState() {
    BlocProvider.of<SearchBloc>(context).add(FindEvent(key: widget.k));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: kBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return HomeScreen();
            }));
          },
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<SearchBloc, SearchStates>(builder: (context, state) {
        if (state is SearchLoadingState1) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FindState) {
          return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: drawSingleRow(state.products[index]),
                );
              });
        } else {
          return Container(color: Colors.red);
        }
      }),
    );
    //

    //
  }

  Widget drawSingleRow(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              width: 124,
              height: 124,
              child: Image.network(
                //image_location,
                // "assets/images/p1.jpg",
                product.featuredImage,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(product.title),
                //.substring(0,20) + '...',),
                InkWell(
                  // backgroundColor:Colors.white,
                  // heroTag: Text("btn1"),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        // horizontal: kDefaultPadding * 1, // 30 px padding
                        // vertical: kDefaultPadding / 3, // 5 px padding
                        ),
                    decoration: BoxDecoration(
                      //  color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        Text('see more...'),
                        Icon(Icons.arrow_right),
                      ],
                    ),
                  ),

                  // color: Colors.red,

                  onTap: () {
                    //Navigator.pushNamed(context, '/catalogue');
                    // Navigator.pushNamed(context, '/h');
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DetailsScreen(product: product);
                    }));
                    //  Navigator.of(context).pushNamed('/catalogue');
                  },
                  // color: Colors.red,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
