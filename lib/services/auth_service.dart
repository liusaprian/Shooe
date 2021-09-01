import 'dart:convert';
import 'package:shooe/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';

  Future<UserModel> register({
    String name,
    String username,
    String email,
    String password
  }) async {
    var url = '$baseUrl/register';
    var header = {
      'Content-type': 'application/json'
    };
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(url, headers: header, body: body);

    print(response.body);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.accessToken = 'Bearer ${data['access_token']}';

      return user;
    }
    else throw Exception('Register failed');
  }

  Future<UserModel> login({
    String email,
    String password
  }) async {
    var url = '$baseUrl/login';
    var header = {
      'Content-type': 'application/json'
    };
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(url, headers: header, body: body);

    print("body: " + response.body);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.accessToken = 'Bearer ${data['access_token']}';

      return user;
    }
    else throw Exception('Login failed');
  }
}