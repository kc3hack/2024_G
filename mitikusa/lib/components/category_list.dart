import 'package:flutter/material.dart';

class MyCategoryList extends StatefulWidget {
  final void Function(String category) onSelected;

  const MyCategoryList({super.key, required this.onSelected});

  @override
  State<MyCategoryList> createState() => MyCategoryListState();
}

class MyCategoryListState extends State<MyCategoryList> {
  bool _visible = false;
  int _index = 0;

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
  Widget build(BuildContext context) {
    widget.onSelected(categoryList[categoryName[_index]]!);

    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            setState(() {
              _visible = !_visible;
            });
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
          child: Text(categoryName[_index]),
        ),
        Flexible(
          child: Visibility(
            visible: _visible,
            child: Center(
              child: ListView.builder(
                itemCount: categoryName.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          _index = index;
                          _visible = !_visible;
                        });
                        widget.onSelected(categoryList[categoryName[_index]]!);
                      },
                      title: Text(
                        categoryName[index],
                        textAlign: TextAlign.center,),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
