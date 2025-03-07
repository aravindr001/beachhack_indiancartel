import 'package:flutter/material.dart';

class SchemesPage extends StatelessWidget {
  final List<Map<String, String>> schemes = [
    {
      'name': 'Pradhan Mantri Awas Yojana',
      'eligibility': 'Low-income families without a permanent house',
      'location': 'All India',
      'description':
          'Provides affordable housing to economically weaker sections with financial assistance from the government.',
    },
    {
      'name': 'Rashtriya Swasthya Bima Yojana',
      'eligibility': 'Families below the poverty line (BPL)',
      'location': 'All India',
      'description':
          'Health insurance scheme offering cashless treatment up to ₹30,000 per family per year.',
    },
    {
      'name':
          'Mahatma Gandhi National Rural Employment Guarantee Act (MGNREGA)',
      'eligibility': 'Rural households seeking manual work',
      'location': 'All India',
      'description':
          'Provides 100 days of guaranteed wage employment per year to every rural household.',
    },
  ];

  SchemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Schemes'),
        // backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: schemes.length,
          itemBuilder: (context, index) {
            final scheme = schemes[index];
            return Card(
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
                      scheme['name']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Eligibility: ${scheme['eligibility']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Location: ${scheme['location']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Description: ${scheme['description']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
