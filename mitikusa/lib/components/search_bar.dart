import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key,}) : super(key: key);

  @override
  MySearchBarState createState() => MySearchBarState();
}

class MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: '検索',
        border: OutlineInputBorder(),
      ),
      onChanged: (text) {
        print("Current text: $text");
      },

    );
  }
}