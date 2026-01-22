// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        backgroundColor: Color.fromRGBO(248, 222, 198, 0.8),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 222, 198, 0.8),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I-CM (Media Kreatif Islam)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'I-CM (Media Kreatif Islam) berfungsi sebagai alat yang boleh dirujuk dengan ciri-ciri interaktif yang mudah diakses.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Maklumat Tambahan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Aplikasi ini merupakan inisiatif yang dibangunkan sebagai penyelesaian terhadap Islamic content bagi memenuhi keperluan komuniti Muslim.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
