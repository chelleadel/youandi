import 'package:flutter/material.dart';
import 'package:test/question15.dart';
import 'package:test/question2.dart';

class Question3 extends StatefulWidget {

  @override
  _Question3 createState() => _Question3();
}


class _Question3 extends State<Question3> {

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
        scaffoldBackgroundColor: Colors.yellow.shade100,
        ),
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Age Preference',
              style: TextStyle(fontSize: 48,
                fontFamily: 'BubblerOne',
                color: Colors.black,),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Question2()),
                  );
                },
                child: Text('Ok',
                  style: TextStyle(
                    fontSize: 16, color: Colors.black,),),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(145, 50),
                  primary: Colors.cyanAccent.shade100,
                )
            ),
            SizedBox(height: 35),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Question15()),
                  );
                },
                child: Text('Back',
                  style: TextStyle(fontSize: 16, color: Colors.black,),),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(145, 50),
                  primary: Colors.cyanAccent.shade100,
                )
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