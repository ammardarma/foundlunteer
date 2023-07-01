class Users {
  User? user;
  String? birthOfDate;
  String? leader;
  String? description;
  String? social;

  Users({this.user, this.birthOfDate, this.description, this.social});

  Users.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    leader = json['leader'];
    birthOfDate = json['birthOfDate'];
    description = json['description'];
    social = json['social'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['leader'] = this.leader;
    data['birthOfDate'] = this.birthOfDate;
    data['description'] = this.description;
    data['social'] = this.social;
    return data;
  }
}

class User {
  String? email;
  String? name;
  String? address;
  String? phone;
  String? role;

  User({this.email, this.name, this.address, this.phone, this.role});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['role'] = this.role;
    return data;
  }
}
