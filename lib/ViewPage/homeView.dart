import 'package:flutter/material.dart';
import './newUserData/nameView.dart';
import '../model/userdata.dart';


final primaryColor = const Color(0xFF26A69A);
class HomeView extends StatelessWidget {
  
  final userData = UserData(null, null, null, null);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      color: primaryColor,
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
                    blurRadius: 20,
                    offset: const Offset(7, 10),
                  )
                ]
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add new data",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 35,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      IconButton( 
                        iconSize: 35,
                        icon: Icon(Icons.add_box),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> NameView(userData)));
                        },
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}