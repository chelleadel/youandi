import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/question15.dart';
import 'package:test/question2.dart';
import 'package:test/constants.dart';

import 'services/firebase.dart';

// Lower/Upper Age preference; LowerAgePreference, UpperAgePreference
class Question3 extends StatefulWidget {
  @override
  _Question3 createState() => _Question3();
}


class _Question3 extends State<Question3> {
  var currentUser = FirebaseAuth.instance.currentUser;

  double start = 0.25;
  double end = 0.75;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double rsWidth =size.width*0.75;
    double rsHeight = rsWidth*0.25;

    // 0.05 is 1 age

    int scalc = (start / 0.05).toInt() + 15;
    int ecalc = (end / 0.05).toInt() + 15;



    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        scaffoldBackgroundColor: Constants.BG_BASE,
        ),
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Age Preference',
              style: TextStyle(
                fontSize: Constants.TITLE_SIZE,
                fontFamily: Constants.FONT_BASE,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            CustomRangeSelector(
                start: start,
                end: end,
                divisions: 20,

                onStartChange: (value){
                  setState(() {
                    start = value;
                  });
                },

                onEndChange: (value){
                  setState(() {
                    end= value;
                  });
                },

                width: rsWidth,
                height: rsHeight
            ),
            SizedBox(height: 15),
            Text(
              "Start: $scalc   |   End: $ecalc",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Firebase.UPDATE_USER_INT(currentUser!.uid, "LowerAgePreference", scalc);
                Firebase.UPDATE_USER_INT(currentUser!.uid, "UpperAgePreference", ecalc);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Question2()),
                );
              },
              child: Text('Next',
                style: TextStyle(
                  fontSize: Constants.BUTTON_FONT_SIZE,
                  color: Colors.black,
                  fontFamily: Constants.BUTTON_FONT,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Constants.BG_BASE),
                  fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                        side: BorderSide(color: Colors.black)
                      )
                  )
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Question15()),
                );
              },
              child: Text('Back',
                style: TextStyle(
                    fontSize: Constants.BUTTON_FONT_SIZE,
                    color: Colors.black,
                    fontFamily: Constants.BUTTON_FONT),),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Constants.BG_BASE),
                  fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                        side: BorderSide(color: Colors.black)
                      )
                  )
              ),
            ),

          ],
        )
      )
    )
    );
  }
}


class CustomRangeSelector extends StatefulWidget {

  final double start;
  final double end;
  final int divisions;
  final Function(double start) onStartChange;
  final Function(double start) onEndChange;
  final double width;
  final double height;

  CustomRangeSelector({required this.start, required this.end, required this.divisions, required this.onStartChange, required this.onEndChange, required this.width, required this.height})
      : super();

  @override
  State<CustomRangeSelector> createState() => _CustomRangeSelector();
}

class _CustomRangeSelector extends State<CustomRangeSelector> {

  double barHeight = 0;
  List<Widget> topDividers = [], bottomDividers = [];

  double startPosition = 0;
  double endPosition = 0;

  @override
  void initState() {
    super.initState();

    startPosition = widget.start * widget.width;
    endPosition = widget.end * widget.width;

    barHeight = widget.height * 0.75;
    double markerDistance = widget.width / widget.divisions;
    List markers = List.generate(widget.divisions - 1, (index) => (markerDistance) * (index + 1));

    topDividers = markers
        .map((mp) => Positioned(
      top: 0,
      left: mp - 1,
      child: Container(
        color: Colors.black,
        height: 10,
        width: 2,
      ),
    ))
        .toList();

    bottomDividers = markers
        .map((mp) => Positioned(
      bottom: 0,
      left: mp - 1,
      child: Container(
        color: Colors.black,
        height: 10,
        width: 2,
      ),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(
            height: barHeight,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: Stack(
              children: [
                ...topDividers,
                ...bottomDividers,
              ],
            ),
          ),
          Positioned(
              top: 0,
              left: startPosition - 1,
              child: Container(
                width: 2,
                height: barHeight,
                color: Colors.red,
              )),
          Positioned(
              top: 0,
              left: endPosition - 1,
              child: Container(
                width: 2,
                height: barHeight,
                color: Colors.red,
              )),
          Positioned(
              bottom: 0,
              left: startPosition - 10,
              child: GestureDetector(
                onPanUpdate: (panUpdate) {
                  double newPosition = (startPosition + panUpdate.delta.dx).clamp(0.0, widget.width);
                  if (newPosition <= endPosition - 10) {
                    widget.onStartChange(double.parse((newPosition / widget.width).toStringAsFixed(2)));
                    setState(() {
                      startPosition = newPosition;
                    });
                  }
                },
                child: Container(
                  width: 20,
                  height: widget.height - barHeight,
                  color: Colors.red,
                ),
              )),
          Positioned(
              bottom: 0,
              left: endPosition - 10,
              child: GestureDetector(
                onPanUpdate: (panUpdate) {
                  double newPosition = (endPosition + panUpdate.delta.dx).clamp(0.0, widget.width);
                  if (newPosition >= startPosition + 10) {
                    widget.onEndChange(double.parse((newPosition / widget.width).toStringAsFixed(2)));
                    setState(() {
                      endPosition = newPosition;
                    });
                  }
                },
                child: Container(
                  width: 20,
                  height: widget.height - barHeight,
                  color: Colors.red,
                ),
              )),
          Positioned(
              top: 0,
              left: startPosition,
              child: Container(
                width: endPosition - startPosition,
                height: barHeight,
                color: Colors.deepOrange.withAlpha(100),
              ))
        ],
      ),
    );
  }
}