
class User {
  final String id;
  final String name;
  List<String> borrowedBooks;

  User({
    required this.id,
    required this.name,
    required this.borrowedBooks,
  });
}

class Book {
  final String id;
  final String title;

  Book({
    required this.id,
    required this.title,
  });
}
