import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Services/store.dart';
import 'package:new_e_commerce_app/Widgets/custom_text_field.dart';
import 'package:new_e_commerce_app/constants.dart';

class AddProducts extends StatelessWidget {
// props ...
  static String id = 'Add products';
  String _name, _price, _description, _location, _category;
  var _formKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
                    hintText: 'Product Name',
                    onclick: (value) {
                      _name = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextField(
                    hintText: 'Product Price',
                    onclick: (value) {
                      _price = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextField(
                    hintText: 'Product Description',
                    onclick: (value) {
                      _description = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextField(
                    hintText: 'Product Category',
                    onclick: (value) {
                      _category = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextField(
                    hintText: 'Product Location',
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
                    child: Text('Add Product'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        _store.addProduct(
                          Product(
                              pName: _name,
                              pDescription: _description,
                              pLocation: _location,
                              pPrice: _price,
                              pcategory: _category),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Product uploaded Successfully'),
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
  }
}
