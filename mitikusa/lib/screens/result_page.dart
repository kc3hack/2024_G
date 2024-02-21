import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyResultPage extends StatelessWidget {
  final Position depart;
  final Position destination;

  const MyResultPage({Key? key, required this.depart, required this.destination}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('検索結果'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('出発地: $depart'),
            Text('目的地: $destination'),
          ],
        ),
      ),
    );
  }
}