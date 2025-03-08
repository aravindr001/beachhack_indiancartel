import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kaam_hai/Features/Employer/presentation/addjobscreen.dart';

class EmployerHome extends StatelessWidget {
  const EmployerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.black;
    final Color backgroundColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JobGiver',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // backgroundColor: backgroundColor,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: primaryColor),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddJobScreen()),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddJobScreen()),
            ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('jobs')
                .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return _buildEmptyState(context);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return _JobCard(
                documentId: doc.id,
                jobTitle: data['jobName'] ?? 'Untitled Position',
                wage: data['wage'] ?? 'Negotiable',
                location: data['address'] ?? 'Location not specified',
                date:
                    data['date'] != null
                        ? DateFormat(
                          'dd MMM yyyy',
                        ).format((data['date'] as Timestamp).toDate())
                        : 'Flexible',
                workType: data['workType'] ?? 'General Labor',
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text(
            'No Jobs Posted Yet',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddJobScreen()),
                ),
            child: const Text(
              'Post Your First Job',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final String documentId;
  final String jobTitle;
  final String wage;
  final String location;
  final String date;
  final String workType;

  const _JobCard({
    required this.documentId,
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

  Future<void> _deleteJob(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Job'),
            content: const Text(
              'Are you sure you want to delete this job posting?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        await FirebaseFirestore.instance
            .collection('jobs')
            .doc(documentId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error deleting job: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteJob(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoRow('Location', location, Icons.location_on),
              _buildInfoRow('Date', date, Icons.calendar_today),
              _buildInfoRow('Daily Wage', '₹$wage', Icons.currency_rupee),
              const SizedBox(height: 8),
              Text(
                'Posted ${DateFormat('dd MMM, hh:mm a').format(DateTime.now())}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
