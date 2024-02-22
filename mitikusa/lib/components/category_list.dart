import 'package:flutter/material.dart';

class MyCategoryList extends StatefulWidget {
  const MyCategoryList({Key? key,}) : super(key: key);

  @override
  State<MyCategoryList> createState() =>  MyCategoryListState();
}

class MyCategoryListState extends State<MyCategoryList> {
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
    return const ElevatedButton(
      onPressed: null,
      child: Text('試し押し'),
    );
  }

}
