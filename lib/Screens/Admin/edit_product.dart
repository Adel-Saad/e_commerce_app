import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Services/store.dart';
import 'package:new_e_commerce_app/Widgets/custom_text_field.dart';
import 'package:new_e_commerce_app/constants.dart';

class EditProduct extends StatelessWidget {
// props ...
  static String id = 'EditProduct';
  String _name, _price, _description, _location, _category;
  var _formKey = GlobalKey<FormState>();
  final _store = Store();

// Main Build ...
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ListView(
        children: [
          Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.12,
                  ),
                  CustomTextField(
                    hintText: product.pName,
                    onclick: (value) {
                      _name = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextField(
                    hintText: product.pPrice,
                    onclick: (value) {
                      _price = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextField(
                    hintText: product.pDescription,
                    onclick: (value) {
                      _description = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextField(
                    hintText: product.pPrice,
                    onclick: (value) {
                      _category = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextField(
                    hintText: product.pLocation,
                    onclick: (value) {
                      _location = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  RaisedButton(
                    color: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Edit Product'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        _store.editProduct(product.pID, {
                          kProductCategory: _category,
                          kProductDescription: _description,
                          kProductLocation: _location,
                          kProductName: _name,
                          kProductPrice: _price
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Product Edited Successfully'),
                          ),
                        );
                      } else {}
                    },
                  ),
                ],
              ))
        ],
      ),
    );
    ;
  }
}
