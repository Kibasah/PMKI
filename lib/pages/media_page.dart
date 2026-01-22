import 'package:flutter/material.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildMediaItem(
            context,
            title: 'Saluran TV',
            description: 'Senarai saluran televisyen yang menyiarkan kandungan patuh syariah.',
            icon: Icons.tv,
          ),
          const SizedBox(height: 16),
           _buildMediaItem(
            context,
            title: 'Radio & Podcast',
            description: 'Siaran radio dan podcast yang membincangkan topik-topik kreatif Islam.',
            icon: Icons.mic,
          ),
          const SizedBox(height: 16),
           _buildMediaItem(
            context,
            title: 'Media Sosial',
            description: 'Platform media sosial rasmi dan komuniti dalam talian.',
            icon: Icons.public, // or Icons.share
          ),
        ],
      ),
    );
  }

  Widget _buildMediaItem(BuildContext context, {required String title, required String description, required IconData icon}) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            description,
             style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
        onTap: () {
          // Navigate to details if needed
        },
      ),
    );
  }
}
