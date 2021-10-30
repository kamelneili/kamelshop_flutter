import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/Cart_bloc%20.dart';
import 'package:kamelshop/logic/blocs/category_bloc%20.dart';
import 'package:kamelshop/logic/blocs/product_bloc.dart';
import 'package:kamelshop/presentation/components/product_card.dart';
import 'package:kamelshop/presentation/screens/catalogue/catalogue.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  // void initState() {
  //   BlocProvider.of<ProductBloc>(context).add(DoFetchEvent1());
  //   BlocProvider.of<CategoryBloc>(context).add(CatDoFetchEvent1());
  //    BlocProvider.of<CartBloc>(context).add(DoFetchCartItemsEvent());

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Popular Products",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Catalogue();
                }));
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:
              //************* */
              BlocBuilder<ProductBloc, ProductStates>(
            builder: (context, state) {
              if (state is LoadingState1) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is FetchSuccess1) {
                return Row(
                  children: [
                    ...List.generate(
                      state.products.length,
                      (index) {
                        return ProductCard(product: state.products[index]);

                        // here by default width and height is 0
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                );

                //SizedBox(width: getProportionateScreenWidth(20))

              }
              return const Center(child: CircularProgressIndicator());
            },
          ),

          //************** */
        )
      ],
    );
  }
}
