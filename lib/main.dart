// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmki/firebase_options.dart';
import 'package:pmki/pages/login_page.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebaseApp();
  runApp(MyApp());
}

Future<void> initializeFirebaseApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);

  FirebaseStorage.instance;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PMKI',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF1F5F9), // Slight darker slate for contrast
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB), // Electric Blue
          primary: const Color(0xFF2563EB),
          secondary: const Color(0xFFF59E0B), // Amber
          background: const Color(0xFFF1F5F9),
          surface: Colors.white,
          onSurface: const Color(0xFF1E293B), // Slate 800
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2563EB),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A), // Slate 900
            letterSpacing: -1.0,
            fontSize: 32,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
            letterSpacing: -0.5,
            fontSize: 24,
          ),
          titleLarge: TextStyle(
             fontWeight: FontWeight.w600,
             color: Color(0xFF1E293B),
             fontSize: 20,
          ),
          bodyLarge: TextStyle(color: Color(0xFF334155), height: 1.6, fontSize: 16), // Slate 700
          bodyMedium: TextStyle(color: Color(0xFF475569), height: 1.5, fontSize: 14), // Slate 600
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8, // Modern colored shadow
            shadowColor: const Color(0xFF2563EB).withValues(alpha: 0.4),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          labelStyle: TextStyle(color: Colors.grey.shade500),
          floatingLabelStyle: const TextStyle(color: Color(0xFF2563EB)),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 10,
          shadowColor: const Color(0xFF64748B).withValues(alpha: 0.1),
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            // side: BorderSide(color: Colors.white, width: 2), // Subtle border
          ),
        ),
      ),
      home: SplashScreen(), // Display SplashScreen initially
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay before navigating to the home page
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Replace this with your logo or image
      body: Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }
}
