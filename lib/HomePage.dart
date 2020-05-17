import 'package:flutter/material.dart';
import './pages.dart';
import './services/auth_service.dart';
import './Widgets/provider.dart';
import './ViewPage/homeView.dart';
class Homepage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Homepage> {
  final List<Widget> _children = [
    ExploreKeyPage(),
    HomeView(),
  ];
  int curIndex= 1;

  void ontapNavbar(int index) {
    setState(() {
      curIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
        title: Text("Yehlo Home", style: TextStyle(color: Colors.grey)),
        elevation: 10,
        actions: <Widget>[
          Center(child: Text("Sign out",style: TextStyle(color: Colors.white60, fontSize: 21, fontWeight: FontWeight.w400))),          
          IconButton( 
            icon: Icon(Icons.remove_from_queue),
            onPressed: () async {
              try{
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
              }catch(e){
                print("Error: $e");
              }

            },            
          ),
          
        ],
      ),
      body: _children[curIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: ontapNavbar,  
        currentIndex: curIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text("Explore"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
        ],
      ),
    );
  }
}