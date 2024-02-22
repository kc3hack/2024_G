import 'package:flutter/material.dart';
import 'package:mitikusa/components/getLatLngFromString.dart';
import 'package:mitikusa/screens/result_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyInputPage extends StatefulWidget {
  final String destination;
  const MyInputPage({Key? key, required this.destination}) : super(key: key);

  @override
  State<MyInputPage> createState() => MyInputPageState();
}

class MyInputPageState extends State<MyInputPage> {
  // テキストフィールドコントローラーの宣言
  // 出発地
  late TextEditingController _inputDepartController;  // 出発地
  late TextEditingController _inputDestinationController; // 目的地

  // 緯度経度の保持用変数の宣言
  late LatLng _departPosition;  // 出発地
  late LatLng _destinationPosition; // 目的地

  @override
  void initState() {
    super.initState();

    // データの初期化
    _inputDepartController  = TextEditingController();
    _inputDestinationController = TextEditingController(text: widget.destination);
  }

  // 現在地の緯度経度を返す関数
  Future<LatLng> getCurrentPosition() async {
    Position p = await Geolocator.getCurrentPosition();
    return LatLng(p.latitude, p.longitude);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('検索')
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
                              onPressed:  () {
                                _inputDepartController.clear();
                              },
                            )
                        ),
                      ),
                    )
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
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
                    )
                ),
              ],// 34.995532, 135.7629092
            ),
          ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    // 出発地のテキストフィールドが空白かどうか
                    if(_inputDepartController.text.trim().isEmpty){
                      // 空白なら現在地の緯度経度を取得
                      _departPosition = await getCurrentPosition();
                    }else{
                      // 入力があるならその場所の緯度経度を取得
                      _departPosition = await getLatLngFromString(_inputDepartController.text);
                    }
                    _destinationPosition = await getLatLngFromString(_inputDestinationController.text);
                    if (!context.mounted) return; // 非同期処理が終わったら以下を実行
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyResultPage(
                          depart: _departPosition,
                          destination: _destinationPosition,
                        ),
                      ),
                    );
                  },
                  child: const Text('決定'),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}