import 'dart:convert';
import 'dart:io';

// http
import 'package:http/http.dart' as http;
import 'package:everyattire/constants/api_urls.dart';
import 'package:everyattire/model/user_model.dart';
import 'package:flutter/foundation.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  int? regStatusCode;
  int? loginStatusCode;
  int? id;
  String? userToken;

  Future<void> registerUserProvider(User user) async {
    _isLoading = true;
    notifyListeners();


    try {
      final url = Uri.parse(ApiUrls.usersApiUrl);
      final body = {
        'email': user.email,
        'username': user.name,
        'password': user.password,
      };

      print("Sending Registration request with body: ${jsonEncode(body)}");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      regStatusCode = response.statusCode;
      print("printing the initial statusCode");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
          "User registered Successfully with status code of ${response.statusCode}",
        );
        final data = jsonDecode(response.body);
        id = data['id'];
        print("this is the id from provider: $id");
        if (id != 0 || id != null) {
          print("Successful user ${response.body}");
        }
      } else {
        print(
          'Failed to register user: with status code ${response.statusCode} and body of  ${response.body}',
        );
      }
    } catch (e) {
      print('Error during user registration: $e');
    }
  }

  // LOGIN PROVIDER METHOD

  Future<void> loginUserProvider({required String username, required String password}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ApiUrls.loginApiUrl);

      // Explicitly format the JSON correctly
      final Map<String, dynamic> body = {
        'username': username,  // Ensure API expects 'username', not 'email'
        'password': password,
      };

      print("Sending login request with body: ${jsonEncode(body)}");


      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),  // Ensure the body is properly encoded
      );

      loginStatusCode = response.statusCode;

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User logged in successfully with status code: ${response.statusCode}");
        final data = jsonDecode(response.body);
        userToken = data['token'];
        print("This is the USER TOKEN from provider: $userToken");
      } else {
        print('Failed to login user: status ${response.statusCode}, body ${response.body}');
      }
    } catch (e) {
      print('Error during user login: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

}
