class UserModel {
  String? name;
  String? email;
  String? password;
  String? userRole;
  String? imageUrl;
  String? address;
  bool? isNotificationsEnabled;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.userRole,
    this.imageUrl,
    this.address,
    this.isNotificationsEnabled,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userRole = json['userRole'];
    imageUrl = json['imageUrl'];
    address = json['address'];
    isNotificationsEnabled = json['isNotificationsEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['userRole'] = userRole;
    data['imageUrl'] = imageUrl;
    data['address'] = address;
    data['isNotificationsEnabled'] = isNotificationsEnabled;
    return data;
  }
}
