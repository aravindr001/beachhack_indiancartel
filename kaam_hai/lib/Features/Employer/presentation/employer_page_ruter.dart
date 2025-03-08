import 'package:flutter/material.dart';
import 'package:kaam_hai/Features/Employer/presentation/emp_history.dart';
import 'package:kaam_hai/Features/Employer/presentation/employer_home_page.dart';
import 'package:kaam_hai/Features/Employer/presentation/employer_profile_page_worker.dart';
import 'package:kaam_hai/Features/Employer/presentation/navbar_employer.dart';

class PagesRouter extends StatefulWidget {
  const PagesRouter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  PagesRouterState createState() => PagesRouterState();
}

class PagesRouterState extends State<PagesRouter> {
  int _selectedIndex = 0; // Track the selected tab

  // List of pages corresponding to each tab
  final List<Widget> _pages = [
    EmployerHome(),
    HistoryPage(),
    EmpProfilePage(),
    // // const Communities(),
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
      bottomNavigationBar: CustomWhatsAppNavBarEmployer(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
