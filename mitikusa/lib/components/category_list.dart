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
    'カフェ': 'cafe',
    '公園': 'park',
    'お店': 'store',
    'レストラン': 'restaurant',
    'カジノ': 'casino',
    '温泉': 'spa',
    '美術館': 'museum',
    '水族館': 'aquarium',
    '動物園': 'zoo',

  };
  // カテゴリのリスト（keyのみ）
  List<String> categoryName = [
    'カフェ',
    '公園',
    'お店',
    'レストラン',
    'カジノ',
    '温泉',
    '美術館',
    '水族館',
    '動物園',
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
