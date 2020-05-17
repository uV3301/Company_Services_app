import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomDialog extends StatelessWidget {
  final primaryColor = const Color(0xFF26A69A);
  final String title,
      description,
      primaryButtonText,
      primaryButtonRoute,
      secondaryButtonText,
      secondaryButtonRoute;
  CustomDialog(
      {@required this.title,
      @required this.description,
      @required this.primaryButtonText,
      @required this.primaryButtonRoute,
      this.secondaryButtonText,
      this.secondaryButtonRoute});
  static const double pad = 20;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(pad)),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(pad),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(pad),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0.1, 10),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                AutoSizeText(
                  title,
                  maxLines: 2,
                  style: TextStyle(color: primaryColor, fontSize: 25),
                ),
                SizedBox(
                  height: 24,
                ),
                AutoSizeText(
                  description,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                SizedBox(
                  height: 24,
                ),
                RaisedButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: AutoSizeText(
                    primaryButtonText,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, primaryButtonRoute);
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                showSecondaryButton(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  showSecondaryButton(BuildContext context) {
    if(secondaryButtonRoute != null && secondaryButtonText != null){
      return FlatButton(
      child: AutoSizeText(
        secondaryButtonText,
        maxLines: 1,
        style: TextStyle(
            color: primaryColor, fontSize: 20, fontWeight: FontWeight.w400),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, secondaryButtonRoute);
      },
    );
    }else{
      return SizedBox(height: 10);
    }
  }
}
