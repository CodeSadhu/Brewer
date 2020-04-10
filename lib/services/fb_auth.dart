import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';

class AuthService{

  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  //Create User object from FbUser
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Change User Stream
  Stream<User> get user {
    return _authInstance.onAuthStateChanged.map(_userFromFirebase);
  }

  //Anonymous Sign In
  Future anonSign() async {
    try{
      AuthResult result = await _authInstance.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //Email Password SignIn
  //Register Email Password
  //SignOut
  Future signOut() async {
    try{
      return await _authInstance.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}