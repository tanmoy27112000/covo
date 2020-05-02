import 'package:covid19/data/global.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  List data = casesByCountry["countries_stat"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenWidth(context: context, devideBy: 1.1),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            onChanged: (value) {
                              print(data);
                              setState(() {});
                            },
                            controller: textEditingController,
                            decoration: new InputDecoration.collapsed(
                                hintText: 'Enter the country name.'),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            autofocus: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return data[index]["country_name"]
                                .toString()
                                .toLowerCase()
                                .contains(textEditingController.text)
                            ? CountryStatBuilder(
                                index: index,
                              )
                            : Container();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
