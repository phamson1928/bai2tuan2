
import 'package:flutter/material.dart';
import '../models/library.dart';
import '../widgets/library_header.dart';
import '../widgets/user_selector.dart';
import '../widgets/book_list.dart';
import '../widgets/app_navigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late List<User> users;
  late List<Book> books;
  late User currentUser;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Initial sample data
    users = [
      User(id: '1', name: 'Nguyen Van A', borrowedBooks: ['1', '2']),
      User(id: '2', name: 'Tran Thi B', borrowedBooks: ['3']),
      User(id: '3', name: 'Le Van C', borrowedBooks: []),
    ];
    
    books = [
      Book(id: '1', title: 'Sách 01'),
      Book(id: '2', title: 'Sách 02'),
      Book(id: '3', title: 'Sách 03'),
    ];
    
    currentUser = users[0];
    
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
    setState(() {
      currentUser = user;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã chọn: ${user.name}')),
    );
  }

  void handleToggleBook(String bookId) {
    setState(() {
      int userIndex = users.indexWhere((u) => u.id == currentUser.id);
      
      if (userIndex != -1) {
        User user = users[userIndex];
        
        if (user.borrowedBooks.contains(bookId)) {
          user.borrowedBooks.remove(bookId);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đã trả sách')),
          );
        } else {
          user.borrowedBooks.add(bookId);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đã mượn sách')),
          );
        }
        
        currentUser = users[userIndex];
      }
    });
  }

  void handleAddBook() {
    showDialog(
      context: context,
      builder: (context) => _buildAddBookDialog(),
    );
  }

  Widget _buildUserSelectDialog() {
    return AlertDialog(
      title: Text('Chọn nhân viên', textAlign: TextAlign.center),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
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
              setState(() {
                books.add(Book(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: newBookTitle,
                ));
              });
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
                    currentUser: currentUser,
                    onChangeUser: handleChangeUser,
                  ),
                  BookList(
                    books: books,
                    borrowedBooks: currentUser.borrowedBooks,
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
}
