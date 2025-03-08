import 'package:flutter/material.dart';

class CustomWhatsAppNavBarEmployer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomWhatsAppNavBarEmployer({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  // List of tabs
  final List<Map<String, dynamic>> _tabs = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.receipt_long, 'label': 'idk'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            _tabs.map((tab) {
              int index = _tabs.indexOf(tab);
              return InkWell(
                onTap: () => onItemTapped(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color:
                        selectedIndex == index
                            ? Colors.teal.withOpacity(0.2)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   tab['icon'],
                      //   color:
                      //       selectedIndex == index ? Colors.teal : Colors.grey,
                      //   width: 24,
                      //   height: 24,
                      // ),
                      Icon(
                        tab['icon'],
                        color:
                            selectedIndex == index ? Colors.teal : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tab['label'],
                        style: TextStyle(
                          color:
                              selectedIndex == index
                                  ? Colors.teal
                                  : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
