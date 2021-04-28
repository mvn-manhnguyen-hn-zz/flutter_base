class UserJson {
  String email;
  String name;
  String licensePlate;
  String password;
  String numberPhone;
  String id;

  UserJson(
      {this.email,
        this.name,
        this.licensePlate,
        this.password,
        this.numberPhone,
        this.id});

  UserJson.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    licensePlate = json['licensePlate'];
    password = json['password'];
    numberPhone = json['numberPhone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['licensePlate'] = this.licensePlate;
    data['password'] = this.password;
    data['numberPhone'] = this.numberPhone;
    data['id'] = this.id;
    return data;
  }
}
