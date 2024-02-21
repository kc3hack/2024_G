import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key,}) : super(key: key);

  @override
  MySearchBarState createState() => MySearchBarState();
}

class MySearchBarState extends State<MySearchBar> {
  // テキストフィールドコントローラーの宣言
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(

      /* ------ ここから検索バーの位置を指定するための処理 ------ */

      top: 16.0,
      left: 16.0,
      right: 16.0,

      /* ------ 　　　　　　　　　ここまで　　　　　　　　　 ------ */

      /* ------ここから検索バーに影をつけるための処理 ------ */
      child: Container(
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

        /* ------ 　　　　　　　　ここまで　　　　　　　　 ------ */

        child: TextField( // テキストフィールド
          controller: _searchController,  // テキストフィールドのコントローラーを設定
          decoration: InputDecoration(
            hintText: '目的地を検索',
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
    );
  }
}