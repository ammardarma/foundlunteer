class OrganizationJob {
  String? id;
  String? title;
  String? description;
  String? location;
  String? jobStatus;
  String? organizationId;
  String? createdAt;
  String? expiredAt;
  List<Registrant>? registrant;

  OrganizationJob(
      {this.id,
      this.title,
      this.description,
      this.location,
      this.jobStatus,
      this.organizationId,
      this.createdAt,
      this.expiredAt,
      this.registrant});

  OrganizationJob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    jobStatus = json['jobStatus'];
    organizationId = json['organizationId'];
    createdAt = json['createdAt'];
    expiredAt = json['expiredAt'];
    if (json['registrant'] != null) {
      registrant = <Registrant>[];
      json['registrant'].forEach((v) {
        registrant!.add(new Registrant.fromJson(v));
      });
    }
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
    if (this.registrant != null) {
      data['registrant'] = this.registrant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Registrant {
  String? registrationStatus;
  Individual? individual;
  String? image;

  Registrant({this.registrationStatus, this.individual, this.image});

  Registrant.fromJson(Map<String, dynamic> json) {
    registrationStatus = json['registrationStatus'];
    individual = json['individual'] != null
        ? new Individual.fromJson(json['individual'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrationStatus'] = this.registrationStatus;
    if (this.individual != null) {
      data['individual'] = this.individual!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Individual {
  String? id;
  User? user;
  String? birthOfDate;
  String? description;
  String? social;

  Individual(
      {this.id, this.user, this.birthOfDate, this.description, this.social});

  Individual.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    birthOfDate = json['birthOfDate'];
    description = json['description'];
    social = json['social'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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
