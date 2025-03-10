
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/books_screen.dart';
import 'screens/users_screen.dart';
import 'services/library_service.dart';

void main() {
  // Create and initialize the service before the app starts
  final libraryService = LibraryService();
  
  runApp(
    ChangeNotifierProvider.value(
      value: libraryService,
      child: LibraryApp(),
    ),
  );
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
