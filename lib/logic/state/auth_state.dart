import 'package:equatable/equatable.dart';
import 'package:kamelshop/logic/models/data_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogoutState extends AuthState {}

class LoginInitState extends AuthState {}

class LoginLoadingState extends AuthState {}

class ProfilLoadingState extends AuthState {}

class UserLoginSuccessState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class UserRegisterSuccessState extends AuthState {}

class UserUpdateSuccessState extends AuthState {}

class LoadingState extends AuthState {}

class UpdateLoadingState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String message;
  RegisterErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class DisplayProfileState extends AuthState {
  User user;
  DisplayProfileState({required this.user});
}
