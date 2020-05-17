
import '../../model/userdata.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './locationView.dart';

final primaryColor = const Color(0xFF26A69A);
class ImageView extends StatefulWidget {
  final UserData userData;
  ImageView(this.userData);
  createState() => _ImageViewState(); 
}

class _ImageViewState extends State<ImageView> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        cropStyle: CropStyle.rectangle,
      );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }
  void _clear() {
    setState(() => _imageFile = null);
  }
  void setImage(File imageFile) {
    setState(() {
      widget.userData.pgImage = imageFile;
      widget.userData.time  = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text("Yehlo PG"),
      ),

      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[

            Image.file(_imageFile),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: primaryColor,
              onPressed: () {
                setImage(_imageFile);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationView(widget.userData)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Next", style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w300),),
              ),
            )
          ]
        ],
      ),
    );
  }
}
