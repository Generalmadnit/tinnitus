// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:amplifier/main.dart';
import 'package:amplifier/record.dart'

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  final routes = {
    '/record': (context) => Record(),
    '/generate': (context) => SimpleRecorder(),
  };

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MaterialApp(
      home: MainPage(),
      routes: routes,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record and Generate'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Disclaimer text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'This app allows you to record audio and generate something based on it. Please use it responsibly.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/record'),
                child: const Text('Record Audio'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/generate'),
                child: const Text('Generate Content'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
