import 'package:flutter/material.dart';

class MyCategoryList extends StatefulWidget {
  const MyCategoryList({Key? key,}) : super(key: key);

  @override
  State<MyCategoryList> createState() =>  MyCategoryListState();
}

class MyCategoryListState extends State<MyCategoryList> {
  bool _visible = false;

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
            child: const Text('選択')
        ),
        Visibility(
            visible: _visible,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categoryName.length,
                itemBuilder: (BuildContext context,int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        categoryName[index],
                        style: const TextStyle(fontSize: 22.0),
                      ),
                    ),
                  );
                },
              ),
            )
        )
      ],
    );
  }

}
