class LoginAuth {
  String? message;
  TokenAuth? data;

  LoginAuth({required this.message, required this.data});
  LoginAuth.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = TokenAuth.fromJson(json['data']);
  }
}

class TokenAuth {
  String? token;
  TokenAuth({required this.token});

  TokenAuth.fromJson(Map<String, dynamic> data) {
    token = data['token'];
  }
}

class User {
  String? first_name;
  String? email;
  int id = 1;
  String? mobile;
  User(
      {required this.first_name,
      required this.email,
      required this.id,
      required this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      first_name = json['data']['first_name'];
      id = json['data']['id'];
      mobile = json['data']['mobile'];
      print(mobile);
      email = json['data']['email'];
    } else {
      first_name = "";
      email = "";
    }
  }
}

class Logout {
  String? message;

  Logout({this.message});

  Logout.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
