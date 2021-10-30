import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/category_bloc%20.dart';
import 'package:kamelshop/logic/models/category.dart';
import 'package:kamelshop/presentation/screens/category_products/category_products.dart';

class Catalogue extends StatefulWidget {
  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  static const kBackgroundColor = Color(0xFFF1EFF1);
  static const kPrimaryColor = Color(0xFF219ebc);
  static const kSecondaryColor = Color(0xFFfcca46);
  static const kTextColor = Color(0xFF023047);
  static const kTextLightColor = Color(0xFF747474);
  static const kBlueColor = Color(0xFF40BAD5);

  static const kDefaultPadding = 20.0;

  //PostsAPI postsAPI = PostsAPI();
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CatDoFetchEvent1());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Color(0xFF332F43),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Catalogue'),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: kDefaultPadding / 2),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70.0),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  BlocBuilder<CategoryBloc, CategoryStates>(
                      builder: (context, state) {
                    if (state is CatLoadingState1) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CatFetchSuccess1) {
                      return ListView.builder(
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: drawSingleRow(state.categories[index]),
                            );
                          });
                    }
                    return Text("error");
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //

    //
  }

  Widget drawSingleRow(Category category) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 190.0,
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 25,
                      color: Colors.black12),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 160.0,
                  width: 200.0,
                  child: Image.network(
                    //image_location,
                    // "assets/images/airpod.jpg",
                    category.image,
                    fit: BoxFit.cover,

                    //   fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: SizedBox(
                height: 136.0,
                // Because oure image is 200 width, then: width - 200
                width: size.width - 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        category.title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        // backgroundColor:Colors.white,
                        // heroTag: Text("btn1"),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 1, // 30 px padding
                            vertical: kDefaultPadding / 3, // 5 px padding
                          ),
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Row(
                            children: [
                              Text('products'),
                              Icon(Icons.arrow_right),
                            ],
                          ),
                        ),
                        onTap: () {
                          //Navigator.pushNamed(context, '/catalogue');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CategoryProducts(category: category);
                            }),
                          );
                          BlocProvider.of<CategoryBloc>(context).add(
                              CatDoFetchProductsEvent1(category: category));
                        },
                        // color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
