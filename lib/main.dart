import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getLocation() async {
    determinePosition();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print('hello world ${position.latitude}  + ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.redAccent,
              child: const Center(
                child: Text(
                  '25"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.amber,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text('18"'),
                      ),
                      Expanded(
                        child: Text('25"'),
                      ),
                      Expanded(
                        child: Text('27"'),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text('min"'),
                      ),
                      Expanded(
                        child: Text('current"'),
                      ),
                      Expanded(
                        child: Text('max"'),
                      ),
                    ],
                  )
                ],
              ),
              
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getLocation();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}
