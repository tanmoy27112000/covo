import 'package:covid19/screens/homePage.dart';
import 'package:covid19/services/database.dart';
import 'package:covid19/services/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String test;
  String members;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                test = value;
              });
            },
            textAlign: TextAlign.center,
            decoration:
                InputDecoration(hintText: 'Are you tested covid +ve?(y/n)'),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                members = value;
              });
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: (InputDecoration(
                hintText: 'How many family members you have?')),
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  _submit() async {
    final FirebaseUser user = await Provider.of(context).auth.getCurrentUser();
    await DatabaseService(user.uid).createUserData(
        user.displayName, user.email, user.photoUrl, test, members);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}
