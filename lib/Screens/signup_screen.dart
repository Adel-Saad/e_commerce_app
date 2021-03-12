import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:new_e_commerce_app/Providers/model_hud.dart';
import 'package:new_e_commerce_app/Screens/User/home_page.dart';
import 'package:new_e_commerce_app/Widgets/custom_logo.dart';
import 'package:new_e_commerce_app/Widgets/custom_text_field.dart';
import 'package:new_e_commerce_app/Services/auth.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
// Prop ...
  static String id = 'SignupScreen';
  final _auth = Auth();
  String _email, _password, _name;
  var _formKey = GlobalKey<FormState>();

// Main Build
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    final modelHud = Provider.of<ModelHud>(context);
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
                  _name = value;
                },
                hintText: 'Enter Your Name',
                icon: Icons.person,
              ),
              SizedBox(
                height: screenheight * 0.01,
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.black,
                  onPressed: () async {
                    modelHud.changeIsLoading(true);
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      try {
                        await _auth.signUp(_email.trim(), _password.trim());
                        modelHud.changeIsLoading(false);
                        Navigator.pushNamed(context, HomePage.id);
                      } on FirebaseAuthException catch (e) {
                        modelHud.changeIsLoading(false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.message,
                            ),
                          ),
                        );
                      }
                    }
                    modelHud.changeIsLoading(false);
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: screenheight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do have an Account ?.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LogInScreen.id);
                    },
                    child: Text(
                      ' Log in',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
