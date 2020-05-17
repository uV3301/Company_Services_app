import 'package:flutter/material.dart';
import 'package:yehlo_app/ViewPage/authentication.dart';

class ExploreKeyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.pink,
      padding: EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: _width * 0.7,
                height: _height * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(7, 10),
                  )
                ]
                ),
                child: Center(
                  child: Text(
                    "Let's explore",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}


