import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:yash_practical/commons/widgets/components.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, this.postId});

  final int? postId;

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late int _seconds;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    _seconds = [10, 20, 25][DateTime.now().millisecond % 3];

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isVisible && mounted) {
        setState(() {
          if (_seconds > 0) _seconds--;
        });
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.postId.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0) {
          _isVisible = true;
          _stopTimer();
          _startTimer();
        } else {
          _isVisible = false;
          _stopTimer();
        }
      },
      child: TextLabel(text: '$_seconds s'),
    );
  }
}
