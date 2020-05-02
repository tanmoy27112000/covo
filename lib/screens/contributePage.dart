import 'package:covid19/data/global.dart';
import 'package:covid19/screens/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

class ContributePage extends StatefulWidget {
  ContributePage({Key key}) : super(key: key);

  @override
  _ContributePageState createState() => _ContributePageState();
}

class _ContributePageState extends State<ContributePage> {
  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "COVO Stats",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ));
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                buildContributePage(context),
                buildWHOPage(context),
               
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'WE ARE TOGETHER IN THE FIGHT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContributePage(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: screenWidth(context: context, devideBy: 2),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2020/03/pm-care-fund-1585481334.jpg")),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              )),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Colors.white60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "UPI: pmcares@sbi",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: "pmcares@sbi"));
                    showSimpleNotification(
                        Text(
                          "UPI copied. Now open gpay to contribute",
                          style: TextStyle(color: Colors.white),
                        ),
                        background: Colors.green);
                  },
                  child: Container(
                    width: screenWidth(context: context, devideBy: 5),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("COPY"),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Container buildWHOPage(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: screenWidth(context: context, devideBy: 2),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://www.nemours.org/content/dam/nemours/wwwv2/childrens-health-system/promo/coronavirus-hero-goods-food-funds.jpg")),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              )),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Colors.white60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Donate worldwide",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    launch('https://covid19responsefund.org/');
                  },
                  child: Container(
                    width: screenWidth(context: context, devideBy: 5),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("VISIT"),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
