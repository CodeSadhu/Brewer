import 'package:flutter/material.dart';
import 'home/home.dart';
import 'authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    // return Authenticate();
    if (user == null){
      return Authenticate();    
    }
    else{
      return Home();
    }
  }
}