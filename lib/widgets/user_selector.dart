
import 'package:flutter/material.dart';
import '../models/library.dart';

class UserSelector extends StatelessWidget {
  final User currentUser;
  final VoidCallback onChangeUser;

  const UserSelector({
    required this.currentUser,
    required this.onChangeUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nhân viên',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(currentUser.name),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: onChangeUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E88E5), // library-blue
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Đổi'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
