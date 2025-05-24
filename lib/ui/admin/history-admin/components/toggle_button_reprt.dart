import 'package:bersihku/controller/history_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleButtonReport extends StatelessWidget {
  final HistoryAdminController ctrl;
  final bool daily;
  final String label;

  const ToggleButtonReport({
    super.key,
    required this.ctrl,
    required this.daily,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sel = ctrl.isDaily.value == daily;
      return GestureDetector(
        onTap: () {
          ctrl.isDaily.value = daily;
          ctrl.filterCardData();
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: sel ? const Color(0xFFFDD835) : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: sel ? Colors.black87 : Colors.white,
                fontWeight: sel ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    });
  }
}