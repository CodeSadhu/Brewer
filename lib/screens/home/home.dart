import 'package:flutter/material.dart';
import 'package:brew_crew/services/fb_auth.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(        
        title: Text("Brewer"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(            
            icon: Icon(Icons.person),
            label: Text("Sign Out"),
            onPressed: () async {
              await _authService.signOut();
            },
          )
        ],
      ),
    );
  }
}