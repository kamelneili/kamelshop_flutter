import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/search_bloc.dart';
import 'package:kamelshop/presentation/screens/search/searchproducts%20.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  // SearchField({
  //   required Key key,
  // }) : super(key: key);
  TextEditingController keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth! * 0.6,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: keyController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                BlocProvider.of<SearchBloc>(context)
                    .add(FindEvent(key: keyController.text));

                //Navigator.pushNamed(context, '/catalogue');
                // Navigator.pushNamed(context, '/h');
//Navigator.push(context, MaterialPageRoute(builder: (_) { return SearchProducts(keyController.text);  }));
                //  Navigator.of(context).pushNamed('/catalogue');
                Navigator.pushReplacement(
                    context,
                    //'/SearchProducts',
                    //arguments: keyController.text);
                    //setstate
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SearchProducts(keyController.text)));
              },
            ),
          ),
        ));
  }
}
