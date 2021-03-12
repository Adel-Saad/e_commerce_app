import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:new_e_commerce_app/Providers/admin_mode.dart';
import 'package:new_e_commerce_app/Providers/model_hud.dart';
import 'package:new_e_commerce_app/Screens/Admin/admin_home.dart';
import 'package:new_e_commerce_app/Screens/User/home_page.dart';
import 'package:new_e_commerce_app/Screens/signup_screen.dart';
import 'package:new_e_commerce_app/Services/auth.dart';
import 'package:new_e_commerce_app/Widgets/custom_logo.dart';
import 'package:new_e_commerce_app/Widgets/custom_text_field.dart';
import 'package:new_e_commerce_app/constants.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
// prop
  String _email, _password;
  static String id = 'LoginScreen';
  var _formKey = GlobalKey<FormState>();
  var _auth = Auth();
  bool isAdmin = false;
  final adminPassword = 'admin123456';
// main build
  @override
  Widget build(BuildContext context) {
    final modelHud = Provider.of<ModelHud>(context);
    var screenheight = MediaQuery.of(context).size.height;
    final isAdmin = Provider.of<AdminMode>(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: modelHud.isLoading,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomLogo(screenheight: screenheight),
              SizedBox(
                height: screenheight * 0.08,
              ),
              CustomTextField(
                onclick: (value) {
                  _email = value;
                },
                hintText: 'Enter Your Email',
                icon: Icons.email,
              ),
              SizedBox(
                height: screenheight * 0.01,
              ),
              CustomTextField(
                onclick: (value) {
                  _password = value;
                },
                hintText: 'Enter Your Password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: screenheight * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.black,
                    onPressed: () {
                      _validate(context, modelHud, isAdmin);
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: screenheight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an Account ?.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      ' Sign up',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenheight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      isAdmin.changeIsAdmin(true);
                    },
                    child: Text(
                      'I \'am An Admin',
                      style: TextStyle(
                          color: isAdmin.isAdmin ? kMainColor : Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isAdmin.changeIsAdmin(false);
                    },
                    child: Text(
                      'I \'am a User',
                      style: TextStyle(
                          color: isAdmin.isAdmin ? Colors.white : kMainColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(
      BuildContext context, ModelHud modelHud, AdminMode adminMode) async {
    modelHud.changeIsLoading(true);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (adminMode.isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.signIn(_email.trim(), _password.trim());
            modelHud.changeIsLoading(false);
            Navigator.pushNamed(context, AdminHome.id);
          } on FirebaseAuthException catch (e) {
            modelHud.changeIsLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong..! '),
            ),
          );
        }
      } else {
        try {
          await _auth.signIn(_email, _password);
          modelHud.changeIsLoading(false);
          Navigator.pushNamed(context, HomePage.id);
        } on FirebaseAuthException catch (e) {
          modelHud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelHud.changeIsLoading(false);
  }
}
