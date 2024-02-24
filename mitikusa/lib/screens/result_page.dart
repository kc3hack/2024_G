import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_routes_flutter/google_routes_flutter.dart'
    show TravelMode;

import '../components/map_state.dart';

class MyResultPage extends StatefulWidget {
  final LatLng originLatLng;
  final String originName;
  final LatLng intermediateLatLng;
  final String intermediateName;
  final LatLng destinationLatLng;
  final String destinationName;

  const MyResultPage({
    super.key,
    required this.originLatLng,
    required this.originName,
    required this.intermediateLatLng,
    required this.intermediateName,
    required this.destinationLatLng,
    required this.destinationName,
  });

  @override
  State<MyResultPage> createState() => _MyResultPageState();
}

class _MyResultPageState extends State<MyResultPage> {
  Map<TravelMode, String> travelModeString = {
    TravelMode.walk: '徒歩',
    TravelMode.drive: '車',
  };

  late LatLng _originLatLng;
  late String _originName;
  late LatLng _intermediateLatLng;
  late String _intermediateName;
  late LatLng _destinationLatLng;
  late String _destinationName;
  late TravelMode _travelMode;
  Duration _duration = const Duration();

  void _onRouteSet(Duration duration) {
    setState(() {
      _duration = duration;
    });
  }

  @override
  void initState() {
    super.initState();

    _originLatLng = widget.originLatLng;
    _originName = widget.originName;
    _intermediateLatLng = widget.intermediateLatLng;
    _intermediateName = widget.intermediateName;
    _destinationLatLng = widget.destinationLatLng;
    _destinationName = widget.destinationName;
    _travelMode = TravelMode.walk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Text(
          '検索結果\n移動手段: ${travelModeString[_travelMode]}\n所要時間: ${_duration.inMinutes}分',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: MyMap(
        doSetRoute: true,
        originLatLng: _originLatLng,
        originName: _originName,
        intermediateLatLng: _intermediateLatLng,
        intermediateName: _intermediateName,
        destinationLatLng: _destinationLatLng,
        destinationName: _destinationName,
        travelMode: _travelMode,
        onRouteSet: _onRouteSet,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
