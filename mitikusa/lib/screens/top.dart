import 'package:flutter/material.dart';
import 'package:mitikusa/components/map_state.dart';
import 'package:mitikusa/components/search_bar.dart';

class MyTop extends StatefulWidget {
  const MyTop({
    Key? key,
  }) : super(key: key);

  @override
  State<MyTop> createState() => MyTopState();
}

class MyTopState extends State<MyTop> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        // Mapの上に検索バーをおく
        children: [
          MyMap(padding: EdgeInsets.only(top: 100.0)),
          MySearchBar(),
        ],
      ),
    );
  }
}
