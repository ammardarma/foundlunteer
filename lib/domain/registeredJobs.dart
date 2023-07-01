import 'jobHome.dart';

class RegisteredJobs {
  List<Registered>? registered;

  RegisteredJobs({this.registered});

  RegisteredJobs.fromJson(Map<String, dynamic> json) {
    if (json['registered'] != null) {
      registered = <Registered>[];
      json['registered'].forEach((v) {
        registered!.add(new Registered.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.registered != null) {
      data['registered'] = this.registered!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Registered {
  String? registrationStatus;
  Jobs? job;

  Registered({this.registrationStatus, this.job});

  Registered.fromJson(Map<String, dynamic> json) {
    registrationStatus = json['registrationStatus'];
    job = json['job'] != null ? new Jobs.fromJson(json['job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrationStatus'] = this.registrationStatus;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    return data;
  }
}
