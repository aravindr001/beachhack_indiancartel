import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> workHistory = [
      {
        'jobTitle': 'Construction Worker',
        'wage': '₹500',
        'location': 'Same Location',
        'date': '12 Oct 2024',
        'workType': 'Construction',
      },
      {
        'jobTitle': 'Electrician',
        'wage': '₹800',
        'location': 'Same Location',
        'date': '10 Oct 2024',
        'workType': 'Electrician',
      },
      {
        'jobTitle': 'Domestic Helper',
        'wage': '₹300',
        'location': 'Same Location',
        'date': '5 Oct 2024',
        'workType': 'Domestic Work',
      },
      {
        'jobTitle': 'Driver',
        'wage': '₹1000',
        'location': 'Same Location',
        'date': '1 Oct 2024',
        'workType': 'Driving',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Work Provided History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workHistory.length,
        itemBuilder: (context, index) {
          final data = workHistory[index];

          return _JobCard(
            jobTitle: data['jobTitle']!,
            wage: data['wage']!,
            location: data['location']!,
            date: data['date']!,
            workType: data['workType']!,
          );
        },
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final String jobTitle;
  final String wage;
  final String location;
  final String date;
  final String workType;

  const _JobCard({
    required this.jobTitle,
    required this.wage,
    required this.location,
    required this.date,
    required this.workType,
  });

  IconData _getWorkTypeIcon() {
    switch (workType.toLowerCase()) {
      case 'construction':
        return Icons.construction;
      case 'farming':
        return Icons.agriculture;
      case 'domestic work':
        return Icons.cleaning_services;
      case 'driving':
        return Icons.directions_car;
      case 'electrician':
        return Icons.electrical_services;
      default:
        return Icons.work;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_getWorkTypeIcon(), size: 28, color: Colors.black87),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  jobTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Location: $location',
            style: const TextStyle(color: Colors.black87),
          ),
          Text('Date: $date', style: const TextStyle(color: Colors.black87)),
          Text('Wage: $wage', style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
