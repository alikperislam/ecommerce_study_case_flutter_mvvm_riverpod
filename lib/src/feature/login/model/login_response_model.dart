class LoginResponseModel {
  ActionLogin? actionLogin;
  LoginResponseModel({this.actionLogin});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    actionLogin = json['action_login'] != null
        ? ActionLogin.fromJson(json['action_login'])
        : null;
  }
}

class ActionLogin {
  String? token;
  ActionLogin({this.token});

  ActionLogin.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
