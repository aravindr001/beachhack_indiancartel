import 'package:flutter/material.dart';
import 'package:kaam_hai/Features/employee/presentation/navbar_worker.dart';
import 'package:kaam_hai/Features/employee/presentation/referpage.dart';
import 'package:kaam_hai/Features/employee/presentation/worker_home_page.dart';
import 'package:kaam_hai/Features/employee/presentation/worker_profile_page_worker.dart';
import 'package:kaam_hai/Features/employee/presentation/worker_schemes_page.dart';

class WorkerPagesRouter extends StatefulWidget {
  const WorkerPagesRouter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  WorkerPagesRouterState createState() => WorkerPagesRouterState();
}

class WorkerPagesRouterState extends State<WorkerPagesRouter> {
  int _selectedIndex = 0; // Track the selected tab

  // List of pages corresponding to each tab
  final List<Widget> _pages = [
    WorkerHomeScreen(),
    SchemesPage(),
    ReferAndEarnScreen(),
    ProfilePage(),
    // const Calls(),
  ];

  // Function to handle tab changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomWhatsAppNavBarWorker(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
