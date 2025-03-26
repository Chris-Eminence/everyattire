import 'package:everyattire/screens/homepage.dart';
import 'package:everyattire/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../model/user_model.dart';
import '../../providers/auth_provider.dart' show AuthenticationProvider;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Login \n👚👕👢👗👜👟👞🥻👠👡👔👝👛",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),

            SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back to 🥰',

                        style: GoogleFonts.spaceGrotesk(
                          color: kPrimaryColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Every Attire',
                        style: GoogleFonts.zenDots(
                          color: kPrimaryColor,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'Universe of Every Attire ',
                        style: GoogleFonts.spaceGrotesk(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 20),

                      // Username TextField
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'John Doe',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),

                          hintText: 'Enter your user name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your user name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Password TextField
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),

                          hintText: 'Enter your password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),

                      // Submit Button
                      AppButton(
                        formKey: _formKey,
                        textColor: Colors.white,
                        buttonColor: kPrimaryColor,
                        buttonText: 'Register',
                        width: double.infinity,
                        buttonTextColor: Colors.white,
                        onPressed: () async{
                          print("Username input: '${_nameController.text.trim()}', Password input: '${_passwordController.text.trim()}'");

                          if (_formKey.currentState!.validate()) {
                            await authProvider.loginUserProvider(
                              username: _nameController.text.trim(), password: _passwordController.text.trim(),
                            );

                            if (authProvider.loginStatusCode == 200 ||
                                authProvider.loginStatusCode == 201) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login successful'),
                                ),
                              );
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Homepage(),
                              //   ),
                              // );
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('An error occurred'),
                                ),
                              );
                              authProvider.isLoading;
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Name TextField
          ],
        ),
      ),
    );
  }
}
