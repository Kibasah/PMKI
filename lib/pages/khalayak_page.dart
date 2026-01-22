import 'package:flutter/material.dart';

class KhalayakPage extends StatelessWidget {
  const KhalayakPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khalayak', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(Icons.groups_outlined, size: 72, color: Theme.of(context).primaryColor),
                    const SizedBox(height: 24),
                    Text(
                      'Sasaran Khalayak',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Bahagian ini memfokuskan kepada impak dan penerimaan kandungan media kreatif Islam dalam kalangan masyarakat. Ia merangkumi maklum balas, kajian kes, dan demografi penonton.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
