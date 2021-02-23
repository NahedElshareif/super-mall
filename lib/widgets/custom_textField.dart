import 'package:flutter/material.dart';
import 'package:supermall/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;

  // ignore: missing_return
  String _erroMessage(String str) {
    switch (str) {
      case 'Enter your name':
        return 'Name is empty !';
      case 'Enter your email address':
        return 'Email is empty !';
      case 'Enter your password':
        return 'Password is empty !';
    }
  }

  CustomTextField(
      {@required this.onClick, @required this.hint,  this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _erroMessage(hint);
          }
        },
        onSaved: onClick,
        obscureText: hint == 'Enter your password' ? true : false,
        cursorColor: KSecondColor,
        
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 2.0),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12,),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: KSecondColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
