import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kamelshop/enums.dart';
import 'package:kamelshop/presentation/screens/home/home_screen.dart';
import 'package:kamelshop/presentation/screens/profile/profile_screen.dart';
import 'package:kamelshop/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.selectedMenu,
  });

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return HomeScreen();
                      }))),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
                onPressed: () {},
              ),
              IconButton(
                //icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
                icon: Icon(Icons.dashboard, color: Colors.grey),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return HomeScreen();
                  }));
                },
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    color: MenuState.profile == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    int? userId = pref.getInt('id');
                    print(userId);
                    String? token = pref.getString('token');
                    if (token == null) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SignInScreen();
                      }));
                    } else
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProfileScreen();
                      }));
                  }),
            ],
          )),
    );
  }
}
