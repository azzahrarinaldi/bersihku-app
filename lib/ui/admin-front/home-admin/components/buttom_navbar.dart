import 'package:bersihku/const.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _CustomBottomNavState createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, "Beranda", 0),
          _buildNavItem(Icons.history, "Riwayat", 1),
          _buildNavItem(Icons.person_outline_outlined, "Profil", 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = widget.selectedIndex == index;

    return GestureDetector(
      onTap: () => widget.onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 9 : 0, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? textSecondary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Icon(icon, key: ValueKey(isSelected), size: 28, color: isSelected ? Colors.white : Colors.grey),
            ),
            const SizedBox(width: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 0),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: isSelected
                  ? Text(
                      label,
                      key: ValueKey(label),
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}