import 'package:covid19/data/global.dart';
import 'package:flutter/material.dart';
import '../api/fetch.dart';

class IndiaStatPage extends StatefulWidget {
  IndiaStatPage({Key key}) : super(key: key);

  @override
  _IndiaStatPageState createState() => _IndiaStatPageState();
}

class _IndiaStatPageState extends State<IndiaStatPage> {
  var data;
  var isLoading = true;
  List state = [];
  List stateCase = [];
  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var _scrollController;
    return isLoading
        ? Scaffold(
      backgroundColor: Colors.black,
            body: Center(
              child: LoadingScreen(),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: Container(
                width: screenWidth(context: context, devideBy: 1),
                height: screenHeight(context: context, devideBy: 1),
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: state.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 3),
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // return titleCardBuilder(
                    //   context: context,
                    //   title: state[index],
                    //   subTitle: stateCase[index].toString(),
                    //   color: [Color(0xffff9966), Color(0xfff80759)],
                    // );
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [Color(0xffff9966), Color(0xfff80759)]),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            state[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  screenWidth(context: context, devideBy: 20),
                            ),
                          ),
                          Text(
                            stateCase[index].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  screenWidth(context: context, devideBy: 15),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }

  void getData() async {
    data = await getStateData();
    for (var key in data.keys) {
      state.add(key);
    }
    for (var value in data.values) {
      stateCase.add(value);
    }
    isLoading = false;
    setState(() {});
  }
}
