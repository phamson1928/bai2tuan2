
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/library.dart';
import '../widgets/library_header.dart';
import '../widgets/user_selector.dart';
import '../widgets/book_list.dart';
import '../widgets/app_navigation.dart';
import '../services/library_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Setup animation
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

  void handleChangeUser() {
    showDialog(
      context: context,
      builder: (context) => _buildUserSelectDialog(),
    );
  }

  void handleSelectUser(User user) {
    Provider.of<LibraryService>(context, listen: false).setCurrentUser(user);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã chọn: ${user.name}')),
    );
  }

  void handleToggleBook(String bookId) {
    Provider.of<LibraryService>(context, listen: false).toggleBookBorrowing(bookId);
    
    // Show appropriate message
    final service = Provider.of<LibraryService>(context, listen: false);
    final isBorrowed = service.currentUser.borrowedBooks.contains(bookId);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isBorrowed ? 'Đã mượn sách' : 'Đã trả sách')),
    );
  }

  void handleAddBook() {
    showDialog(
      context: context,
      builder: (context) => _buildAddBookDialog(),
    );
  }

  Widget _buildUserSelectDialog() {
    final service = Provider.of<LibraryService>(context, listen: false);
    
    return AlertDialog(
      title: Text('Chọn nhân viên', textAlign: TextAlign.center),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: service.users.length,
          itemBuilder: (context, index) {
            final user = service.users[index];
            return ListTile(
              title: Text(user.name),
              onTap: () {
                handleSelectUser(user);
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      LibraryHeader(),
                      UserSelector(
                        currentUser: service.currentUser,
                        onChangeUser: handleChangeUser,
                      ),
                      BookList(
                        books: service.books,
                        borrowedBooks: service.currentUser.borrowedBooks,
                        onToggleBook: handleToggleBook,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: handleAddBook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1E88E5), // library-blue
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('Thêm', style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: 80), // Space for bottom navigation
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: AppNavigation(currentIndex: 0),
        );
      }
    );
  }
}
