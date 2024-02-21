import 'package:flutter/material.dart';

class MyResultPage extends StatelessWidget {
  const MyResultPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('検索結果'),
        )
    );
  }
}