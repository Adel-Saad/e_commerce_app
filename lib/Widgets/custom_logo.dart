import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/constants.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    Key key,
    @required this.screenheight,
  }) : super(key: key);

  final double screenheight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: screenheight * 0.25,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: kMainColor,
              radius: 45,
              backgroundImage: AssetImage('assets/icons/icon.png'),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                'Buy it',
                style: TextStyle(fontFamily: 'Pacifico-Regular', fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
