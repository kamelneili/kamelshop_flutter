import 'package:kamelshop/enums.dart';
import 'package:flutter/material.dart';
import 'package:kamelshop/presentation/components/coustom_bottom_nav_bar.dart';
import 'package:kamelshop/presentation/size_config.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
