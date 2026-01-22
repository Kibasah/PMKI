// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pmki/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmki/pages/info.dart';
import 'package:pmki/pages/karya_page.dart';
import 'package:pmki/pages/penggiat_page.dart';
import 'package:pmki/pages/khalayak_page.dart';
import 'package:pmki/pages/media_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userName = ''; // Initialize userName
  String userProfileImageUrl = ''; // Initialize userProfileImageUrl

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Call the method to fetch user data
  }

  void _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      // Fetch user data from Firestore
      DocumentSnapshot userData = await _firestore.collection('users').doc(uid).get();
      if (userData.exists) {
        setState(() {
          userName = userData.get('name') ?? '';
          userProfileImageUrl = userData.get('profileImageUrl') ?? ''; // Get user's profile image URL from Firestore
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xFF1E3A8A),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.blurBackground, StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/background_image.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: const Text(
                'Laman Utama',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              centerTitle: false,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2563EB), Color(0xFFF59E0B)],
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: userProfileImageUrl.isNotEmpty
                                ? NetworkImage(userProfileImageUrl)
                                : const AssetImage('assets/placeholder_image.jpg') as ImageProvider,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Selamat Datang,',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                userName.isEmpty ? 'Pengguna' : userName,
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Kategori Utama',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Grid Section
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                    children: [
                      _buildModernCard(
                        context,
                        'Karya',
                        'assets/image1.png',
                        const Color(0xFF2563EB), // Blue
                        'Jelajahi karya kreatif',
                      ),
                      _buildModernCard(
                        context,
                        'Penggiat',
                        'assets/image2.png',
                        const Color(0xFFF59E0B), // Amber
                        'Komuniti profesional',
                      ),
                      _buildModernCard(
                        context,
                        'Khalayak',
                        'assets/image3.png',
                        const Color(0xFF10B981), // Emerald
                        'Sasaran audiens',
                      ),
                      _buildModernCard(
                        context,
                        'Media',
                        'assets/image4.png',
                        const Color(0xFF8B5CF6), // Violet
                        'Saluran & Platform',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      endDrawer: _buildModernDrawer(),
    );
  }


// ... (existing helper methods)

  Widget _buildModernCard(BuildContext context, String title, String imagePath, Color accentColor, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (title == 'Karya') {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const KaryaPage()));
            } else if (title == 'Penggiat') {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PenggiatPage()));
            } else if (title == 'Khalayak') {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const KhalayakPage()));
            } else if (title == 'Media') {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const MediaPage()));
            }
          },
          borderRadius: BorderRadius.circular(24),
          splashColor: accentColor.withValues(alpha: 0.1),
          highlightColor: accentColor.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernDrawer() {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
          ),
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(32)),
                ),
                child: const Center(
                  child: Text(
                    'Menu Utama',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildDrawerItem(Icons.feedback_outlined, 'Maklum Balas', () {}),
              _buildDrawerItem(Icons.info_outline, 'Tentang Kami', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage()));
              }),
              _buildDrawerItem(Icons.privacy_tip_outlined, 'Privasi', () {}),
              const Spacer(),
              const Divider(indent: 20, endIndent: 20),
              _buildDrawerItem(Icons.logout, 'Log Keluar', () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              }, color: Colors.redAccent),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? const Color(0xFF1E3A8A)),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? const Color(0xFF1E3A8A),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}

extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

