//!Usually, we can use Ctrl+Space to get auto-suggestion on VSCode
//!ctrl+k+c Will comment out the selected chunk of code in VS Code.
//! SizedBox(height: SizeConfig.screenHeight * 0.04),

import 'package:flutter/material.dart';
import 'package:kamelshop/presentation/screens/splash/components/body.dart';
import 'package:kamelshop/presentation/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(body: Body());
  }
}
