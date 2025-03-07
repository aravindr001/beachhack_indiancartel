import 'package:flutter/material.dart';
import 'package:kaam_hai/screens/home_page.dart';
import 'package:kaam_hai/screens/schemespage.dart';
import 'package:kaam_hai/widgets/navbar2.dart';

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
    const HomePage(),
    SchemesPage(),
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
      bottomNavigationBar: CustomWhatsAppNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
