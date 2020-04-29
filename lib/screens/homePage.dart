import 'package:carousel_pro/carousel_pro.dart';

import 'package:covid19/data/hive.dart';
import 'package:covid19/main.dart';
import 'package:covid19/screens/contributePage.dart';
import 'package:covid19/screens/faqPage.dart';
import 'package:covid19/screens/loginPage.dart';
import 'package:covid19/screens/myAccountPage.dart';
import 'package:covid19/services/authProvider.dart';
import 'package:covid19/services/provider.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:covid19/api/fetch.dart';
import 'package:covid19/data/global.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'indiaStatPage.dart';
import 'searchPage.dart';
import 'graphScreen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

const String testDevice = 'Mobile_id';

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  var countryStatList = [];

  @override
  void initState() {
    getData();
    initHive();
    // TODO: implement initState
    super.initState();
  }

  void showDialogBox(var context) {
    TextEditingController textEditingController = TextEditingController();
    slideDialog.showSlideDialog(
      context: context,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Add Country data",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth(context: context, devideBy: 20)),
            ),
          ),
          Container(
            width: screenWidth(context: context, devideBy: 1.1),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                controller: textEditingController,
                decoration: new InputDecoration.collapsed(
                    hintText: 'Enter the country name.'),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                autofocus: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  searchData(title: textEditingController.text);
                },
                child: Container(
                  height: screenHeight(context: context, devideBy: 20),
                  width: screenWidth(context: context, devideBy: 5),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "+Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth(context: context, devideBy: 25),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      barrierColor: Colors.white.withOpacity(0.2),
      pillColor: Colors.black,
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: LoadingScreen(),
            ),
          )
        : SafeArea(
            child: Scaffold(
              drawer: drawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                    getData();
                  });
                },
                child: Icon(Icons.refresh),
              ),
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
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    carouselSliderWidget(),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: topCardBuilder(context),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth(context: context, devideBy: 1.5),
                              screenHeight(context: context, devideBy: 9.5),
                              0,
                              8),
                          child: int.parse(statReport["total_cases"]
                                      .toString()
                                      .replaceAll(',', '')) !=
                                  increaseCases
                              ? Text("+ $increaseCases")
                              : Container(),
                        ),
                      ],
                    ),
                    addButtonRowBuilder(context),
                    ...countryStatList,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Created by Tanmoy karmakar"),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  drawer() {
    return FutureBuilder(
        future: Provider.of(context).auth.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return CircularProgressIndicator();
          else {
            final user = snapshot.data;
            String name = user.displayName;
            String email = user.email;
            String photoUrl = user.photoUrl;
            return Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    accountName: Text(
                      name,
                    ),
                    accountEmail: Text(
                      email,
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        photoUrl,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Homepage'),
                    onTap: () => Navigator.pop(context),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.insert_chart),
                    title: Text('Graphical Data'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BarChartSample1()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.monetization_on),
                      title: Text('Contribute'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContributePage(),
                          ),
                        );
                      }),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                      title: Text('FAQs'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FAQPage(),
                          ),
                        );
                      }),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await Provider.of(context).auth.signOut();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    title: Text(
                      'Sign out',
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  Container carouselSliderWidget() {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
          height: 200.0,
          child: Carousel(
            images: [
              NetworkImage(
                  'https://www.redcross.org/content/dam/redcross/about-us/news/2020/coronavirus-safety-tw.jpg'),
              NetworkImage(
                  'https://www.redcross.org/content/dam/redcross/about-us/news/2020/facemaskinfotw.jpg.transform/1288/q70/feature/image.jpeg'),
              NetworkImage(
                  "https://images.squarespace-cdn.com/content/5086f19ce4b0ad16ff15598d/1584056041141-V17JNA1OGEAZQ6XB9LJ2/COVIDSAFETYTIPS1.png?content-type=image%2Fpng"),
              NetworkImage(
                  "https://www.excel-urgentcare.com/wp-content/uploads/2020/03/Coronavirus-safety.jpg"),
              NetworkImage(
                  "https://img.dtnext.in/Articles/2020/Apr/202004010836296390_Donations-made-to-PMCARES-Fund-eligible-for-100pc-tax_SECVPF.gif"),
            ],
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Colors.transparent,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            borderRadius: true,
            moveIndicatorFromBottom: 180.0,
            autoplayDuration: Duration(seconds: 30),
            noRadiusForIndicator: true,
          )),
    );
  }

  Padding addButtonRowBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth(context: context, devideBy: 3),
              child: Text(
                "updated on: ${statReport["statistic_taken_at"]}",
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      countryStatList.clear();
                      setState(() {});
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showDialogBox(context);
                    },
                    child: Container(
                      height: screenHeight(context: context, devideBy: 20),
                      width: screenWidth(context: context, devideBy: 5),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "+Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                screenWidth(context: context, devideBy: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void getData() async {
    try {
      affectedCountry = await getAffectedCountry();
      statReport = await getTotalStat();
      casesByCountry = await getCasesByCountry();
      var temp = statReport["total_cases"].toString().replaceAll(',', '');
      increaseCases = int.parse(temp) - await box.get("totalCases");
      print("increased Cases=$increaseCases");
      box.put("totalCases", int.parse(temp));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.message);
      showSimpleNotification(
          Text(
            e.message,
            style: TextStyle(color: Colors.white),
          ),
          background: Colors.orange);
    }
  }

  void searchData({String title}) async {
    for (int i = 0; i < 201; i++) {
      if (casesByCountry["countries_stat"][i]["country_name"]
              .toString()
              .toLowerCase() ==
          title.toLowerCase()) {
        countryStatList.add(CountryStatBuilder(
          index: i,
        ));
        showSimpleNotification(
            Text(
              "Country added to the list",
              style: TextStyle(color: Colors.white),
            ),
            background: Colors.orange);

        setState(() {});
        Navigator.pop(context);
        break;
      }
    }
  }
}

class CountryStatBuilder extends StatelessWidget {
  int index;

  CountryStatBuilder({this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (casesByCountry["countries_stat"][index]["country_name"]
                .toString()
                .toLowerCase() ==
            "india") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IndiaStatPage(),
              ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: screenHeight(context: context, devideBy: 5),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  casesByCountry["countries_stat"][index]["country_name"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    titleCardBuilder(
                      context: context,
                      title: "Cases",
                      subTitle: casesByCountry["countries_stat"][index]
                          ["cases"],
                      color: [Color(0xffff9966), Color(0xfff80759)],
                    ),
                    titleCardBuilder(
                      context: context,
                      title: "Death",
                      subTitle: casesByCountry["countries_stat"][index]
                          ["deaths"],
                      color: [Color(0xffff9966), Color(0xfff80759)],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
