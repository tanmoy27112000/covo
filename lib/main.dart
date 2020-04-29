import 'package:covid19/data/global.dart';
import 'package:covid19/screens/homePage.dart';
import 'package:covid19/screens/loginPage.dart';
import 'package:covid19/services/authProvider.dart';
import 'package:covid19/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:getflutter/getflutter.dart';
import 'data/hive.dart';

const String testDevice = 'Mobile_id';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  void initState() {}

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
      return Provider(
        auth: AuthProvider(),
        child: OverlaySupport(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Montserrat',
            ),
            title: 'Material App',
            home: HomeController(),
          ),
        ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            return signedIn ? HomePage(): LoginPage();
          }
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()));
        });
  }
}
