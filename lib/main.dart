import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/app_router.dart';
import 'package:kamelshop/logic/blocs/Cart_bloc%20.dart';
import 'package:kamelshop/logic/blocs/Order_bloc.dart';
import 'package:kamelshop/logic/blocs/category_bloc%20.dart';
import 'package:kamelshop/logic/blocs/product_bloc.dart';
import 'package:kamelshop/logic/blocs/search_bloc.dart';
import 'package:kamelshop/logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:kamelshop/logic/repository/auth_repository.dart';
import 'package:kamelshop/logic/repository/cart_api.dart';
import 'package:kamelshop/logic/repository/categories_api.dart';
import 'package:kamelshop/logic/repository/order_api.dart';
import 'package:kamelshop/logic/state/auth_state.dart';
import 'package:kamelshop/presentation/constants.dart';
import 'package:kamelshop/presentation/screens/sign_in/login.dart';
import 'package:kamelshop/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:kamelshop/presentation/screens/sign_up/register.dart';
import 'package:kamelshop/presentation/screens/splash/splash_screen.dart';
import 'package:kamelshop/simple_bloc_observer.dart';

import 'logic/blocs/Auth_bloc.dart';
import 'logic/repository/products_api.dart';

late String initialRoute;

void main() async {
  Bloc.observer = SimpleBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = '/login-screen';
    } else {
      initialRoute = '/mapScreen';
    }
  });
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PhoneAuthCubit(),
          ),
          BlocProvider(
            create: (context) => OrderBloc(OrderInitialState(), OrderAPI()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(CatInitialState1(), CategoriesAPI())
                  ..add(CatDoFetchEvent1()),
          ),
          // BlocProvider(
          //   create: (context) =>
          //       CategoryBloc(CatInitialState1(), CategoriesAPI()),
          // ),
          // BlocProvider(
          //   create: (context) =>
          //       CategoryBloc(CatProductsInitialState1(), CategoriesAPI()),
          // ),
          BlocProvider(
            create: (context) => ProductBloc(InitialState1(), ProductsAPI()),
          ),
          BlocProvider(
            create: (context) =>
                SearchBloc(SearchInitialState1(), ProductsAPI()),
          ),
          BlocProvider(
            create: (context) => CartBloc(CartInitialState(), CartAPI()),
          ),
          BlocProvider(
              create: (context) =>
                  AuthBloc(LoginInitState(), AuthRepository())),
        ],
        child: MaterialApp(
          onGenerateRoute: appRouter.generateRoute,

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
            primaryColor: kPrimaryColor,
            accentColor: kPrimaryColor,
          ),
          initialRoute: '/splash',
          // routes: {
          //   '/': (context) => Login(),
          //   '/signIn': (context) => SignInScreen(),
          //   '/splash': (context) => SplashScreen(),
          //   '/register': (context) => Register(),

          //                 '/orderDetails': (context) => OrderDetails(),

          //   '/order': (context) => Orders(),
          // '/card': (context) => CartItems(),
          // '/profile': (context) => Profile(),ProfileScreen
          // '/products': (context) => Products(),
          // '/singleproduct': (context) => SingleProduct(),
          // '/catalogue': (context) => Catalogue(),
          //'/home': (context) => HomePage(),
          // '/SearchProducts': (context) => SearchProducts(key),
          // }
        ));
  }
}
