// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestMicPermission() async {
  var status = await Permission.microphone.status;
  if (status.isDenied) {
    status = await Permission.microphone.request();
  }
  return status.isGranted;
}

final _recorder = FlutterSoundPlayer();

Future<void> initRecorder() async {
  await _recorder.initialize();
}

Future<void> startRecording() async {
  final path = await getApplicationDocumentsDirectory();
  final filePath = '${path.path}/recording.pcm';
  await _recorder.startRecorder(filePath);
}

Future<void> stopRecording() async {
  await _recorder.stopRecorder();
}

Future<void> playRecording() async {
  final path = await getApplicationDocumentsDirectory();
  final filePath = '${path.path}/recording.pcm';
  await _recorder.playSound(filePath);
}
