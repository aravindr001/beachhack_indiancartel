import 'package:flutter/material.dart';
import 'package:kaam_hai/Features/Auth/Services/auth_service.dart';
import 'package:kaam_hai/Features/employee/presentation/worker_pages_router.dart';
import 'package:kaam_hai/Features/Employer/presentation/employer_page_ruter.dart';

class SelectRolePage extends StatelessWidget {
  const SelectRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Role')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoleSelectionCard(
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/3135/3135731.png',
              title: 'Employer',
              description: 'Hire workers for your needs',
              onTap: () {
                // Navigator.pushNamed(context, '/employer');
                navigateToEmployerRouterWidget(context);
              },
            ),
            const SizedBox(height: 20),
            RoleSelectionCard(
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
              title: 'Employee',
              description: 'Find jobs that match your skills',
              onTap: () {
                navigateToWorkerRouterWidget(context);
                // Navigator.pushNamed(context, '/employee');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AuthService().logOut();
                // Add your logout logic here
                // Navigator.pushNamed(context, '/logout');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleSelectionCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onTap;

  const RoleSelectionCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity, // Full width
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void navigateToWorkerRouterWidget(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => WorkerPagesRouter()),
  );
}

void navigateToEmployerRouterWidget(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PagesRouter()),
  );
}
