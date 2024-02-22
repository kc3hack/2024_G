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
    return SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 0),

          /* ------ここから検索バーに影をつけるための処理 ------ */

          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(60),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 10, spreadRadius: 3),
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

            /* ------ ここから入力完了後にする処理 ------ */

            onSubmitted: (String destination) {
              // 入力後に詳しい情報入力ページに遷移
              // 帰ってきたときに結果を受け取る
              final result = Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyInputPage(
                      destination: destination),
                ),
              );

              /* ------ ここから帰ってきた時の処理 ------ */
              if(result != null) {
                setState(() {
                  _searchController.text = '';
                });
              }

              /* ------ 　　　　　ここまで　　　　 ------ */

            },

            /* ------ 　　　　　　　ここまで　　　　　　 ------ */

          ),

        ),
    );
  }
}