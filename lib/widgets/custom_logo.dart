
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.only(top:30.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/icons/pngegg(55).png',
                  width: 180,
                  height: 180,
                  ),
                  Positioned(
                    bottom: 0,top: 160,
                    child: Text('Super mall',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: "Pacifico"),
                      ),
                      ),
                   ],
              ),
              
            ),
          );
  }
}