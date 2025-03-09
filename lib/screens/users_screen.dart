
import 'package:flutter/material.dart';
import '../models/library.dart';
import '../widgets/app_navigation.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> with SingleTickerProviderStateMixin {
  late List<User> users;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    users = [
      User(id: '1', name: 'Nguyen Van A', borrowedBooks: ['1', '2']),
      User(id: '2', name: 'Tran Thi B', borrowedBooks: ['3']),
      User(id: '3', name: 'Le Van C', borrowedBooks: []),
    ];
    
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

  void handleAddUser() {
    showDialog(
      context: context,
      builder: (context) => _buildAddUserDialog(),
    );
  }

  Widget _buildAddUserDialog() {
    String newUserName = '';
    
    return AlertDialog(
      title: Text('Thêm nhân viên mới', textAlign: TextAlign.center),
      content: TextField(
        decoration: InputDecoration(
          labelText: 'Tên nhân viên',
          hintText: 'Nhập tên nhân viên',
        ),
        onChanged: (value) {
          newUserName = value;
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
            if (newUserName.trim().isNotEmpty) {
              setState(() {
                users.add(User(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: newUserName,
                  borrowedBooks: [],
                ));
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã thêm nhân viên mới')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Vui lòng nhập tên nhân viên')),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Danh sách nhân viên',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: handleAddUser,
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
                    child: users.isEmpty
                        ? Center(
                            child: Text(
                              'Chưa có nhân viên nào',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: users.length,
                            separatorBuilder: (context, index) => Divider(height: 1),
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return ListTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.person, size: 16, color: Colors.grey.shade500),
                                    SizedBox(width: 8),
                                    Text(
                                      user.name,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.book, size: 14, color: Colors.grey.shade500),
                                      SizedBox(width: 4),
                                      Text(
                                        '${user.borrowedBooks.length} sách đã mượn',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
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
      bottomNavigationBar: AppNavigation(currentIndex: 2),
    );
  }
}
