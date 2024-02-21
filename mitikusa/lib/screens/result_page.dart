import 'package:flutter/material.dart';

class MyResultPage extends StatelessWidget {
  final String depart;
  final String destination;

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
            const Text('次のページに渡されたデータ1:'),
            const SizedBox(height: 8.0),
            Text(depart),
            const SizedBox(height: 16.0),
            const Text('次のページに渡されたデータ2:'),
            const SizedBox(height: 8.0),
            Text(destination),
          ],
        ),
      ),
    );
  }
}