import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../widgets/HRMGraph.dart';
import '../widgets/HRMAppbar.dart';
import '../models/SensorValue.dart';

class HRMScreen extends StatefulWidget {
  @override
  HRMScreenView createState() => HRMScreenView();
}

class HRMScreenView extends State<HRMScreen>
    with SingleTickerProviderStateMixin {
  bool _toggled = false;
  List<SensorValue> _data = List<SensorValue>();
  CameraController _controller;
  double _alpha = 0.3;
  AnimationController _animationController;
  double _iconScale = 1;
  int _bpm = 0;
  int _fs = 30;
  int _windowLen = 30 * 6;
  CameraImage _image;
  double _avg;
  DateTime _now;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animationController
      ..addListener(() {
        setState(() {
          _iconScale = 1.0 + _animationController.value * 0.4;
        });
      });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _toggled = false;
    _disposeController();
    Wakelock.disable();
    _animationController?.stop();
    _animationController?.dispose();
    super.dispose();
  }

  void _clearData() {
    _data.clear();
    int now = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < _windowLen; i++) {
      _data.insert(
        0,
        SensorValue(
            DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 128),
      );
    }
  }

  void _toggle() {
    _clearData();
    _initController().then((onValue) {
      Wakelock.enable();
      _animationController?.repeat(reverse: true);
      setState(() {
        _toggled = true;
      });
      _initTimer();
      _updateBPM();
    });
  }

  void _untoggle() {
    _disposeController();
    Wakelock.disable();
    _animationController?.stop();
    _animationController?.value = 0.0;
    setState(() {
      _toggled = false;
    });
  }

  void _disposeController() {
    _controller?.dispose();
    _controller = null;
  }

  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, ResolutionPreset.low);
      await _controller.initialize();
      _controller.startImageStream((CameraImage image) {
        _image = image;
      });
    } catch (Exception) {
      debugPrint(Exception);
    }
  }

  void _initTimer() {
    _timer = Timer.periodic(
      Duration(milliseconds: 1000 ~/ _fs),
      (timer) {
        if (_toggled) {
          if (_image != null) _scanImage(_image);
        } else {
          timer.cancel();
        }
      },
    );
  }

  void _scanImage(CameraImage image) {
    _now = DateTime.now();
    _avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
    if (_data.length >= _windowLen) {
      _data.removeAt(0);
    }
    setState(() {
      _data.add(SensorValue(_now, _avg));
    });
  }

  void _updateBPM() async {
    List<SensorValue> _values;
    double _avg;
    int _n;
    double _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    while (_toggled) {
      _values = List.from(_data);
      _avg = 0;
      _n = _values.length;
      _m = 0;
      _values.forEach((SensorValue value) {
        _avg += value.value / _n;
        if (value.value > _m) _m = value.value;
      });
      _threshold = (_m + _avg) / 2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
            _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm += 60 *
                1000 /
                (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        print(_bpm);
        setState(() {
          this._bpm = ((1 - _alpha) * this._bpm + _alpha * _bpm).toInt();
        });
      }
      await Future.delayed(
        Duration(milliseconds: 1000 * _windowLen ~/ _fs),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hrmAppBar(context, 'Heart Rate Monitor'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  feed(),
                  counter(),
                ],
              ),
            ),
            heartTrigger(),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Colors.blue[900],
                ),
                child: HRMGraph(_data),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget feed() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              _controller != null && _toggled
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    )
                  : Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.8),
                    ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                child: Text(
                  _toggled
                      ? "Place your finger over the rear camera"
                      : "Camera feed will be shown here",
                  style: TextStyle(
                    backgroundColor: _toggled
                        ? Colors.white.withOpacity(0.8)
                        : Colors.transparent,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget counter() {
    return Expanded(
      flex: 1,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Approximate BPM",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Varela',
            ),
          ),
          Text(
            (_bpm > 30 && _bpm < 150 ? _bpm.toString() : "--"),
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }

  Widget heartTrigger() {
    return Expanded(
      flex: 1,
      child: Center(
        child: Transform.scale(
          scale: _iconScale,
          child: IconButton(
            icon: Icon(
              _toggled ? Icons.favorite : Icons.favorite_border,
            ),
            color: Colors.pink[600],
            iconSize: 128,
            onPressed: () {
              if (_toggled) {
                _untoggle();
              } else {
                _toggle();
              }
            },
          ),
        ),
      ),
    );
  }
}
