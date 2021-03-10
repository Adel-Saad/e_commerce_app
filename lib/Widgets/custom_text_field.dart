import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/constants.dart';

class CustomTextField extends StatelessWidget {
// prop ...
  final String hintText;
  final IconData icon;
  final Function onclick;

// helping method...
  String _errorMessage(String str) {
    switch (hintText) {
      case 'Enter Your Name':
        return 'Name is Empty !';
      case 'Enter Your Email':
        return 'Email is Empty !';
      case 'Enter Your Password':
        return 'Password is Empty !';
    }
  }

// const
  CustomTextField({@required this.hintText, this.icon, this.onclick});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        onSaved: onclick,
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hintText);
          }
        },
        obscureText: hintText == 'Enter Your Password' ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          filled: true,
          fillColor: kSecondaryColor,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
