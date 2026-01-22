import 'package:flutter/material.dart';

class PenggiatPage extends StatelessWidget {
  const PenggiatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penggiat', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
           _buildProfileCard(
            context,
            name: 'Nama Penggiat 1',
            role: 'Pengarah Filem',
            description: 'Berpengalaman lebih 10 tahun dalam industri.',
          ),
          const SizedBox(height: 16),
          _buildProfileCard(
            context,
            name: 'Nama Penggiat 2',
            role: 'Penulis Skrip',
            description: 'Telah menghasilkan pelbagai karya kreatif.',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, {required String name, required String role, required String description}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Icon(Icons.person, size: 32, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
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
      ),
    );
  }
}
