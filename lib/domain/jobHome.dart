class JobHome {
  List<Jobs>? jobs;

  JobHome({this.jobs});

  JobHome.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  String? id;
  String? title;
  String? description;
  String? location;
  String? jobStatus;
  String? organizationId;
  String? createdAt;
  String? expiredAt;
  Organization? organization;
  String? image;

  Jobs(
      {this.id,
      this.title,
      this.description,
      this.location,
      this.jobStatus,
      this.organizationId,
      this.createdAt,
      this.expiredAt,
      this.organization,
      this.image});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    jobStatus = json['jobStatus'];
    organizationId = json['organizationId'];
    createdAt = json['createdAt'];
    expiredAt = json['expiredAt'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['location'] = this.location;
    data['jobStatus'] = this.jobStatus;
    data['organizationId'] = this.organizationId;
    data['createdAt'] = this.createdAt;
    data['expiredAt'] = this.expiredAt;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Organization {
  User? user;
  String? leader;
  String? description;
  String? social;

  Organization({this.user, this.leader, this.description, this.social});

  Organization.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    leader = json['leader'];
    description = json['description'];
    social = json['social'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['leader'] = this.leader;
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
