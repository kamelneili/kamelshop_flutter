import 'package:flutter/material.dart';
import 'package:kamelshop/presentation/screens/sign_in/components/body.dart';
import 'package:kamelshop/presentation/size_config.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        backgroundColor: Colors.blue,
      ),
      body: Body(),
    );
  }
}
