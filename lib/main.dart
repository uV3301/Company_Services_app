import 'package:flutter/material.dart';
import './services/auth_service.dart';
import './Widgets/provider.dart';
import './HomePage.dart';
import './ViewPage/firstView.dart';
import './ViewPage/authentication.dart';
void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        title: "Yehlo",
        theme: ThemeData(  
          primaryColor: Colors.black,
          accentColor: Colors.amber,
        ),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context)=>AuthentView(authFormType: AuthFormType.signUp,),
          '/signIn': (BuildContext context)=>AuthentView(authFormType: AuthFormType.signIn,),
          '/home': (BuildContext context)=>HomeController(),
        },
        // home: Homepage(),
        home: HomeController(),

      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChange,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Homepage() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
