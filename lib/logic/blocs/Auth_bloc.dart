import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/event/auth_event.dart';
import 'package:kamelshop/logic/models/data_model.dart';
import 'package:kamelshop/logic/repository/auth_repository.dart';
import 'package:kamelshop/logic/state/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepository repo;

  @override
  //AuthState get initialState => LoginInitState();
  AuthBloc(AuthState initialState, this.repo) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
    var pref = await SharedPreferences.getInstance();
    if (event is StartEvent) {
      yield LoginInitState();
    } else if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      var data = await repo.login(event.email, event.password);
      if (data['message'] == "success") {
        var token = data['token'];

        //print(token);
        // User user = await repo.getData(data['user']);
        SharedPreferences pref = await SharedPreferences.getInstance();
        //final SharedPreferences local = await _prefs;
        //User user = data['token'];
        //pref.setInt('id', user.id);
        //int? userId = pref.getInt('id');
        // print(userId);
        // final user = await repo.getData(access_token);
        // print(user);
        pref.setString("token", data['token']);
        // pref.setInt("type",data['type']);

        pref.setString("email", data['email']);
        pref.setString("first_name", data['first_name']);
        pref.setString("mobile", data['mobile']);

        yield UserLoginSuccessState();
      } else
        yield LoginErrorState("auth error");
    } else if (event is RegisterButtonPressed) {
      yield RegisterLoadingState();
      var data = await repo.register(
          event.phone, event.name, event.email, event.password);
      // print(data);

      //  var token = data['data']['access_token'];

      //print(token);
      // User user = await repo.getData(data['data']['access_token']);
      SharedPreferences pref = await SharedPreferences.getInstance();
      //final SharedPreferences local = await _prefs;

      // pref.setInt('id', user.id);
      // int? userId = pref.getInt('id');
      // print(userId);
      // print(user);
      print(data['token']);
      //pref.setString("token", data['token']);
      // pref.setInt("type",data['type']);

      // pref.setString("email",data['email']);
      yield UserRegisterSuccessState();
    }
    //update
    else if (event is UpdateButtonPressed) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");
      // yield UpdateLoadingState();
      var data =
          await repo.update(token!, event.phone, event.name, event.email);
      // print(data);

      //  var token = data['data']['access_token'];

      //print(token);
      // User user = await repo.getData(data['data']['access_token']);
      //final SharedPreferences local = await _prefs;

      // pref.setInt('id', user.id);
      // int userId = pref.getInt('id');
      // print(userId);
      // print(user);
      //   pref.setString("token",data['data']['access_token']);
      // pref.setInt("type",data['type']);

      // pref.setString("email",data['email']);
      yield UserUpdateSuccessState();
    }

    //
    //profil
    else if (event is DisplayProfileEvent) {
      yield LoadingState();
      final user = await repo.getData(pref.getString("token")!);
      // print(user.name);
      // print(user.email);

      yield DisplayProfileState(user: user);
    } else if (event is LogoutEvent) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");

      repo.unsetLocalToken(token!);

      yield LogoutState();
    }
  }
}
