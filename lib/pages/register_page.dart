// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmki/auth_service.dart'; // Import your AuthService
import 'package:pmki/pages/home_page.dart'; // Import your home page widget
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:image_picker/image_picker.dart'; // Import ImagePicker

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  File? _imageFile;

  void _registerWithEmailAndPassword() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String name = _nameController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential? userCredential =
            await _authService.signUpWithEmailAndPassword(email, password);
        if (userCredential != null) {
          String uid = userCredential.user!.uid; // Get the user's UID

          // Save additional user data to Cloud Firestore including the UID
          await _firestore.collection('users').doc(uid).set({
            'uid': uid, // Store the UID
            'name': name,
            'phoneNumber': phoneNumber,
          });

          if (_imageFile != null) {
            // Upload image to Firebase Storage
            Reference ref = _storage.ref().child('profile_images').child('$uid.jpg');
            await ref.putFile(_imageFile!);
            String imageUrl = await ref.getDownloadURL();

            // Update user data in Firestore with the image URL
            await _firestore.collection('users').doc(uid).update({
              'profileImageUrl': imageUrl,
            });
          }

          // Registration successful, navigate to home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } catch (e) {
        // Handle registration failure
        print('Registration Failed: $e');
      }
    } else {
      // Handle empty email or password fields
      print('Please enter email and password');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  // FocusNodes for text fields
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // Validators for text fields
  String? _validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

String? _validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  return null;
}

String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  } else if (!value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}

String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  } else if (value.length < 6) {
    return 'Password should be at least 6 characters';
  }
  return null;
}
String? _nameErrorText;
String? _phoneErrorText;
String? _emailErrorText;
String? _passwordErrorText;
String? _imageErrorText;

void _validateFields() {
  setState(() {
    _nameErrorText = _validateName(_nameController.text);
    _phoneErrorText = _validatePhoneNumber(_phoneNumberController.text);
    _emailErrorText = _validateEmail(_emailController.text);
    _passwordErrorText = _validatePassword(_passwordController.text);
  });
}

void _validateImage() {
  setState(() {
    _imageErrorText = _imageFile == null ? 'Please upload an image' : null;
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Register'),
    ),
    body: GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside the text field
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_imageFile != null) ...[
                      Image.file(
                        File(_imageFile!.path),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20.0),
                    ],
                    TextFormField(
                      focusNode: _nameFocus,
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        errorText: _nameErrorText,
                      ),
                      onChanged: (_) {
                        _validateFields();
                      },
                    ),
                    SizedBox(height: 20.0),
                  TextFormField(
                    focusNode: _phoneNumberFocus,
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      errorText: _phoneErrorText,
                    ),
                    onChanged: (_) {
                      _validateFields();
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    focusNode: _emailFocus,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      errorText: _emailErrorText,
                    ),
                    onChanged: (_) {
                      _validateFields();
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      errorText: _passwordErrorText,
                    ),
                    onChanged: (_) {
                      _validateFields();
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Upload Profile Image'),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      _imageErrorText ?? '',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        _validateFields();
                        _validateImage();
                        if (_nameErrorText == null &&
                            _phoneErrorText == null &&
                            _emailErrorText == null &&
                            _passwordErrorText == null &&
                            _imageErrorText == null) {
                          _registerWithEmailAndPassword();
                        }
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 150, // Center horizontally
            child: Transform.translate(
              offset: Offset(0, 50), // Move 50 pixels up
              child: Image.asset(
                'assets/image_logo1.png', // Replace with your logo asset
                width: 300,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
