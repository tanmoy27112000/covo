import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List affectedCountry;
var statReport;
var casesByCountry;
int increaseCases;
screenWidth({@required var context, @required double devideBy}) {
  return MediaQuery.of(context).size.width / devideBy;
}

var kTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  letterSpacing: 1,
);

Text buildbuttonText({String title}) {
  return Text(
    title,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );
}

screenHeight({@required var context, @required double devideBy}) {
  return MediaQuery.of(context).size.height / devideBy;
}

Expanded titleCardBuilder(
    {BuildContext context, String title, String subTitle, var color}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: color,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth(context: context, devideBy: 25),
                ),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth(context: context, devideBy: 15),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Container topCardBuilder(BuildContext context) {
  return Container(
    height: screenHeight(context: context, devideBy: 2),
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              titleCardBuilder(
                context: context,
                title: "Total Cases",
                subTitle: statReport["total_cases"].toString(),
                color: [Color(0xffbc4e9c), Color(0xfff80759)],
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              titleCardBuilder(
                context: context,
                title: "Affected Country",
                subTitle: affectedCountry.length.toString(),
                color: [Color(0xffff9966), Color(0xfff80759)],
              ),
              titleCardBuilder(
                context: context,
                title: "Total Death",
                subTitle: statReport["total_deaths"].toString(),
                color: [Color(0xff30E8BF), Color(0xffFF8235)],
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              titleCardBuilder(
                context: context,
                title: "New Cases",
                subTitle: statReport["new_cases"].toString(),
                color: [Color(0xff4568DC), Color(0xffB06AB3)],
              ),
              titleCardBuilder(
                context: context,
                title: "Total Recovered",
                subTitle: statReport["total_recovered"].toString(),
                color: [Color(0xff3494E6), Color(0xffEC6EAD)],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildLoading();
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        SizedBox(
//          width: 250.0,
//          child: TypewriterAnimatedTextKit(
//              isRepeatingAnimation: true,
//              totalRepeatCount: 3,
//              onTap: () {
//                print("Tap Event");
//              },
//              text: [
//                "covid",
//                "A deadly disease without any treatment",
//                "spreading all over the world",
//                "Lets,look at the stats!",
//              ],
//              textStyle: TextStyle(fontSize: 30.0),
//              textAlign: TextAlign.start,
//              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
//              ),
//        )
//      ],
//    );
  }

}
Widget _buildLoading() {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    backgroundColor: Colors.black,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(height: 24),
          Text(
            'Fetching latest updates',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

var appBar = AppBar(
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
      onPressed: () {},
    )
  ],
);
