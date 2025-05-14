import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          )
        ],
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.15)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, "Home", 0),
          _buildNavItem(Icons.history, "Riwayat", 1),
          _buildNavItem(Icons.person_outline_outlined, "Profil", 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: isSelected ? 0.9 : 1.0, end: isSelected ? 1.0 : 0.9),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: isSelected ? 12 : 0, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFFF66D06) : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                  AnimatedSize(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: isSelected
                        ? Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              label,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
