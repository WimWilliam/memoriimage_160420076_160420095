import 'package:percent_indicator/percent_indicator.dart'; 
import 'package:flutter/material.dart';
import 'dart:async';


class Game extends StatefulWidget {
  const Game({super.key});
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int _initValue =30;
  int _hitung = 30;
  late Timer _timer;

  @override // add “late” to initialize it later in initState() @override
   void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
      setState(() {
        //_hitung++;
      });
    });
   }

   void dispose() {
    _timer.cancel();
    _hitung = 0;
    super.dispose();
  }

  Timer startTimer() {
     return _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
    setState(() {
      if(_hitung > 0) {
        _hitung--;
      }
      else {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Time App'),
              content: Text('Quiz is finished'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));
        startTimer().cancel();
    }
     });
    }
    );
  }

  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');	
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }


  Widget build(BuildContext context) {
    // returnint _hitung = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
          child: Column(children: <Widget>[
            LinearPercentIndicator(
              center: Text(formatTime(_hitung)),
              width: MediaQuery.of(context).size.width,
              lineHeight: 20.0,
              percent: 1 - (_hitung / _initValue),
              backgroundColor: Colors.grey,
              progressColor: Colors.red,
          
            ),

            Text(_hitung.toString(),
              style: const TextStyle(
                fontSize: 24,
            )),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _timer.isActive ? _timer.cancel() : startTimer();
                
                });
              },
              child: Text(_timer.isActive ? "Stop" : "Start")
		        )

      ])),
    );

}
}