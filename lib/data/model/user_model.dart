class UserModel {
  String? name;
  String? email;
  String? password;
  String? userRole;

  UserModel({this.name, this.email, this.password, this.userRole});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['userRole'] = userRole;
    return data;
  }
}
