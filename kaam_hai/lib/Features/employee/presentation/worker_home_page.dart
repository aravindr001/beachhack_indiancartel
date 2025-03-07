import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kaam Hai')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: const Text(
              'Welcome to Kaam Hai!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job Title: Cleaning Assistant ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Employer: Surendran kumar',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('Location: Kallisery', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text(
                    'Description: We are looking for someone to clean our backyard.',
                    style: TextStyle(fontSize: 16),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
