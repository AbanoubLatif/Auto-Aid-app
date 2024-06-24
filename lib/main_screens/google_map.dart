import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);
  static String id = 'GoogleMapScreen';
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late CameraPosition intialCameraPostion;
  @override
  void initState() {
    intialCameraPostion = const CameraPosition(
        target: LatLng(29.308322700802112, 30.845288844505262),
      zoom: 15,

    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: intialCameraPostion,
    );
  }
}
