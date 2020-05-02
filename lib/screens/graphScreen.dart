import 'dart:async';
import 'dart:math';

import 'package:covid19/data/global.dart';
import 'package:covid19/screens/searchPage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.pink,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Most affected country',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          // Text(
                          //   'Grafik konsumsi kalori',
                          //   style: TextStyle(
                          //       color: const Color(0xff379982),
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          const SizedBox(
                            height: 38,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: BarChart(
                                isPlaying ? randomData() : mainBarData(),
                                swapAnimationDuration: animDuration,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Align(
                    //     alignment: Alignment.topRight,
                    //     child: IconButton(
                    //       icon: Icon(
                    //         isPlaying ? Icons.pause : Icons.play_arrow,
                    //         color: const Color(0xff0f4a3c),
                    //       ),
                    //       onPressed: () {
                    //         setState(() {
                    //           isPlaying = !isPlaying;
                    //           if (isPlaying) {
                    //             refreshState();
                    //           }
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0,
                double.parse(casesByCountry["countries_stat"][1]["cases"]
                    .toString()
                    .replaceAll(',', '')),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(
                1,
                double.parse(casesByCountry["countries_stat"][3]["cases"]
                    .toString()
                    .replaceAll(',', '')),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                2,
                double.parse(casesByCountry["countries_stat"][16]["cases"]
                    .toString()
                    .replaceAll(',', '')),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                3,
                double.parse(casesByCountry["countries_stat"][212]["cases"]
                    .toString()
                    .replaceAll(',', '')),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                4,
                double.parse(casesByCountry["countries_stat"][2]["cases"]
                    .toString()
                    .replaceAll(',', '')),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(
                5,
                double.parse(casesByCountry["countries_stat"][4]["cases"]
                    .toString()
                    .replaceAll(',', '')),
                isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'USA';
                  break;
                case 1:
                  weekDay = 'Italy';
                  break;
                case 2:
                  weekDay = 'india';
                  break;
                case 3:
                  weekDay = 'China';
                  break;
                case 4:
                  weekDay = "Spain";
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'USA';
              case 1:
                return 'ITALY';
              case 2:
                return 'INDIA';
              case 3:
                return 'CHINA';
                break;
              case 4:
                return "SPAIN";
                break;
              case 5:
                return "FRANCE";
                break;
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'USA';
              case 1:
                return 'ITALY';
              case 2:
                return 'INDIA';
              case 3:
                return 'CHINA';
              case 4:
                return 'SPAIN';
              case 5:
                return 'FRANCE';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(4, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          // case 4:
          //   return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
          //       barColor: widget.availableColors[
          //           Random().nextInt(widget.availableColors.length)]);
          // case 5:
          //   return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
          //       barColor: widget.availableColors[
          //           Random().nextInt(widget.availableColors.length)]);
          // case 6:
          //   return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
          //       barColor: widget.availableColors[
          //           Random().nextInt(widget.availableColors.length)]);
          default:
            return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}
