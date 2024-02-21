import 'package:flutter/material.dart';

class MyInputPage extends StatefulWidget {
  const MyInputPage({Key? key,}) : super(key: key);

  @override
  State<MyInputPage> createState() => MyInputPageState();
}

class MyInputPageState extends State<MyInputPage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
      ),
    );
  }
}