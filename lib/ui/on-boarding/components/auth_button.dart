import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:bersihku/ui/auth/sign-up/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            shape:
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21)
              ),
            padding: EdgeInsets.symmetric(vertical: 16),
            minimumSize: Size(
              MediaQuery.of(context).size.width * 0.7, 50
            ),
          ),
          child: Text(
            "Masuk",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0CA5E2)
            )
          ),
        ),
        SizedBox(height: 15),
        Text(
          "OR",
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            shape:
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21)
              ),
            padding: EdgeInsets.symmetric(vertical: 16),
            minimumSize: Size(
              MediaQuery.of(context).size.width * 0.7, 50
            ),
          ),
          child: Text(
            "Daftar",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0CA5E2)
            )
          ),
        ),
      ],
    );
  }
}
