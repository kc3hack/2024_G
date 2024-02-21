import 'package:flutter/material.dart';

class MyInputPage extends StatefulWidget {
  final String destination;
  const MyInputPage({Key? key, required this.destination}) : super(key: key);

  @override
  State<MyInputPage> createState() => MyInputPageState();
}

class MyInputPageState extends State<MyInputPage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page ${widget.destination}'),
      ),
    );
  }
}