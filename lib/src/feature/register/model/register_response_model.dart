class RegisterResponseModel {
  ActionRegister? actionRegister;
  RegisterResponseModel({this.actionRegister});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    actionRegister = json['action_register'] != null
        ? ActionRegister.fromJson(json['action_register'])
        : null;
  }
}

class ActionRegister {
  String? token;
  ActionRegister({this.token});

  ActionRegister.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
