import 'dart:math';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../Widgets/provider.dart';

final primaryColor = const Color(0xFF26A69A);
enum AuthFormType { signUp, signIn }

class AuthentView extends StatefulWidget {
  final AuthFormType authFormType;
  AuthentView({Key key, @required this.authFormType}) : super(key: key);
  @override
  _AuthentViewState createState() =>
      _AuthentViewState(authFormType: this.authFormType);
}

class _AuthentViewState extends State<AuthentView> {
  AuthFormType authFormType;
  _AuthentViewState({this.authFormType});
  String _email, _pw, _name, _error;
  final formkey = GlobalKey<FormState>();

  void switchFormState(String state) {
    formkey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formkey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _pw);
          print("Signed in with uid $uid");
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          String uid =
              await auth.createUserWithEmailAndPassword(_email, _pw, _name);
          print("Signed up with New uid $uid ");
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        print("error $e");
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: primaryColor,
        width: _width,
        height: _height,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              
              showAlert(),
              SizedBox(
                height: _height * 0.025,
              ),
              buildHeaderText(),
              SizedBox(
                height: _height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(children: buildInputs() + buildButtons()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget showAlert(){
    if(_error != null){
      return Container( 
        color: Colors.greenAccent,
        width: double.infinity,
        height: MediaQuery.of(context).size.height *0.08,
        padding: EdgeInsets.all(8),
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:8, right: 8),
            child: Icon(Icons.error),
          ),
          Expanded(child: AutoSizeText(_error, maxLines: 3,),),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _error = null;
                });
              },
            ),
          )

        ],),
      );
    }
    return SizedBox(height: 0,);
  }
  AutoSizeText buildHeaderText() {
    String _header;
    if (authFormType == AuthFormType.signUp) {
      _header = "Create New Account";
    } else {
      _header = "Sign In";
    }
    return AutoSizeText(
      _header,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 36),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textfields = [];
    if (authFormType == AuthFormType.signUp) {
      textfields.add(
        TextFormField(
          style: TextStyle(fontSize: 21),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (val) => _name = val,
          validator: NameValidator.validate,
        ),
      );
    }
    textfields.add(SizedBox(
      height: 21,
    ));
    textfields.add(
      TextFormField(
        style: TextStyle(fontSize: 21),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (val) => _email = val,
        validator: EmailValidator.validate,
      ),
    );
    textfields.add(SizedBox(
      height: 21,
    ));
    textfields.add(
      TextFormField(
        style: TextStyle(fontSize: 21),
        decoration: buildSignUpInputDecoration("Password"),
        onSaved: (val) => _pw = val,
        obscureText: true,
        validator: PasswordValidator.validate,

      ),
    );
    textfields.add(SizedBox(
      height: 21,
    ));

    return textfields;
  }

  List<Widget> buildButtons() {
    String _switchButton, _newFormState, _submitButtonText;
    if (authFormType == AuthFormType.signIn) {
      _switchButton = "Create an Account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
    } else {
      _switchButton = "Already have an account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: RaisedButton(
          onPressed: submit,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
      FlatButton(
        child: Text(_switchButton, style: TextStyle(color: Colors.white)),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      contentPadding: const EdgeInsets.only(left: 14, top: 10, bottom: 10),
    );
  }
}
