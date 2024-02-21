import 'package:flutter/material.dart';
import 'package:mitikusa/components/search_bar.dart';
import 'package:mitikusa/map_state.dart';

class MyTop extends StatefulWidget {
  const MyTop({Key? key,}) : super(key: key);

  @override
  State<MyTop> createState() => MyTopState();
}

class MyTopState extends State<MyTop> {

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body:Stack( // Mapの上に検索バーをおく
        children: [
          MyMap(),
          MySearchBar(),
        ],
      ),
    );
  }
}