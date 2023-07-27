import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foundlunteer/domain/file.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/domain/resultState.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../domain/messages.dart';
import '../domain/users.dart';

class GetUserProvider with ChangeNotifier {
  Users users = Users();
  ResultState state = ResultState.empty;
  ResultState statePutUsers = ResultState.empty;
  ResultState stateChangePassword = ResultState.empty;

  Files files = Files();
  Uint8List image = Uint8List(1000);
  ResultState stateFiles = ResultState.empty;
  ResultState stateFilesCV = ResultState.empty;
  ResultState stateFilesIjazah = ResultState.empty;
  ResultState stateFilesSertif = ResultState.empty;
  ResultState stateProfileImage = ResultState.empty;
  ResultState stateGetFileById = ResultState.empty;

  Messages messages = Messages();

  Future<Users> getMyUsers(String? token) async {
    state = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse("${baseUrl}/user/get"),
          headers: headers(token!));
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
    statePutUsers = ResultState.loading;
    notifyListeners();
    try {
      final response =
          await http.post(Uri.parse("${baseUrl}/individual/update"),
              headers: headers(token),
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

  Future<Messages> changePassword(String token, String password) async {
    stateChangePassword = ResultState.loading;
    notifyListeners();
    try {
      final response = await http.post(
          Uri.parse("${baseUrl}/user/changepassword"),
          headers: headers(token),
          body: jsonEncode(<String, dynamic>{"password": password}));
      if (response.statusCode == 200) {
        messages = Messages.fromJson(json.decode(response.body));
        stateChangePassword = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(json.decode(response.body));
        stateChangePassword = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateChangePassword = ResultState.serverError;
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
      final response =
          await http.post(Uri.parse("${baseUrl}/organization/update"),
              headers: headers(token),
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
          headers: headers(token!));
      if (response.statusCode == 200) {
        files = Files.fromJson(json.decode(response.body));
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

  Future<Messages> postProfileImage(String token, File image) async {
    stateProfileImage = ResultState.loading;
    log(image.path);
    notifyListeners();
    try {
      var fileName = image.path.split('/').last;

      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path,
            filename: fileName, contentType: MediaType('image', 'png')),
      });

      var response = await Dio().post("${baseUrl}/user/image",
          options: Options(
              contentType: 'multipart/form-data',
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}),
          data: formData);

      print(image.path);
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        messages = Messages.fromJson(response.data);
        stateProfileImage = ResultState.success;
        notifyListeners();
      } else {
        messages = Messages.fromJson(response.data);
        stateProfileImage = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateProfileImage = ResultState.serverError;
      notifyListeners();
    }
    return messages;
  }

  Future<File?> getPDF(String token, String id, String type) async {
    Completer<File> completer = Completer();
    stateGetFileById = ResultState.loading;
    print(Uri.parse("${baseUrl}/user/get${type}/${id}"));
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse("${baseUrl}/user/get${type}/${id}"),
          headers: headers(token));
      if (response.statusCode == 200) {
        final Directory? appDir = Platform.isAndroid
            ? await getExternalStorageDirectory()
            : await getApplicationDocumentsDirectory();
        String tempPath = appDir!.path;
        final String fileName =
            DateTime.now().microsecondsSinceEpoch.toString() +
                '-' +
                '${type}.pdf';
        File file = new File('$tempPath/$fileName');

        await file.writeAsBytes(response.bodyBytes, flush: true);
        completer.complete(file);
        stateGetFileById = ResultState.success;
        notifyListeners();
      } else {
        print(response.body);
        stateGetFileById = ResultState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      stateGetFileById = ResultState.serverError;
      notifyListeners();
    }
    print(stateGetFileById);
    return completer.future;
  }
}
