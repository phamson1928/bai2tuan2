
import 'package:flutter/material.dart';
import '../models/library.dart';

class BookList extends StatelessWidget {
  final List<Book> books;
  final List<String> borrowedBooks;
  final Function(String) onToggleBook;

  const BookList({
    required this.books,
    required this.borrowedBooks,
    required this.onToggleBook,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh sách sách',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5), // library-gray
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              ...books.map((book) {
                final isBorrowed = borrowedBooks.contains(book.id);
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    elevation: isBorrowed ? 2 : 0,
                    child: InkWell(
                      onTap: () => onToggleBook(book.id),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade100,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: isBorrowed 
                                    ? Color(0xFF1E88E5)  // library-blue
                                    : Colors.grey.shade300,
                                ),
                                color: isBorrowed 
                                  ? Color(0xFF1E88E5)    // library-blue
                                  : Colors.transparent,
                              ),
                              child: isBorrowed 
                                ? Icon(
                                    Icons.check, 
                                    size: 16, 
                                    color: Colors.white,
                                  )
                                : null,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                book.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
