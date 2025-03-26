import 'package:everyattire/bottom_nav.dart';
import 'package:everyattire/providers/auth_provider.dart';
import 'package:everyattire/screens/authentication_screen/login_screen.dart';
import 'package:everyattire/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../model/user_model.dart';
import '../homepage.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
              child: Text("Register \n👚👕👢👗👜👟👞🥻👠👡👔👝👛", style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 40),),
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
                        'Welcome to 🥰',
                  
                        style: GoogleFonts.spaceGrotesk(color: kPrimaryColor, fontSize: 14),
                      ),
                      Text(
                        'Every Attire',
                        style: GoogleFonts.zenDots(color: kPrimaryColor, fontSize: 24),
                      ),
                      Text(
                        'Universe of Every Attire ',
                        style: GoogleFonts.spaceGrotesk(color: kPrimaryColor, fontSize: 16),
                      ),
                  
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'John Doe',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: 'Enter your name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                  
                      // Username TextField
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'email@example.com',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                  
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
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
                        isLoading: authProvider.isLoading,
                        buttonTextColor: Colors.white,
                        onPressed: () async {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
                          // if (_formKey.currentState!.validate()) {
                          //   await  authProvider.registerUserProvider(
                          //     User(
                          //       name: _nameController.text.trim(),
                          //       email: _emailController.text.trim(),
                          //       password: _passwordController.text.trim(),
                          //     ),
                          //   );
                          //
                          //   print("THIS IS THE ID FROM THE SCREEN: ${authProvider.regStatusCode}");
                          //
                          //   if (authProvider.regStatusCode == 200 ||
                          //       authProvider.regStatusCode == 201) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text('Registration Successful'),
                          //       ),
                          //     );
                          //     Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => const LoginScreen(),
                          //       ),
                          //     );
                          //   }
                          //   else {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text('AN ERROR OCCURRED'),
                          //
                          //       ),
                          //
                          //     );
                          //     authProvider.isLoading;
                          //   }
                          // }
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

