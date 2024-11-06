import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(CountdownApp());

class CountdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountdownPage(),
    );
  }
}

class CountdownPage extends StatefulWidget {
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  int _seconds = 60; // Thời gian đếm ngược ban đầu (60 giây)
  Timer? _timer;
  String message = '';

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      message = '';
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 10) {
          message = 'Time is running out';
        }
        if (_seconds > 0) {
          _seconds--;
        } else {
          message = 'time out';
          _timer!.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    setState(() {
      message = '';
      _seconds = 60;
      if (_timer != null) {
        _timer!.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_seconds',
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  child: const Text('Start Timer'),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset Timer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
