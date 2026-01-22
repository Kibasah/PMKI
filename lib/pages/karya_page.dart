import 'package:flutter/material.dart';

class KaryaPage extends StatelessWidget {
  const KaryaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karya', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildItemCard(
            context,
            title: 'Contoh Karya 1',
            description: 'Penerangan ringkas mengenai karya ini.',
            imageUrl: 'assets/image1.png', 
          ),
          const SizedBox(height: 16),
          _buildItemCard(
            context,
            title: 'Contoh Karya 2',
            description: 'Penerangan ringkas mengenai karya ini.',
            imageUrl: 'assets/image1.png',
          ),
            const SizedBox(height: 16),
           _buildItemCard(
            context,
            title: 'Contoh Karya 3',
            description: 'Penerangan ringkas mengenai karya ini.',
            imageUrl: 'assets/image1.png',
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, {required String title, required String description, required String imageUrl}) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), // Match card shape
            child: Container(
              height: 180,
              width: double.infinity,
              color: Colors.grey.shade100, 
              child: Icon(Icons.image, size: 60, color: Colors.grey.shade300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0), // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
