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
    return Scaffold(
      // appBar: AppBar(
      //   title: const SizedBox(
      //     child: MySearchBar(),
      //   ),
      // ),
      body:Stack(
        children: [
          const MyMap(),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const MySearchBar(),
            ),
          // Align(
          //   alignment: Alignment(0, -1),
          //
          //   child: MySearchBar(),
          // ),
        ],
      ),
    );
  }
}