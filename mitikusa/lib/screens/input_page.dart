import 'package:flutter/material.dart';
import 'package:mitikusa/screens/result_page.dart';

class MyInputPage extends StatefulWidget {
  final String destination;
  const MyInputPage({Key? key, required this.destination}) : super(key: key);

  @override
  State<MyInputPage> createState() => MyInputPageState();
}

class MyInputPageState extends State<MyInputPage> {
  // テキストフィールドコントローラーの宣言
  // 出発地
  final TextEditingController _inputDepartController = TextEditingController();

  @override
  void dispose() {
    _inputDepartController.dispose();
    super.dispose();
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
                        controller: TextEditingController(text: '現在地'),
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
                        controller: TextEditingController(text: widget.destination),
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
                        builder: (context) => const MyResultPage()
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