import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
   CustomLoginButton({super.key, required this.buttonName,required this.onPressed});

  final String buttonName;
   VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ,
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(410, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text('$buttonName', style: TextStyle(color: Colors.black)),
    );
  }
}
