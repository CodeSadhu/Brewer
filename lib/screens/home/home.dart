import 'package:flutter/material.dart';
import 'package:brew_crew/services/fb_auth.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _authService = AuthService();
  final formKey = GlobalKey<FormState>();
  String phoneNo, verId, smsCode, verSms;
	bool sentCode = false;

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
      body: Column(
        children: <Widget>[
          Padding(
						padding: EdgeInsets.only(left: 25.0, right: 25.0),
						child: RaisedButton(
							child: Center(
								child: Text("Verify"),
							),
							onPressed: (){
								return showModalBottomSheet(
									context: context,
									builder: (BuildContext bc){
										return Form(
											key: formKey,
											child: Column(
												mainAxisAlignment: MainAxisAlignment.center,
												children: <Widget>[
													sentCode ? Container() : Padding(
														padding: EdgeInsets.only(left: 25.0, right: 25.0),
														child: TextFormField(
															keyboardType: TextInputType.phone,
															decoration: InputDecoration(hintText: "Enter Phone Number"),
															onChanged: (val) {
																setState(() {
																	this.phoneNo = val;
																});
															},
														),
													),
													sentCode ? Padding(
														padding: EdgeInsets.only(left: 25.0, right: 25.0),
														child: TextFormField(
															keyboardType: TextInputType.phone,
															decoration: InputDecoration(hintText: "Enter OTP"),
															onChanged: (val) {
																setState(() {
																	this.smsCode = val;
																});
															},
														),
													) : Container(),
													Padding(
														padding: EdgeInsets.only(left: 25.0, right: 25.0),
														child: RaisedButton(
															child: Center(
																child: sentCode ? Text("Login") : Text("Verify"),
															),
															onPressed: (){
																sentCode ? _authService.signInViaOTP(smsCode, verId) : verifyNum(phoneNo);
															},
														),
													)
												],
											),
										);
									}
								);
							},
						),
					),
        ],
      ),
    );    
  }
  Future<void> verifyNum(num) async{
		final PhoneVerificationCompleted verified = (AuthCredential authRes){
			_authService.signIn(authRes);
		};
		final PhoneVerificationFailed failed = (AuthException authExcep){
		
		};
		final PhoneCodeSent smsSent = (String verId, [int forceResend]){
			this.verId = verId;
      this.sentCode = !sentCode;
		};
		final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId){
			this.verId = verId;
		};
		
		await FirebaseAuth.instance.verifyPhoneNumber(
			phoneNumber: num,
			timeout: const Duration(seconds: 5),
			verificationCompleted: verified,
			verificationFailed: failed,
			codeSent: smsSent,
			codeAutoRetrievalTimeout: autoTimeOut
		);
    
	}
}