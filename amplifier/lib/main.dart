// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_import
import 'dart:math';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  // Define parameters
  double amplitude = 50.0;
  double frequency = 20.0;
  double phaseShift = 0.0;
  int numSamples = 100;
  List _data = [];
  @override
  void initState() {
    super.initState();
    _generateSineWaveData();
  }

  void _generateSineWaveData() {
    _data = [];
    for (int i = 0; i < numSamples; i++) {
      double x = 2 * pi * i / numSamples;
      double y = amplitude * sin(2 * pi * frequency * x + phaseShift);
      _data.add(y);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sine Wave Generator'),
        ),
        body: Column(
          children: [
            // Parameters sliders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Amplitude: ${amplitude.toStringAsFixed(2)}'),
                Slider(
                  value: amplitude,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (value) => setState(() => amplitude = value),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Frequency: ${frequency.toStringAsFixed(2)} Hz'),
                Slider(
                  value: frequency,
                  min: 0.0,
                  max: 20000.0,
                  onChanged: (value) => setState(() => frequency = value),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Phase Shift: ${phaseShift.toStringAsFixed(2)} π'),
                Slider(
                  value: phaseShift,
                  min: 0.0,
                  max: 2 * pi,
                  onChanged: (value) => setState(() => phaseShift = value),
                ),
              ],
            ),
            // Generate button
            ElevatedButton(
              child: const Text('Generate'),
              onPressed: () => setState(() => _generateSineWaveData()),
            ), // Sine wave graph
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: CustomPaint(
                  painter: SineWavePainter(_data),
                  size: Size.infinite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SineWavePainter extends CustomPainter {
  final List data;
  SineWavePainter(this.data);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;
    final path = Path();
    final centerY = size.height / 2.0;
    path.moveTo(0.0, centerY + data[0]);
    for (int i = 1; i < data.length; i++) {
      double x = size.width * i / (data.length - 1);
      double y = centerY + data[i];
      path.lineTo(x, y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
