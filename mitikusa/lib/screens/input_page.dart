import 'package:flutter/material.dart';
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
  late Position _departPosition;  // 出発地
  late Position _destinationPosition; // 目的地

  @override
  void initState() {
    super.initState();

    // データの初期化
    _inputDepartController  = TextEditingController(text: '現在地');
    _inputDestinationController = TextEditingController(text: widget.destination);
    Future(() async {
      _departPosition = await getCurrentPosition();
      setState(() {});
    });
  }

  // 現在地の緯度経度を返す関数
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
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
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
            child: Row(
              children: <Widget>[
                const Text('出発地'),
                const Spacer(),
                Flexible(
                    child: SizedBox(
                      child: TextField(
                        controller: _inputDepartController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            suffix: IconButton(
                              onPressed:  () async {
                                _departPosition = await getCurrentPosition();
                              },
                              icon: const Icon(Icons.gps_fixed),
                              iconSize: 20,
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
                const Spacer(),
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
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){
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