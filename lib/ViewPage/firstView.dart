import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../Widgets/customDialog.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFF26A69A);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [primaryColor, Colors.white],
        begin: Alignment.center,
        end: Alignment.bottomCenter,

      )),
      width: _width,
      height: _height,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height * 0.2,
            ),
            Text(
              "Welcome",
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            SizedBox(
              height: _height * 0.03,
            ),
            // AutoSizeText(
            //   "Let's explore",
            //   textAlign: TextAlign.center,
            //   maxLines: 2,
            //   style: TextStyle(color: Colors.white, fontSize: 38),
            // ),
            Column(children: <Widget>[
              AutoSizeText(
                "Let's",
                style: TextStyle(fontSize: 40.0, color: Colors.white),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 8,),
              FadeAnimatedTextKit(
                totalRepeatCount: 20,
                text: ['EXPLORE', 'FIND', 'OBTAIN'],
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center,
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w600),

              ),
            ]),
            SizedBox(
              height: _height * 0.2,
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                child: Text("Get started",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w300)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context)=>CustomDialog(
                    title: "Would you like to create an account?",
                    description: "With an account, your data  will be securely saved, allowing access to features",
                    primaryButtonText: "Create My Account",
                    primaryButtonRoute: "/signUp",
                    secondaryButtonText: "Maybe later",
                    secondaryButtonRoute: "/home",
                    ),
                    
                );
              },
            ),
            SizedBox(
              height: _height * 0.05,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signIn');
              },
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 25, color: primaryColor),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
