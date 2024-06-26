import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  static String id = 'GoogleMapScreen';

  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Set<Marker> _markers = {};

  final List<LatLng> _places = [
    const LatLng(29.319779921126905, 30.835635480979356),
    const LatLng(29.317047584916562, 30.833676848254598),
    const LatLng(29.318064265967486, 30.83187750839795),
    const LatLng(29.317769125035614, 30.83108095269167),
    const LatLng(29.317114818566022, 30.83107614985822),
    const LatLng(29.316903799620277, 30.831646155016017),
    const LatLng(29.315899261263638, 30.831099057132388),
    const LatLng(29.31587571499048, 30.83038584530101),
    const LatLng(29.315447280129998, 30.83104812300272),
    const LatLng(29.314446741254685, 30.83114789766021),
    const LatLng(29.334979039976723, 30.82208113735553),
    const LatLng(29.31472671005524, 30.83805285372132),
    const LatLng(29.3084047611498, 30.84284875476476),
    const LatLng(29.298746582850804, 30.835870429868223),
    const LatLng(29.300253934626827, 30.83343814160159),
    const LatLng(29.31260383154393, 30.872133586968058),
    const LatLng(29.318410970828953, 30.860604420299104),
    const LatLng(29.324280734872463, 30.854334274206963),
    const LatLng(29.334977730873597, 30.822083661739654),
  ];

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    for (int i = 0; i < _places.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('place_$i'),
          position: _places[i],
          infoWindow: InfoWindow(title: 'Place ${i + 1}'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            i == 0 ? BitmapDescriptor.hueRed : BitmapDescriptor.hueBlue,
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _places[0], // تم تعيين نقطة البداية إلى أول مكان في القائمة
          zoom: 14, // تم تعيين مستوى التكبير لعرض الأماكن بشكل أفضل
        ),
        markers: _markers,
      ),
    );
  }
}

