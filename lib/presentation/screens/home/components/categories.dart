import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/category_bloc%20.dart';
import 'package:kamelshop/presentation/screens/category_products/category_products.dart';

import '../../../size_config.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // @override
  // void initState() {
  //   BlocProvider.of<CategoryBloc>(context).add(CatDoFetchEvent1());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Container(
        height: 100,
        child: BlocBuilder<CategoryBloc, CategoryStates>(
          builder: (context, state) {
            if (state is CatLoadingState1) {
              Future.delayed(Duration(seconds: 1), () {
                return Center(child: CircularProgressIndicator());
              });
            }
            if (state is CatFetchSuccess1) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      image: state.categories[index].image,
                      text: state.categories[index].title.substring(0, 2),
                      press: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) {
                        //     return CategoryProducts(state.categories[index]);
                        //     // print(category);
                        //   }),
                        // );

                        Navigator.of(context).pushNamed(
                          '/categoryProducts',
                          arguments: state.categories[index],
                        );

                        context.read<CategoryBloc>().add(
                            CatDoFetchProductsEvent1(
                                category: state.categories[index]));
                      },
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.image,
    required this.text,
    required this.press,
  });

  final String image, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 100.0,
        child: ListTile(
            title: GestureDetector(
              onTap: press,
              child: Image.network(
                image,
                width: 70.0,
                height: 70.0,
              ),
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                text,
                style: TextStyle(fontSize: 15.0),
              ),
            )),
      ),
    );
  }
}
