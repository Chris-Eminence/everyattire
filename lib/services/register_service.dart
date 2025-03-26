import 'dart:convert';
import 'package:everyattire/constants/api_urls.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';


class UserService {

  Future registerUser( User user,
  ) async {
    final url = Uri.parse(ApiUrls.usersApiUrl);
    final body = {
      'email': user.name,
      'username': user.email,
      'password': user.password,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User registered Successfully with status code of ${response.statusCode}");
        final data = jsonDecode(response.body);
        if (data['message'] == 'User registration successful') {
          print("Successful user ${response.body}");
          return User.fromJson(data['user']);
        }
      } else {
        print('Failed to register user: with status code ${response.statusCode} and body of  ${response.body}');
      }
    } catch (e) {
      print('Error during user registration: $e');
    }
    return null;
  }
}