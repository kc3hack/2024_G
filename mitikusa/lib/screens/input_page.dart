import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mitikusa/components/category_list.dart';
import 'package:mitikusa/components/getPlaceFromString.dart';
import 'package:mitikusa/components/search_system.dart';
import 'package:mitikusa/screens/result_page.dart';

class MyInputPage extends StatefulWidget {
  final String destination;
  const MyInputPage({super.key, required this.destination});

  @override
  State<MyInputPage> createState() => MyInputPageState();
}

class MyInputPageState extends State<MyInputPage> {
  // テキストフィールドコントローラーの宣言
  // 出発地
  late TextEditingController _inputDepartController; // 出発地
  late TextEditingController _inputDestinationController; // 目的地

  // 緯度経度の保持用変数の宣言
  late LatLng _departPosition; // 出発地
  late String _departName;
  late LatLng _intermediatePosition;
  late String _intermediateName;
  late LatLng _destinationPosition; // 目的地
  late String _destinationName;

  late String _category;

  @override
  void initState() {
    super.initState();

    // データの初期化
    _inputDepartController = TextEditingController();
    _inputDestinationController =
        TextEditingController(text: widget.destination);
  }

  // 現在地の緯度経度を返す関数
  Future<LatLng> getCurrentPosition() async {
    Position p = await Geolocator.getCurrentPosition();
    return LatLng(p.latitude, p.longitude);
  }

  // カテゴリーリストの項目が選択されたときに呼び出されるコールバック関数
  void _onSelected(String category) {
    _category = category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // データを返す
            Navigator.pop(context, 'back');
          },
        ),
        title: const Text('検索'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              children: <Widget>[
                const Text('出発地'),
                const SizedBox(
                  width: 80,
                ),
                Flexible(
                  child: SizedBox(
                    child: TextField(
                      controller: _inputDepartController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        hintText: '現在地',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.gps_fixed),
                          iconSize: 20,
                          onPressed: () {
                            _inputDepartController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              children: <Widget>[
                const Text('目的地'),
                const SizedBox(
                  width: 80,
                ),
                Flexible(
                  child: SizedBox(
                    child: TextField(
                      controller: _inputDestinationController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 50,
            thickness: 1,
            indent: 30,
            endIndent: 30,
            color: Colors.black,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              children: <Widget>[
                Text(
                  'ミチクサ設定',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              children: <Widget>[
                Text('ミチクサスポット'),
              ],
            ),
          ),
          Flexible(child: MyCategoryList(onSelected: _onSelected)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Future(() async {
                      // 出発地のテキストフィールドが空白かどうか
                      if (_inputDepartController.text.trim().isEmpty) {
                        // 空白なら現在地の緯度経度を取得
                        _departPosition = await getCurrentPosition();
                        _departName = '現在地';
                      } else {
                        // 入力があるならその場所の緯度経度を取得
                        ({LatLng latLng, String name}) place =
                            await getPlaceFromString(
                                _inputDepartController.text);
                        _departPosition = place.latLng;
                        _departName = place.name;
                      }
                      // 目的地
                      ({LatLng latLng, String name}) place =
                          await getPlaceFromString(
                              _inputDestinationController.text);

                      _destinationPosition = place.latLng;
                      _destinationName = place.name;

                      // カテゴリから中継地を検索
                      LatLng middlePosition = LatLng(
                        (_departPosition.latitude +
                                _destinationPosition.latitude) /
                            2.0,
                        (_departPosition.longitude +
                                _destinationPosition.longitude) /
                            2.0,
                      );
                      ({LatLng latLng, String name}) intermediatePosition =
                          await MitikusaSearch()
                              .searchPlace(middlePosition, _category);
                      _intermediatePosition = intermediatePosition.latLng;
                      _intermediateName = intermediatePosition.name;
                    }).then((_) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyResultPage(
                            originLatLng: _departPosition,
                            originName: _departName,
                            intermediateLatLng: _intermediatePosition,
                            intermediateName: _intermediateName,
                            destinationLatLng: _destinationPosition,
                            destinationName: _destinationName,
                          ),
                        ),
                      );
                    });
                  },
                  child: const Text('決定'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
