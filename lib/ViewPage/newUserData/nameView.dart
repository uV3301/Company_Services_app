import 'package:flutter/material.dart';
import '../../model/userdata.dart';
import './imageView.dart';
import 'package:auto_size_text/auto_size_text.dart';
final primaryColor = const Color(0xFF26A69A);
class NameView extends StatelessWidget {
  final UserData userData;
  NameView(this.userData);


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    TextEditingController _txtcontroller = TextEditingController();
    _txtcontroller.text = userData.title;
    return Scaffold(
        appBar: AppBar(
          title: Text("Yehlo PG"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildHeaderText("PG's Name"),
            SizedBox(height: _height *0.1,),
            Padding(
              padding: const EdgeInsets.only(top:8, bottom: 16, left: 20, right: 20),
              child: TextField(
                style: TextStyle(fontSize: 18),
                autofocus: true,
                controller: _txtcontroller,
                textAlign: TextAlign.start,
                cursorColor: primaryColor,
                decoration: buildInputDecoration(),

              ),
            ),
            SizedBox(height: _height *0.1,),
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: primaryColor,
              onPressed: () {
                userData.title = _txtcontroller.text;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageView(userData)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Next", style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w300),),
              ),
            )
          ],
        )));
  }
  AutoSizeText buildHeaderText(String header) {
    String _header = header;
    return AutoSizeText(
      _header,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(color: primaryColor, fontSize: 33, fontWeight: FontWeight.w600),
    );
  }
  InputDecoration buildInputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 14, top: 10, bottom: 10),
    );
  }
}
