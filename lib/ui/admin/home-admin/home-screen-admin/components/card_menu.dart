import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';

class CardMenu extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final Widget icon;
  final VoidCallback? onPressed;

  const CardMenu({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.icon,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: icon,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 35),
                    side: BorderSide(color: primaryColor, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}