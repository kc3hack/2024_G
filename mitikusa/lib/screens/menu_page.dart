import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget{
  const TodoListPage({Key? key,}) : super(key: key);

  @override
  TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State<TodoListPage> {
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[//CrossAxisAlignment.stretchが横長に図形を書く
          Container(       //つまり縦幅だけで良い
              child: const Center(child: Text('')),
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                color: Colors.white, // 枠線の内側の色
              ),
            ),
          //------------------------------------------
          Container(       //つまり縦幅だけで良い
            child: ElevatedButton(child: Text('デフォルト設定'),
              onPressed:(){
              //ここに押したら反応するコードを書く
              },
              ),
            height: 80,//縦の幅
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,//この辺りで枠線を黒にしてる
                width: 2,//（枠線が）いらないかもしれない
              ),
              color: Colors.white, // 枠線の内側の色
            ),
          ),
          //------------------------------------------
          Container(
            child: ElevatedButton(child: Text('ルート履歴'),
    onPressed:(){
    //ここに押したら反応するコードを書く
    },
    ),

            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              color: Colors.white, // 枠線の内側の色
            ),
          ),
          //------------------------------------------
          Container(
            child: ElevatedButton(child: Text('ブックマーク'),
    onPressed:(){
    //ここに押したら反応するコードを書く
    },
    ),
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              color: Colors.white, // 枠線の内側の色
            ),
          ),
          //------------------------------------------
          Container(
            child: ElevatedButton(child: Text('❌❌❌❌❌❌'),
              onPressed:(){
                //ここに押したら反応するコードを書く
              },),
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              color: Colors.white, // 枠線の内側の色
            ),
          ),
          //------------------------------------------
          Container(
            child: ElevatedButton(child: Text('環境設定'),
              onPressed:(){
                //ここに押したら反応するコードを書く
              },),
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              color: Colors.white, // 枠線の内側の色
            ),
          ),
        ],
      ),
    );
  }
}