
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/books_screen.dart';
import 'screens/users_screen.dart';

void main() {
  runApp(LibraryApp());
}

class LibraryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý thư viện',
      theme: ThemeData(
        primaryColor: Color(0xFF1E88E5), // library-blue color
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/books': (context) => BooksScreen(),
        '/users': (context) => UsersScreen(),
      },
    );
  }
}
