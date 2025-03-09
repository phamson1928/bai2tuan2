
import 'package:flutter/material.dart';
import '../models/library.dart';

class LibraryService extends ChangeNotifier {
  // Singleton pattern
  static final LibraryService _instance = LibraryService._internal();
  
  factory LibraryService() {
    return _instance;
  }
  
  LibraryService._internal();
  
  // State
  final List<User> _users = [
    User(id: '1', name: 'Nguyen Van A', borrowedBooks: ['1', '2']),
    User(id: '2', name: 'Tran Thi B', borrowedBooks: ['3']),
    User(id: '3', name: 'Le Van C', borrowedBooks: []),
  ];
  
  final List<Book> _books = [
    Book(id: '1', title: 'Sách 01'),
    Book(id: '2', title: 'Sách 02'),
    Book(id: '3', title: 'Sách 03'),
  ];
  
  User _currentUser;
  
  // Initialize with first user
  LibraryService._internal() : _currentUser = User(id: '1', name: 'Nguyen Van A', borrowedBooks: ['1', '2']);
  
  // Getters
  List<User> get users => _users;
  List<Book> get books => _books;
  User get currentUser => _currentUser;
  
  // Methods
  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
  
  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }
  
  void removeBook(String id) {
    _books.removeWhere((book) => book.id == id);
    
    // Update borrowed books for all users
    for (var i = 0; i < _users.length; i++) {
      final user = _users[i];
      if (user.borrowedBooks.contains(id)) {
        final updatedBorrowedBooks = List<String>.from(user.borrowedBooks)..remove(id);
        _users[i] = User(
          id: user.id,
          name: user.name,
          borrowedBooks: updatedBorrowedBooks,
        );
        
        // Update current user if needed
        if (_currentUser.id == user.id) {
          _currentUser = _users[i];
        }
      }
    }
    
    notifyListeners();
  }
  
  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }
  
  void toggleBookBorrowing(String bookId) {
    final userIndex = _users.indexWhere((u) => u.id == _currentUser.id);
    
    if (userIndex != -1) {
      final user = _users[userIndex];
      final borrowedBooks = List<String>.from(user.borrowedBooks);
      
      if (borrowedBooks.contains(bookId)) {
        borrowedBooks.remove(bookId);
      } else {
        borrowedBooks.add(bookId);
      }
      
      // Create a new user object with updated borrowed books
      final updatedUser = User(
        id: user.id,
        name: user.name,
        borrowedBooks: borrowedBooks,
      );
      
      // Update the user in the list
      _users[userIndex] = updatedUser;
      
      // Update current user reference
      _currentUser = updatedUser;
      
      notifyListeners();
    }
  }
}
