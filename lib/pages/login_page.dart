// ignore_for_file: avoid_print, library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmki/auth_service.dart';
import 'package:pmki/pages/home_page.dart';
import 'package:pmki/pages/register_page.dart';
import 'package:pmki/pages/reset_password.dart'; // Import your AuthService

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: Text('Reset Password Page'), // Customize this page as needed
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailErrorText; // Changed from empty string to null
  String? _passwordErrorText; // Changed from empty string to null

  void _signInWithEmailAndPassword(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential? userCredential =
            await _authService.signInWithEmailAndPassword(email, password);
        if (userCredential != null) {
          // Navigate to the home page after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          // Handle login failure
          setState(() {
            _emailErrorText = '';
            _passwordErrorText = 'Login Failed. Please check your credentials.';
          });
        }
      } catch (e) {
        // Handle login error and show error message
        setState(() {
          _emailErrorText = '';
          _passwordErrorText = 'Error: $e';
        });
      }
    } else {
      // Handle empty email or password fields
      setState(() {
        _emailErrorText = email.isEmpty ? 'Please enter email' : null;
        _passwordErrorText = password.isEmpty ? 'Please enter password' : null;
      });
    }
  }

  void _goToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void _resetPassword(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
  );
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Login'),
    ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_image1.jpg'), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15.0),
              
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/image_logo1.png', // Replace with your image path
                      height: 200, // Set the height as needed
                      width: 200, // Set the width as needed
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 150.0), // Space between the image and email field
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0), // Add padding top to the email field
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      errorText: _emailErrorText,
                    ),
                  ),
                ),
                // Remaining code remains the same...
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    errorText: _passwordErrorText,
                  ),
                ),
                SizedBox(height: 10.0), // Space between Login and Forgot Password
                TextButton(
                  onPressed: () => _resetPassword(context),
                  child: Text('Forgot Password?'),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => _signInWithEmailAndPassword(context),
                  child: Text('Login'),
                ),
                SizedBox(height: 10.0), // Add space between Login and Register text
                TextButton(
                  onPressed: () => _goToRegisterPage(context),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

}
