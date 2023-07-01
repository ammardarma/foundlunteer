import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/domain/opening.dart';
import 'package:foundlunteer/domain/resultState.dart';
import 'package:foundlunteer/domain/users.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constant/widget_lib.dart';
import '../domain/messages.dart';

Messages account = Messages();

Future<Messages> createAccount(String email, String password, String nama,
    String alamat, String no_hp, String role) async {
  try {
    final response = await http.post(Uri.parse("${baseUrl}/user/add"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'name': nama,
          'address': alamat,
          'phone': no_hp,
          'role': role
        }));
    print(response.body);
    account = Messages.fromJson(jsonDecode(response.body));
  } catch (e) {
    log(e.toString());
    account = Messages.fromJson({"message": "Maaf, Server Sedang Gangguan"});
  }
  return account;
}

class GetDataProvider with ChangeNotifier {
  LoginAccount loginAccount = LoginAccount();

  ResultState state = ResultState.empty;

  getMyToken(String email, String password) async {
    state = ResultState.loading;
    loginAccount = await getTokenHttp(email, password);
    notifyListeners();
  }

  Future<LoginAccount> getTokenHttp(String email, String password) async {
    state = ResultState.loading;
    try {
      final response = await http.post(Uri.parse("${baseUrl}/user/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"email": email, "password": password}));

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        loginAccount = LoginAccount.fromJson(item);
        state = ResultState.success;
      } else {
        state = ResultState.failed;
      }
    } catch (e) {
      log(e.toString());
      state = ResultState.serverError;
    }

    return loginAccount;
  }
}
