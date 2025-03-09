
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
    for (var user in _users) {
      user.borrowedBooks.remove(id);
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
      if (_users[userIndex].borrowedBooks.contains(bookId)) {
        _users[userIndex].borrowedBooks.remove(bookId);
      } else {
        _users[userIndex].borrowedBooks.add(bookId);
      }
      
      // Update current user reference
      _currentUser = _users[userIndex];
      notifyListeners();
    }
  }
}
