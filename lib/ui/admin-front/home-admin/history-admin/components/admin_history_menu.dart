import 'package:flutter/material.dart';

class HistoryMenu extends StatelessWidget {
  final Function(String) onSelected;

  const HistoryMenu({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

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
          minWidth: screenWidth * 0.35,
          maxWidth: screenWidth * 0.35,  
        ),
        onSelected: (value) {
          if (value == 'edit') {
            Navigator.pushNamed(context, '/edit-riwayat');
          } else if (value == 'detail') {
            Navigator.pushNamed(context, '/detail-history');
          }
        },
        offset: Offset(20, 30),
        itemBuilder: (context) => [
          PopupMenuItem(
            height: screenWidth * 0.08, 
            value: 'edit',
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.01,
                horizontal: screenWidth * 0.03,
              ),
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.03, 
                ),
              ),
            ),
          ),
          PopupMenuItem(
            height: screenWidth * 0.08,
            value: 'detail',
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.01,
                horizontal: screenWidth * 0.03,
              ),
              child: Text(
                'Detail',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.03,
                ),
              ),
            ),
          ),
        ],
        icon: Icon(Icons.more_vert, color: Colors.black, size: screenWidth * 0.045),
      ),
    );
  }
}
