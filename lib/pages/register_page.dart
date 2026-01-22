// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmki/auth_service.dart'; // Import your AuthService
import 'package:pmki/pages/home_page.dart'; // Import your home page widget
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
// import 'package:image_picker/image_picker.dart'; // Import ImagePicker

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
// File? _imageFile;

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

/*
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
*/

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
    /*
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
    */
  }

  // FocusNodes for text fields
  // final FocusNode _nameFocus = FocusNode();
  // final FocusNode _phoneNumberFocus = FocusNode();
  // final FocusNode _emailFocus = FocusNode();
  // final FocusNode _passwordFocus = FocusNode();

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
  // String? _imageErrorText;

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
      // _imageErrorText = null; // _imageFile == null ? 'Please upload an image' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Daftar Akaun', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/image_logo1.png',
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildModernInput(
                              controller: _nameController,
                              prefixIcon: Icons.person_outline,
                              hint: 'Nama Penuh',
                              errorText: _nameErrorText,
                              onChanged: (_) => _validateFields(),
                            ),
                            const SizedBox(height: 16),
                            _buildModernInput(
                              controller: _phoneNumberController,
                              prefixIcon: Icons.phone_android_outlined,
                              hint: 'Nombor Telefon',
                              keyboardType: TextInputType.phone,
                              errorText: _phoneErrorText,
                              onChanged: (_) => _validateFields(),
                            ),
                            const SizedBox(height: 16),
                            _buildModernInput(
                              controller: _emailController,
                              prefixIcon: Icons.email_outlined,
                              hint: 'E-mel',
                              keyboardType: TextInputType.emailAddress,
                              errorText: _emailErrorText,
                              onChanged: (_) => _validateFields(),
                            ),
                            const SizedBox(height: 16),
                            _buildModernInput(
                              controller: _passwordController,
                              prefixIcon: Icons.lock_outline,
                              hint: 'Kata Laluan',
                              obscureText: true,
                              errorText: _passwordErrorText,
                              onChanged: (_) => _validateFields(),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () {
                                _validateFields();
                                _validateImage();
                                if (_nameErrorText == null &&
                                    _phoneErrorText == null &&
                                    _emailErrorText == null &&
                                    _passwordErrorText == null) {
                                  _registerWithEmailAndPassword();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              child: const Text(
                                'Daftar Sekarang',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Sudah mempunyai akaun? Log Masuk',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInput({
    required TextEditingController controller,
    required IconData prefixIcon,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? errorText,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(prefixIcon, color: Colors.white60),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
        ),
        errorText: errorText,
        errorStyle: const TextStyle(color: Colors.orangeAccent),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
