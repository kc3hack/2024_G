import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key,}) : super(key: key);

  @override
  MySearchBarState createState() => MySearchBarState();
}

class MySearchBarState extends State<MySearchBar> {
  // テキストフィールドコントローラーの宣言
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(

      /* ------ここから検索バーに影をつけるための処理 ------ */

      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(60),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 5),
            ],
          ),
        ),

        /* ------　　　　　　　　ここまで　　　　　　　　------ */

        SizedBox(
          height: 60,
          child: TextField( // テキストフィールド
            controller: _controller,  // テキストフィールドのコントローラーを設定
            decoration: InputDecoration(
              hintText: '検索',
              filled: true,
              fillColor: Colors.grey.shade300,
              suffixIcon: const IconButton( // 検索バーの右にメニューボタンを表示する
                onPressed: null/* 表示できるものがないので仮でnullを置いておく */,
                icon: Icon(Icons.menu),
                iconSize: 30,
                padding: EdgeInsets.only(right: 15.0),
              ),
              border: OutlineInputBorder( // 検索バーのボーダースタイルを設定する
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (text) { // テキストが変わったら出力する
              debugPrint("Current text: $text");
            },
          ),
        ),
      ],
    );
  }
}