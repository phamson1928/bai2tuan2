
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/library.dart';
import '../widgets/app_navigation.dart';
import '../services/library_service.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void handleAddBook() {
    showDialog(
      context: context,
      builder: (context) => _buildAddBookDialog(),
    );
  }

  void handleDeleteBook(String id) {
    Provider.of<LibraryService>(context, listen: false).removeBook(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã xóa sách')),
    );
  }

  Widget _buildAddBookDialog() {
    String newBookTitle = '';
    
    return AlertDialog(
      title: Text('Thêm sách mới', textAlign: TextAlign.center),
      content: TextField(
        decoration: InputDecoration(
          labelText: 'Tên sách',
          hintText: 'Nhập tên sách',
        ),
        onChanged: (value) {
          newBookTitle = value;
        },
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            if (newBookTitle.trim().isNotEmpty) {
              final service = Provider.of<LibraryService>(context, listen: false);
              service.addBook(Book(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: newBookTitle,
              ));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã thêm sách mới')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Vui lòng nhập tên sách')),
              );
            }
          },
          child: Text('Thêm'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to changes in the service
    return Consumer<LibraryService>(
      builder: (context, service, child) {
        return Scaffold(
          body: FadeTransition(
            opacity: _animation,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Danh sách sách',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: handleAddBook,
                          icon: Icon(Icons.add, size: 16),
                          label: Text('Thêm'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1E88E5),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: service.books.isEmpty
                            ? Center(
                                child: Text(
                                  'Chưa có sách nào',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: service.books.length,
                                separatorBuilder: (context, index) => Divider(height: 1),
                                itemBuilder: (context, index) {
                                  final book = service.books[index];
                                  return ListTile(
                                    title: Text(
                                      book.title,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit, size: 20),
                                          color: Colors.grey.shade500,
                                          onPressed: () {
                                            // Edit functionality would go here
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, size: 20),
                                          color: Colors.grey.shade500,
                                          onPressed: () => handleDeleteBook(book.id),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: AppNavigation(currentIndex: 1),
        );
      }
    );
  }
}
