import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(37.773972, -122.431297), zoom: 11.5);
  final Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        const Marker(
            markerId: MarkerId('id-a'),
            position: LatLng(37.773972, -122.431297),
            infoWindow: InfoWindow(title: "Home", snippet: "The place to be")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Map Page"),
        ),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        markers: _markers,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
