import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final primaryColor = const Color(0xFF26A69A);

class LocationView extends StatefulWidget {
  LocationView(this.userData);
  final UserData userData;
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    widget.userData.loc = position.toString();
  }

  bool onLoading = false;
  final db = Firestore.instance;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://yelho-application.appspot.com');
  StorageUploadTask _uploadTask;

  /// Starts an upload task
  _startImageUpload() {
    /// Unique file name for the file
    String filePath = 'images/${widget.userData.title}.png';
    setState(() {
      _uploadTask =
          _storage.ref().child(filePath).putFile(widget.userData.pgImage);
    });
  }

  final primaryColor = const Color(0xFF26A69A);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Finishing up"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _height * 0.10,
            ),
            buildHeaderText("Name: ${widget.userData.title}"),
            SizedBox(
              height: _height * 0.020,
            ),
            buildHeaderText(
                "Date: ${DateFormat('dd/MM/yy').format(widget.userData.time)}"),
            SizedBox(
              height: _height * 0.020,
            ),
            buildHeaderText("Image"),
            SizedBox(
              height: _height * 0.03,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  color: primaryColor,
                ),
                constraints: BoxConstraints.expand(
                    height: _height * 0.3, width: _width * 0.8),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Image.file(widget.userData.pgImage, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: _height * 0.08,
            ),
            onLoading
                ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: SpinKitRotatingCircle(
                      color: primaryColor,
                      size: 50.0,
                    ),
                )
                : Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: primaryColor,
                      onPressed: () async {
                        // save data to firebase
                        setState(() {
                          onLoading = true;
                        });
                        await _getCurrentLocation();
                        await _startImageUpload();
                        await db
                            .collection("PG_info")
                            .add(widget.userData.toJson());
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: Text(
                        "Finish",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
          ],
        )));
  }

  AutoSizeText buildHeaderText(String header) {
    String _header = header;
    return AutoSizeText(
      _header,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: primaryColor, fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
