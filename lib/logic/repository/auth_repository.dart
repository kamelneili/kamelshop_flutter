import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kamelshop/logic/models/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future register(
      String phone, String name, String email, String password) async {
    String baseUrl = '192.168.1.20';
    String register = 'flutter2/kamelshopapi/public/api/register';

    Uri uri = Uri.http(baseUrl, '$register');
    var res = await http.post(uri, headers: {
      "Accept": "application/json"
    }, body: {
      "phone": phone,
      "name": name,
      "email": email,
      "password": password,
    });
    //print(res);
    final data = json.decode(res.body);
    //return data;
    // print(data);
    // print (data['data']['access_token']);
    //if (data["success"] == 1) {
    //User user = User.fromJson(data);
    // await _saveUserId(user.id);
    return data;
    // } else {
    //   return "auth problem";
  }
  //update user data

  Future update(String token, String phone, String name, String email) async {
    String baseUrl = '192.168.1.20';
    String register = 'flutter2/kamelshopapi/public/api/update';

    Uri uri = Uri.http(baseUrl, '$register');
    var res = await http.post(uri, headers: {
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    }, body: {
      "phone": phone,
      "name": name,
      "email": email,
      //  "password": password,
    });
    //print(res);
    final data = json.decode(res.body);
    //return data;
    print(data);
    // print (data['data']['access_token']);
    //if (data["success"] == 1) {
    //User user = User.fromJson(data);
    // await _saveUserId(user.id);
    return data;
    // } else {
    //   return "auth problem";
  }

  //

  Future login(String email, String password) async {
    String baseUrl = '192.168.1.20';
    String login = 'flutter2/kamelshopapi/public/api/login';

    Uri uri = Uri.http(baseUrl, '$login');
    var res = await http.post(uri, headers: {
      "Accept": "application/json"
    }, body: {
      "email": email,
      "password": password,
    });
    print(res);
    print(res.statusCode);

    final data = json.decode(res.body);
    //print(data);
    //
    if (res.statusCode == 200) {
      var jsonObject = json.decode(res.body);
      if (jsonObject["token"] != null) {
        String token = jsonObject["token"];
        // print(token);
      }
    }
    //return data;
    print(data);
    // print(data['token']);
    if (data["message"] == 'success') {
      print(data["message"]);
      //User user = User.fromJson(data);
      // await _saveUserId(user.id);
      return data;
      //
      //
      //

      //
    } else {
      return "auth problem";
    }
  }

  Future _saveUserId(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //final SharedPreferences local = await _pref;

    pref.setInt('id', id);
  }

  Future userLogout(String token) async {
    Uri baseUrl = "http://192.168.1.20:8000/api/logout" as Uri;

    try {
      var response = await http.post(baseUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'applcation/json'
      });

      var resbody = json.decode(response.body);
      return Logout.fromJson(resbody);
    } catch (e) {
      return e;
    }
  }

  Future getData(String token) async {
    //String baseUrl = "http://192.168.1.20:8000/api/user";

    String baseUrl = '192.168.1.20';
    String login = 'flutter2/kamelshopapi/public/api/user';

    Uri uri = Uri.http(baseUrl, '$login');

    try {
      var response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'applcation/json'
      });

      var body = json.decode(response.body);
      print(body);
      User user =
          User.fromJson(body); //final SharedPreferences local = await _pref;
      print(user);

      return user;
    } catch (e) {
      return e;
    }
  }

  Future hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String? token = local.getString("token");
    if (token != null) return token;
    return null;
  }

  Future setLocalToken(String token) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token", token);
  }

  Future unsetLocalToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //final SharedPreferences local = await pref;
    //!pref.setString("token", null);
  }
}
