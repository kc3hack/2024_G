import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:google_routes_flutter/google_routes_flutter.dart' as groutes;

import '../api_key.dart';

class MyMap extends StatefulWidget {
  final bool doSetRoute; // ルートを設定するか
  final gmaps.LatLng? originLatLng; // 出発地の緯度経度
  final String? originName; //出発地の名前
  final gmaps.LatLng? intermediateLatLng; // 中継地の緯度経度
  final String? intermediateName; //出発地の名前
  final gmaps.LatLng? destinationLatLng; // 到着地の緯度経度
  final String? destinationName; //出発地の名前
  final groutes.TravelMode? travelMode; // 移動手段
  final void Function(Duration duration)? onRouteSet; // ルートの所要時間を取得するコールバック関数
  final EdgeInsets padding;

  const MyMap({
    super.key,
    this.doSetRoute = false,
    this.originLatLng,
    this.originName,
    this.intermediateLatLng,
    this.intermediateName,
    this.destinationLatLng,
    this.destinationName,
    this.travelMode,
    this.onRouteSet,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Position? _currentPosition; // 現在位置
  late StreamSubscription<Position> _positionStream; // 現在位置取得ストリーム
  late gmaps.GoogleMapController _googleMapController; // Google Map Controller
  final Set<gmaps.Polyline> _polylines = {}; // ポリラインたち
  final PolylinePoints _polylinePoints =
      PolylinePoints(); // flutter_polyline_pointsパッケージを利用するためのオブジェクトインスタンス
  final Set<gmaps.Marker> _markers = {}; // マーカーたち
  late Duration _duration; // ルートの所要時間

  // カメラの初期位置
  final gmaps.CameraPosition _initialCameraPosition =
      const gmaps.CameraPosition(
    target: gmaps.LatLng(36.204823999999995, 138.252924),
    zoom: 4.0,
  );

  // 現在位置取得に関する設定
  final LocationSettings _locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 100,
  );

  //カメラを position に移動
  Future<void> _animateCamera(Position? position) async {
    if (position != null) {
      await _googleMapController.animateCamera(
        gmaps.CameraUpdate.newCameraPosition(
          gmaps.CameraPosition(
            target: gmaps.LatLng(position.latitude, position.longitude),
            zoom: 14.0,
          ),
        ),
      );
    }
  }

  // GoogleMap.onMapCreated コールバック
  void _onMapCreated(gmaps.GoogleMapController googleMapController) {
    _googleMapController = googleMapController;

    // カメラを現在地に設定
    Geolocator.getCurrentPosition().then((Position position) {
      _googleMapController.moveCamera(
        gmaps.CameraUpdate.newCameraPosition(
          gmaps.CameraPosition(
            target: gmaps.LatLng(position.latitude, position.longitude),
            zoom: 14.0,
          ),
        ),
      );
    });
  }

  // ルートを設定
  Future<void> _setRoute(
    gmaps.LatLng originLatLng,
    gmaps.LatLng intermediateLatLng,
    gmaps.LatLng destinationLatLng,
    groutes.TravelMode travelMode,
  ) async {
    // 出発地
    final groutes.Waypoint origin = groutes.Waypoint(
      location: groutes.Location(
        latLng: groutes.LatLng(
          latitude: originLatLng.latitude,
          longitude: originLatLng.longitude,
        ),
      ),
    );
    // 中継地
    final groutes.Waypoint intermediate = groutes.Waypoint(
      location: groutes.Location(
        latLng: groutes.LatLng(
          latitude: intermediateLatLng.latitude,
          longitude: intermediateLatLng.longitude,
        ),
      ),
    );
    // 目的地
    final groutes.Waypoint destination = groutes.Waypoint(
      location: groutes.Location(
        latLng: groutes.LatLng(
          latitude: destinationLatLng.latitude,
          longitude: destinationLatLng.longitude,
        ),
      ),
    );

    // ルートを検索
    final groutes.ComputeRouteResult computeRoutesResult =
        await groutes.computeRoute(
      origin: origin,
      intermediates: [intermediate],
      destination: destination,
      xGoogFieldMask: 'routes.duration,routes.polyline.encodedPolyline',
      apiKey: apiKey,
      travelMode: travelMode,
    );

    // encodedPolylineを取得
    final String encodedPolyline =
        computeRoutesResult.routes!.first.polyline!.encodedPolyline!;

    // encodedPolylineをデコード
    final List<PointLatLng> pointLatLngs =
        _polylinePoints.decodePolyline(encodedPolyline);

    // gmaps.LatLng型に変換
    final List<gmaps.LatLng> points = [
      for (PointLatLng pointLatLng in pointLatLngs)
        gmaps.LatLng(pointLatLng.latitude, pointLatLng.longitude)
    ];

    setState(() {
      // 所要時間を取得
      String durationString = computeRoutesResult.routes!.first.duration!;
      _duration = Duration(
        seconds: int.parse(
          durationString.substring(0, durationString.length - 1),
        ),
      );

      // ポリラインを設置
      _polylines.add(gmaps.Polyline(
        polylineId: const gmaps.PolylineId("route"),
        visible: true,
        color: Colors.blue,
        width: 5,
        points: points,
      ));

      // マーカーを設置
      _markers
        ..add(gmaps.Marker(
          markerId: const gmaps.MarkerId('origin'),
          infoWindow:
              gmaps.InfoWindow(title: widget.originName, snippet: '出発地'),
          position: originLatLng,
          icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
            gmaps.BitmapDescriptor.hueBlue,
          ),
        ))
        ..add(gmaps.Marker(
          markerId: const gmaps.MarkerId('intermediate'),
          infoWindow:
              gmaps.InfoWindow(title: widget.intermediateName, snippet: '中継地'),
          position: intermediateLatLng,
          icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
            gmaps.BitmapDescriptor.hueGreen,
          ),
        ))
        ..add(gmaps.Marker(
          markerId: const gmaps.MarkerId('destination'),
          infoWindow:
              gmaps.InfoWindow(title: widget.destinationName, snippet: '目的地'),
          position: destinationLatLng,
        ));
    });

    // ルートがちょうどよく収まるようにズーム
    final gmaps.LatLng southwest = gmaps.LatLng(
        min(originLatLng.latitude, destinationLatLng.latitude),
        min(originLatLng.longitude, destinationLatLng.longitude));
    final gmaps.LatLng northeast = gmaps.LatLng(
        max(originLatLng.latitude, destinationLatLng.latitude),
        max(originLatLng.longitude, destinationLatLng.longitude));
    const double padding = 100.0;
    _googleMapController.animateCamera(
      gmaps.CameraUpdate.newLatLngBounds(
        gmaps.LatLngBounds(southwest: southwest, northeast: northeast),
        padding,
      ),
    );

    // 所要時間を渡す
    widget.onRouteSet!(_duration);
  }

  @override
  void initState() {
    super.initState();

    //位置情報が許可されていない時に許可をリクエストする
    Future(() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
    });

    //現在位置を更新し続ける
    _positionStream =
        Geolocator.getPositionStream(locationSettings: _locationSettings)
            .listen((Position? position) {
      setState(() {
        _currentPosition = position;
      });
    });

    // 指定されているならばルートを設定
    if (widget.doSetRoute) {
      _setRoute(
        widget.originLatLng!,
        widget.intermediateLatLng!,
        widget.destinationLatLng!,
        widget.travelMode!,
      );
    }
  }

  //マップの表示
  @override
  Widget build(BuildContext context) {
    return gmaps.GoogleMap(
      mapType: gmaps.MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      myLocationEnabled: true, //現在位置をマップ上に表示
      onMapCreated: _onMapCreated,
      polylines: _polylines,
      markers: _markers,
      padding: widget.padding,
    );
  }
}
