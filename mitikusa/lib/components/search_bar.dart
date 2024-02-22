import 'package:flutter/material.dart';
import 'package:mitikusa/screens/input_page.dart';

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

      top: 30.0,
      left: 16.0,
      right: 16.0,

      /* ------ 　　　　　　　　　ここまで　　　　　　　　　 ------ */

      child: Container(

        /* ------ここから検索バーに影をつけるための処理 ------ */

        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(60),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 5, spreadRadius: 5),
          ],
        ),

        /* ------ 　　　　　　　ここまで　　　　　　　 ------ */

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

          /* ------ここから入力完了後にする処理 ------ */

        onSubmitted: (String destination) {
            // 入力後に詳しい情報入力ページに遷移
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyInputPage(
                    destination: destination),
            ),
          );
        },
          /* ------ 　　　　　　　ここまで　　　　　　 ------ */
        ),
      ),
    );
  }
}