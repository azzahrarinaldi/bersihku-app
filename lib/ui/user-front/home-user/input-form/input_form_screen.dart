import 'package:bersihku/ui/user-front/home-user/input-form/components/input_form_body.dart';
import 'package:flutter/material.dart';

class InputFormScreen extends StatelessWidget {
  const InputFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Laporan Pengangkutan',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: InputFormBody(),
    );
  }
}