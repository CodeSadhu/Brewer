import 'package:flutter/material.dart';
import 'package:brew_crew/services/fb_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _authService = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign In to Brewer"),        
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text("Sign In Anonymously"),
          onPressed: () async {
            dynamic result = await _authService.anonSign();
            if (result == null){
              print("Error");
            }
            else{
              print("Signed In");
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}