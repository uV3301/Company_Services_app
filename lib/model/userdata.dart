import 'dart:io';
class UserData {
  String title;
  DateTime time;
  File pgImage;  
  String loc;

  UserData(
      this.title, this.time,this.pgImage, this.loc);
  Map<String, dynamic> toJson()=>{
    "title" : title,
    "time" : time,
    "loc" : loc
  };
}
