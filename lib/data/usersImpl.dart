import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:foundlunteer/domain/file.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/domain/resultState.dart';
import 'package:http/http.dart' as http;

import '../domain/messages.dart';
import '../domain/users.dart';

class GetUserProvider with ChangeNotifier {
  Users users = Users();
  ResultState state = ResultState.empty;
  ResultState statePutUsers = ResultState.empty;

  Files files = Files();
  ResultState stateFiles = ResultState.empty;
  ResultState stateFilesCV = ResultState.empty;
  ResultState stateFilesIjazah = ResultState.empty;
  ResultState stateFilesSertif = ResultState.empty;
  Messages messages = Messages();

  Future<Users> getMyUsers(String? token) async {
    state = ResultState.loading;
    notifyListeners();
    try {
      final response = await http
          .get(Uri.parse("${baseUrl}/user/get"), headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'bearer ${token}'
      });
      if (response.statusCode == 200) {
        users = Users.fromJson(json.decode(response.body));
        state = ResultState.success;
        notifyListeners();
      } else {
        state = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      print(e.toString());
      state = ResultState.serverError;
      notifyListeners();
    }
    return users;
  }

  Future<Messages> putUsers(String token, String name, String address,
      String phone, String age, String desc, String social) async {
    state = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.post(
          Uri.parse("${baseUrl}/individual/update"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'bearer ${token}'
          },
          body: jsonEncode(<String, dynamic>{
            "name": name,
            "address": address,
            "phone": phone,
            "birthOfDate": age,
            "description": desc,
            "social": social
          }));
      if (response.statusCode == 200) {
        messages = Messages.fromJson(json.decode(response.body));
        statePutUsers = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(json.decode(response.body));
        statePutUsers = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      statePutUsers = ResultState.serverError;
      notifyListeners();
    }

    return messages;
  }

  Future<Messages> putUsersOrganization(
      String token,
      String name,
      String address,
      String phone,
      String leader,
      String desc,
      String social) async {
    statePutUsers = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.post(
          Uri.parse("${baseUrl}/organization/update"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'bearer ${token}'
          },
          body: jsonEncode(<String, dynamic>{
            "name": name,
            "address": address,
            "phone": phone,
            "leader": leader,
            "description": desc,
            "social": social,
          }));
      if (response.statusCode == 200) {
        messages = Messages.fromJson(json.decode(response.body));
        statePutUsers = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(json.decode(response.body));
        state = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      statePutUsers = ResultState.serverError;
      notifyListeners();
    }

    return messages;
  }

  Future<Messages> postFileCV(String token, File cvPath) async {
    stateFilesCV = ResultState.loading;
    notifyListeners();
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'bearer ${token}'
      };
      var fileName = cvPath.path.split('/').last;

      var formData = FormData.fromMap({
        'cv': await MultipartFile.fromFile(cvPath.path,
            filename: fileName, contentType: MediaType('application', 'pdf')),
      });

      var response = await Dio().post("${baseUrl}/individual/file",
          options: Options(
              contentType: 'multipart/form-data',
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}),
          data: formData);
      print(cvPath);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        messages = Messages.fromJson(response.data);
        stateFilesCV = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(response.data);
        stateFilesCV = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateFilesCV = ResultState.serverError;
      notifyListeners();
    }
    return messages;
  }

  Future<Messages> postFileIjazah(String token, File cvPath) async {
    stateFilesIjazah = ResultState.loading;
    notifyListeners();
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'bearer ${token}'
      };
      var fileName = cvPath.path.split('/').last;

      var formData = FormData.fromMap({
        'ijazah': await MultipartFile.fromFile(cvPath.path,
            filename: fileName, contentType: MediaType('application', 'pdf')),
      });

      var response = await Dio().post("${baseUrl}/individual/file",
          options: Options(
              contentType: 'multipart/form-data',
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}),
          data: formData);
      print(cvPath);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        messages = Messages.fromJson(response.data);
        stateFilesIjazah = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(response.data);
        stateFilesIjazah = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateFilesIjazah = ResultState.serverError;
      notifyListeners();
    }
    return messages;
  }

  Future<Messages> postFileSertifikat(String token, File cvPath) async {
    stateFilesSertif = ResultState.loading;
    notifyListeners();
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'bearer ${token}'
      };
      var fileName = cvPath.path.split('/').last;

      var formData = FormData.fromMap({
        'sertifikat': await MultipartFile.fromFile(cvPath.path,
            filename: fileName, contentType: MediaType('application', 'pdf')),
      });

      var response = await Dio().post("${baseUrl}/individual/file",
          options: Options(
              contentType: 'multipart/form-data',
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}),
          data: formData);
      print(cvPath);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        messages = Messages.fromJson(response.data);
        stateFilesSertif = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(response.data);
        stateFilesSertif = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateFilesSertif = ResultState.serverError;
      notifyListeners();
    }
    return messages;
  }

  Future<Files> getMyFile(String? token) async {
    stateFiles = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse("${baseUrl}/individual/filestatus"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset-UTF-8',
            'Authorization': 'bearer ${token}'
          });
      if (response.statusCode == 200) {
        files = Files.fromJson(json.decode(response.body));
        print(json.decode(response.body));
        stateFiles = ResultState.success;
        notifyListeners();
      } else {
        stateFiles = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      print(e.toString());
      stateFiles = ResultState.serverError;
      notifyListeners();
    }
    print(state);
    return files;
  }
}
