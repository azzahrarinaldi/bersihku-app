import 'package:bersihku/ui/history/detail-history/detail_screen.dart';
import 'package:bersihku/ui/profile-user/profile_screen.dart';
import 'package:flutter/material.dart';

class HistoryMenu extends StatelessWidget {
  final Function(String) onSelected;

  const HistoryMenu({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white,
          textStyle: TextStyle(color: Colors.black),
        ),
      ),
      child: PopupMenuButton<String>(
        shadowColor: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(
          minWidth: 140,
          maxWidth: 140, 
        ),
        onSelected: (value) {
          if (value == 'edit') {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailScreenHistory()),
            );
          } else if (value == 'detail') {
            Navigator.pushNamed(context, '/detail');
          }
        },
        offset: Offset(20, 30), 
        itemBuilder: (context) => [
          PopupMenuItem(
            height: 5, 
            value: 'edit',
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12), 
              child: Text(
                'Edit',
                style: TextStyle(color: Colors.black, fontSize: 10)
              ),
            ),
          ),
          PopupMenuItem(
            height: 5, 
            value: 'detail',
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text(
                'Detail',
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ),
        ],
        icon: Icon(Icons.more_vert, color: Colors.black, size: 18),
      ),
    );
  }
}
