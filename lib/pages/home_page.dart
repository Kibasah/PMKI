// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pmki/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmki/pages/info.dart';

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
      backgroundColor: Color.fromRGBO(248, 222, 198, 0.8),
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            backgroundColor: Color.fromARGB(155, 247, 239, 204),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  image: DecorationImage(
                    image: AssetImage('assets/background_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
              'Laman Utama',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left, // Align text to the left
              ),
              centerTitle: false,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white, // Set the color of the icon to white
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
          ),
          SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: userProfileImageUrl.isNotEmpty
                            ? NetworkImage(userProfileImageUrl) // Use NetworkImage for the user's profile image URL
                            : AssetImage('assets/placeholder_image.jpg') as ImageProvider, // Use placeholder image if profileImageUrl is empty
                        radius: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Selamat Datang, $userName',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                 
                  SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      _buildRoundedButton('Karya', 'assets/image1.png'),
                      _buildRoundedButton('Penggiat Industri', 'assets/image2.png'),
                      _buildRoundedButton('Khalayak', 'assets/image3.png'),
                      _buildRoundedButton('Saluran Media', 'assets/image4.png'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 177, 33),
              ),
              child: Text(
                'Lain-Lain',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Maklum Balas'),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              leading: Icon(Icons.info), // Icon for the "Info" item
              title: Text('Info'),
              onTap: () {
                // Navigate to InfoPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Dasar Privasi'),
              onTap: () {
                // Handle item 3 tap
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Perform logout action here
                // For instance, navigate back to the login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
        },
      ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedButton(String text, String imagePath) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double iconSize = constraints.maxWidth * 0.55; // Adjust the icon size dynamically
      double textSize = constraints.maxWidth * 0.08; // Adjust the text size dynamically

      return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: iconSize,
              width: iconSize,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    },
  );
}

}
