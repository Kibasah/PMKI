// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Kami', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection(
              context,
              title: 'I-CM (Media Kreatif Islam)',
              content:
                  'I-CM (Media Kreatif Islam) berfungsi sebagai alat yang boleh dirujuk dengan ciri-ciri interaktif yang mudah diakses.',
              icon: Icons.lightbulb_outline,
            ),
            const SizedBox(height: 24),
            _buildInfoSection(
              context,
              title: 'Maklumat Tambahan',
              content:
                  'Aplikasi ini merupakan inisiatif yang dibangunkan sebagai penyelesaian terhadap Islamic content bagi memenuhi keperluan komuniti Muslim.',
              icon: Icons.info_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, {required String title, required String content, required IconData icon}) {
    return Card( // Use global CardTheme
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: Theme.of(context).primaryColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant, // Use semantic colors
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
