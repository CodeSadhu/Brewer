import 'package:flutter/material.dart';
import 'package:brew_crew/services/fb_auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleForms;
  SignIn({ this.toggleForms });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  //States of TextFields
  String email = '';
  String password = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign In to Brewer"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed: () {
              widget.toggleForms();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                  border: OutlineInputBorder()
                ),
                validator: (val) => (val.isEmpty) ? "Enter your Email" : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  border: OutlineInputBorder()
                ),
                onChanged: (val) {
                  setState(() => password = val);
                },
                obscureText: true,
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink[400],
                child: Text("Sign In", style: TextStyle(color: Colors.white),),                
                onPressed: () async {
                  print("Email: "+email);
                  print("Password: "+password);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}