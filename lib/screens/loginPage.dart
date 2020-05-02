import 'package:covid19/data/global.dart';
import 'package:covid19/screens/homePage.dart';
import 'package:covid19/services/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

var kBackgroundImage = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/corona_bg.jpg"),
    fit: BoxFit.cover,
  ),
);

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of(context).auth;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: kBackgroundImage,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 15,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "to",
                          style: kTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Covostat",
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: SizedBox(
                      height: 10,
                      width: 500,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Text(
                      "Built for the influencers of \nthe future.",
                      // style: kTextStyle.copyWith(
                      //   fontSize: screenWidth / 22,
                      //   fontWeight: FontWeight.w600,
                      // ),
                    ),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: screenWidth / 6,
                child: Column(
                  children: <Widget>[
                    // Expanded(
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //             horizontal: 20.0,
                    //             vertical: 8,
                    //           ),
                    //           child: InkWell(
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               child: Center(
                    //                 child: buildbuttonText(title: "Sign In"),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //             horizontal: 20.0,
                    //             vertical: 8,
                    //           ),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //             child: Center(
                    //               child: buildbuttonText(title: "SignUp"),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 8,
                        ),
                        child: InkWell(
                          onTap: () async {
                            try {
                              bool isNewUser=await auth.loginWithGoogle();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } catch (e) {
                              print(e.message);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: buildbuttonText(title: "LogIn / SignUp"),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
