import 'package:bersihku/ui/user/home-user/input-form/components/input_form_body.dart';
import 'package:flutter/material.dart';

class InputFormScreen extends StatelessWidget {
  const InputFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: screenWidth * 0.05),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Laporan Pengangkutan',
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: screenWidth * 0.00, 
      ),
      body: const InputFormBody(),
    );
  }
}
