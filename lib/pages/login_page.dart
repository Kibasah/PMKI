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

  void _goToRegisterPage(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RegisterPage()),
  );

  // Handle the result from the RegisterPage if needed
  if (result != null) {
    // Handle any result if necessary
    print('Result from RegisterPage: $result');
  }
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
    body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_image1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.0), // Add some space at the top
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.9,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Image.asset(
                        'assets/image_logo1.png',
                        height: 100,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 70.0),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
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
                    SizedBox(height: 9.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        errorText: _passwordErrorText,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () => _resetPassword(context),
                      child: Text('Forgot Password?'),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _signInWithEmailAndPassword(context),
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () => _goToRegisterPage(context),
                      child: Text('Register'),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
