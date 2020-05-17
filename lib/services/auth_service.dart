import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChange => _firebaseAuth.onAuthStateChanged.map(
    (FirebaseUser user) => user?.uid,
  );

  Future<String> createUserWithEmailAndPassword(String email, String pw, String name) async{
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pw);
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.user.updateProfile(userUpdateInfo);
    await currentUser.user.reload();
    return currentUser.user.uid;
  }

  Future<String> signInWithEmailAndPassword(String email, String pw) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pw)).user.uid;
  }

  signOut() {
    _firebaseAuth.signOut();
  }
}

class EmailValidator {
  static String validate(String value){
    if(value.isEmpty){
      return "Email can't be empty";
    }else{
      return null;
    }
  }
}

class PasswordValidator {
  static String validate(String value){
    if(value.isEmpty ){
      return "Password can't be empty";
    }
    if(value.length<6){
      return "Should be atleast 6 characters long";
    }
    return null;
  }
}

class NameValidator {
  static String validate(String value){
    if(value.isEmpty){
      return "Name can't be empty";
    }
    if(value.length < 2){
      return "Should be atleast 3 characters long";
    }
    return null;
  }
}