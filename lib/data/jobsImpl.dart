import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/domain/messages.dart';
import 'package:foundlunteer/domain/organizationJob.dart';
import 'package:foundlunteer/domain/registeredJobs.dart';
import 'package:foundlunteer/domain/resultState.dart';
import 'package:http/http.dart' as http;

import 'package:foundlunteer/domain/jobHome.dart';

class GetJobProvider with ChangeNotifier {
  JobHome jobs = JobHome();
  ResultState stateJobs = ResultState.empty;

  JobHome jobsByFilter = JobHome();
  ResultState stateJobsByFilter = ResultState.empty;
  ResultState stateJobsByFilterId = ResultState.empty;

  JobHome jobsByOrganization = JobHome();
  ResultState stateJobsByOrganization = ResultState.empty;

  OrganizationJob organizationJobById = OrganizationJob();
  ResultState stateJobsById = ResultState.empty;

  RegisteredJobs registeredJobs = RegisteredJobs();
  ResultState stateRegisteredJobs = ResultState.empty;

  Messages messages = Messages();
  ResultState stateRegisterJob = ResultState.empty;
  ResultState stateUpdateStatusJob = ResultState.empty;
  ResultState stateUpdateJob = ResultState.empty;
  ResultState stateUpdateStatusRegistrantJob = ResultState.empty;
  ResultState stateDeleteJob = ResultState.empty;

// GET ALL JOB (UNTUK ORGANIZATION + INDIVIDUAL)
  Future<JobHome> getJobs(String? token, int? page) async {
    stateJobs = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse("${baseUrl}/job/getall?limit=100&page=1"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset-UTF-8',
            'Authorization': 'bearer ${token}'
          });
      if (response.statusCode == 200) {
        jobs = JobHome.fromJson(json.decode(response.body));
        stateJobs = ResultState.success;
        notifyListeners();
      } else {
        stateJobs = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateJobs = ResultState.serverError;
      notifyListeners();
    }

    return jobs;
  }

// GET ALL JOB MILIK ORGANIZATION YANG SEDANG LOGIN
  Future<JobHome> getJobsOrganization(String? token) async {
    stateJobsByOrganization = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse("${baseUrl}/organization/getjob"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset-UTF-8',
            'Authorization': 'bearer ${token}'
          });
      if (response.statusCode == 200) {
        jobsByOrganization = JobHome.fromJson(json.decode(response.body));
        stateJobsByOrganization = ResultState.success;
        notifyListeners();
      } else {
        stateJobsByOrganization = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateJobsByOrganization = ResultState.serverError;
      notifyListeners();
    }

    return jobsByOrganization;
  }

// GET JOB BERDASARKAN ID MILIK ORGANIZATION YANG SEDANG LOGIN
  Future<OrganizationJob> getJobOrganizationById(
      String? token, String id) async {
    stateJobsById = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse("${baseUrl}/organization/jobdetail/${id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset-UTF-8',
            'Authorization': 'bearer ${token}'
          });
      if (response.statusCode == 200) {
        organizationJobById =
            OrganizationJob.fromJson(json.decode(response.body));
        stateJobsById = ResultState.success;
        notifyListeners();
      } else {
        stateJobsById = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateJobsById = ResultState.serverError;
      notifyListeners();
    }

    return organizationJobById;
  }

  Future<JobHome> getJobsByFilter(
      {String? token,
      String? limit = "1000",
      String? page = "1",
      String? title = "",
      String? location = "",
      String? id = ""}) async {
    stateJobsByFilter = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse(
              "${baseUrl}/job/getall?limit=${limit}&page=${page}&title=${title}&location=${location}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset-UTF-8',
            'Authorization': 'bearer ${token}'
          });
      if (response.statusCode == 200) {
        jobsByFilter = JobHome.fromJson(json.decode(response.body));

        stateJobsByFilter = ResultState.success;

        notifyListeners();
      } else {
        stateJobsByFilter = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateJobsByFilter = ResultState.serverError;
      notifyListeners();
    }
    print(Uri.parse(
        "${baseUrl}/job/getall?limit=${limit}&page=${page}&title=&location=${location}"));
    print(stateJobsByFilter);
    return jobsByFilter;
  }

// GET ALL JOB BY FILTER (ORGANIZATION + INDIVIDUAL)
  Future<JobHome> getJobsByFilterById({String? token, String? id = ""}) async {
    stateJobsByFilterId = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse("${baseUrl}/job/getall?organization=${id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset-UTF-8',
            'Authorization': 'bearer ${token}'
          });
      if (response.statusCode == 200) {
        jobsByFilter = JobHome.fromJson(json.decode(response.body));

        stateJobsByFilterId = ResultState.success;

        notifyListeners();
      } else {
        stateJobsByFilterId = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateJobsByFilterId = ResultState.serverError;
      notifyListeners();
    }
    print(Uri.parse("${baseUrl}/job/getall?organization=${id}"));
    print(stateJobsByFilter);
    return jobsByFilter;
  }

// GET ALL REGISTERED JOB MILIK INDIVIDU YANG SEDANG LOGIN
  Future<RegisteredJobs> getRegisteredJobs(String? token) async {
    stateRegisteredJobs = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse("${baseUrl}/individual/registeredjob"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset-UTF-8',
            'Authorization': 'bearer ${token}'
          });
      if (response.statusCode == 200) {
        registeredJobs = RegisteredJobs.fromJson(json.decode(response.body));
        stateRegisteredJobs = ResultState.success;
        notifyListeners();
      } else {
        stateRegisteredJobs = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateRegisteredJobs = ResultState.serverError;
      notifyListeners();
    }

    return RegisteredJobs();
  }

// MENDAFTAR KE JOB YANG ADA (HANYA UNTUK INDIVIDU)
  Future<Messages> registJob(String? token, String id) async {
    stateRegisterJob = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.post(
          Uri.parse("${baseUrl}/individual/register/${id}"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'bearer ${token}'
          });
      if (response.statusCode == 200) {
        messages = Messages.fromJson(json.decode(response.body));
        stateRegisterJob = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(json.decode(response.body));
        stateRegisterJob = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateRegisterJob = ResultState.serverError;
      notifyListeners();
    }

    return messages;
  }

// UPDATE DAN INPUT DATA JOB (ORGANIZATION)
  Future<Messages> postPutJob(String? token, String? id, String title,
      String location, String expiredAt, String desc) async {
    stateUpdateJob = ResultState.loading;
    notifyListeners();
    try {
      var url = Uri.parse("${baseUrl}/job/update/${id}");
      if (id == "") {
        url = Uri.parse("${baseUrl}/job/add");
      }
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'bearer ${token}'
          },
          body: jsonEncode(<String, dynamic>{
            "title": title,
            "description": desc,
            "location": location,
            "expiredAt": expiredAt
          }));
      if (response.statusCode == 200) {
        messages = Messages.fromJson(json.decode(response.body));
        stateUpdateJob = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(json.decode(response.body));
        stateUpdateJob = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateUpdateJob = ResultState.serverError;
      notifyListeners();
    }

    return messages;
  }

  // UPDATE DATA JOB STATUS OPEN/CLOSE (ORGANIZATION)
  Future<Messages> putStatusJob(
      String? token, String? id, String status) async {
    stateUpdateStatusJob = ResultState.loading;
    notifyListeners();
    try {
      var url = Uri.parse("${baseUrl}/job/updatestatus/${id}");
      if (id == "") {
        url = Uri.parse("${baseUrl}/job/add");
      }
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'bearer ${token}'
          },
          body: jsonEncode(<String, dynamic>{
            "jobStatus": status,
          }));
      if (response.statusCode == 200) {
        messages = Messages.fromJson(json.decode(response.body));
        stateUpdateStatusJob = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(json.decode(response.body));
        stateUpdateStatusJob = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateUpdateStatusJob = ResultState.serverError;
      notifyListeners();
    }

    return messages;
  }

  // UPDATE DATA JOB STATUS OPEN/CLOSE (ORGANIZATION)
  Future<Messages> putStatusRegistrant(
      String? token, String? individuId, String? jobId, String status) async {
    stateUpdateStatusRegistrantJob = ResultState.loading;
    notifyListeners();
    try {
      var url = Uri.parse("${baseUrl}/organization/updateregistrant");

      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'bearer ${token}'
          },
          body: jsonEncode(<String, dynamic>{
            "individualId": individuId,
            "jobId": jobId,
            "registrantStatus": status
          }));
      if (response.statusCode == 200) {
        messages = Messages.fromJson(json.decode(response.body));
        stateUpdateStatusRegistrantJob = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(json.decode(response.body));
        stateUpdateStatusRegistrantJob = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateUpdateStatusRegistrantJob = ResultState.serverError;
      notifyListeners();
    }

    return messages;
  }

  Future<Messages> deleteJob(String? token, String? id) async {
    stateDeleteJob = ResultState.loading;
    notifyListeners();
    try {
      var url = Uri.parse("${baseUrl}/job/delete/${id}");

      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'bearer ${token}'
          },
          body: jsonEncode(<String, dynamic>{
            "jobId": id,
          }));
      if (response.statusCode == 200) {
        messages = Messages.fromJson(json.decode(response.body));
        stateDeleteJob = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(json.decode(response.body));
        stateDeleteJob = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateDeleteJob = ResultState.serverError;
      notifyListeners();
    }

    return messages;
  }
}
