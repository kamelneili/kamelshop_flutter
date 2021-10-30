import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/blocs/Auth_bloc.dart';
import 'package:kamelshop/logic/event/auth_event.dart';
import 'package:kamelshop/logic/repository/auth_repository.dart';
import 'package:kamelshop/logic/state/auth_state.dart';
import 'package:kamelshop/presentation/constants.dart';
import 'package:kamelshop/presentation/screens/sign_up/register.dart';
//import 'package:newsapp/api/authentication_api.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  //AuthenticationAPI authenticationAPI = AuthenticationAPI();
  bool isLoading = false;

  bool loginError = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late AuthBloc authBloc;
  late AuthRepository repo;
  late String username;
  late Key btn1;
  late Key btn2;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('LOGIN'),
      ),
      body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoginLoadingState) {
              _drawLoading();
            } else if (state is UserLoginSuccessState) {
              Navigator.pushNamed(context, '/home');
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: (isLoading) ? _drawLoading() : _drawLoginForm(),
          ),
        ),
      ),
    );
  }

  Widget _drawLoginForm() {
    if (loginError) {
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Login Error'),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    loginError = false;
                  });
                },
                child: Text(
                  'try Again',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: email,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(
            height: 48,
          ),
          TextFormField(
            obscureText: true,
            controller: password,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 48,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                authBloc.add(LoginButtonPressed(
                    email: email.text, password: password.text));
              },
              child: Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Text("Don't have an account?"),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/register',
                );
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
