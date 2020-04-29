import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/screens/editAccountPage.dart';
import 'package:covid19/services/database.dart';
import 'package:covid19/services/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('My Account'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditAccountPage()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
      body: MainTheme(),
    );
  }
}

class MainTheme extends StatefulWidget {
  @override
  _MainThemeState createState() => _MainThemeState();
}

class _MainThemeState extends State<MainTheme> {
  String name;
  String email;
  String photourl;
  String test;
  String members;

  getValues()async{
      name=await getValue(context, 'Name');
      photourl=await getValue(context,'Photo url');
      email=await getValue(context,'Email');
      test=await getValue(context,'Covid Test');
      members=await getValue(context,'Family Members');
  }

  @override
  void initState() {
    setState(() {
      getValues();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.15,
           // child: Image.network(photourl),
          ),
          Container(
            //color: Colors.white,
            child: Column(
              children: <Widget>[
                Text('Name: $name'),
                Text('Email: $email'),
                Text('Covid Test: $test'),
                Text('Family Members: $members')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getValue(BuildContext context,String key)async{
    final FirebaseUser user = await Provider.of(context).auth.getCurrentUser();
    CollectionReference usersCollection = Firestore.instance.collection('Users');
    return await usersCollection.document(user.uid).get().then((snapshot) {
      if (snapshot.exists) {
        print(snapshot.data[key]);
        return snapshot.data[key];
      } else
        return '';
    }).catchError((e) => print(e));
    //return await DatabaseService(user.uid).fetchUserData(key).;
  }
}
