import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:kamelshop/logic/models/category.dart';
import 'package:kamelshop/presentation/login_screen.dart';
import 'package:kamelshop/presentation/map_screen.dart';
import 'package:kamelshop/presentation/otp_screen.dart';
import 'package:kamelshop/presentation/screens/cart/cart_screen.dart';
import 'package:kamelshop/presentation/screens/catalogue/catalogue.dart';
import 'package:kamelshop/presentation/screens/category_products/category_products.dart';
import 'package:kamelshop/presentation/screens/details/details_screen.dart';
import 'package:kamelshop/presentation/screens/home/home_screen.dart';
import 'package:kamelshop/presentation/screens/ordre/orders.dart';
import 'package:kamelshop/presentation/screens/profile/profile_screen.dart';
import 'package:kamelshop/presentation/screens/sign_in/login.dart';
import 'package:kamelshop/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:kamelshop/presentation/screens/sign_up/register.dart';
import 'package:kamelshop/presentation/screens/splash/splash_screen.dart';
import 'package:kamelshop/presentation/screens/user_details/profile.dart';
import 'package:kamelshop/presentation/strings.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    final Category? category = settings.arguments as Category?;

    switch (settings.name) {
      case '/map-screen':
        return MaterialPageRoute(
          builder: (_) => MapScreen(),
        );

      case '/login-screen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
      case '/':
        return MaterialPageRoute(
          builder: (_) => Login(),
        );
      case '/signIn':
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );
      case '/splash':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (_) => Register(),
        );
      // case '/orderDetails':
      // return MaterialPageRoute(
      //   builder: (_) => OrderDetails(),
      // );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case '/profileDetails':
        return MaterialPageRoute(
          builder: (_) => Profile(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/catalogue':
        return MaterialPageRoute(
          builder: (_) => Catalogue(),
        );
      case '/categoryProducts':
        return MaterialPageRoute(
          builder: (_) => CategoryProducts(category: category!),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (_) => Register(),
        );
      case '/card':
        return MaterialPageRoute(
          builder: (_) => CartScreen(),
        );
      case '/order':
        return MaterialPageRoute(
          builder: (_) => Orders(),
        );
    }
  }
}
