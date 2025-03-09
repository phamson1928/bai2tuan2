
import 'package:flutter/material.dart';

class AppNavigation extends StatelessWidget {
  final int currentIndex;

  const AppNavigation({
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/books');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/users');
                break;
            }
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Quản lý',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'DS sách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Nhân viên',
          ),
        ],
        selectedItemColor: Color(0xFF1E88E5), // library-blue
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
