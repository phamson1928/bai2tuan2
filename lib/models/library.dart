
// Models for the library app

class Book {
  final String id;
  final String title;

  Book({
    required this.id,
    required this.title,
  });
}

class User {
  final String id;
  final String name;
  final List<String> borrowedBooks;

  User({
    required this.id,
    required this.name,
    required this.borrowedBooks,
  });
}
