import 'package:flutter/material.dart';

class MyCategoryList extends StatefulWidget {
  const MyCategoryList({Key? key,}) : super(key: key);

  @override
  State<MyCategoryList> createState() =>  MyCategoryListState();
}

class MyCategoryListState extends State<MyCategoryList> {
  bool _visible = false;
  int _index = -1;

  // カテゴリのマップ（key:value）
  Map<String, String> categoryList = {
    'ATM' : 'ATM',
    'パン屋' : 'BAKERY',
    'カフェ' : 'CAFE',
    'カジノ' : 'CASINO',
    'スーパーマーケット' : 'SUPERMARKET',
  };
  // カテゴリのリスト（keyのみ）
  List<String> categoryName = [
    'ATM',
    'パン屋',
    'カフェ',
    'カジノ',
    'スーパーマーケット',
  ];

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                _visible = !_visible;
              });
            },
            child: (_index == -1)? const Text('選択') : Text(categoryName[_index])
        ),
        Flexible(
            child: Visibility(
              visible: _visible,
              child: Center(
                child: ListView.builder(
                  itemCount: categoryName.length,
                  itemBuilder: (BuildContext context,int index) {
                    return Card(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              _index = index;
                              _visible = !_visible;
                            });
                            _index = index;
                          },
                          title: Text(categoryName[index]),
                        )
                    );
                  },
                ),
              ),
            )
        ),
      ],
    );
  }

  String? getCategoryName() {
    if(_index != -1){
      return categoryList[categoryName[_index]];
    } else {
      return null;
    }
  }
}
