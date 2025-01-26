import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final LatLng _initialPosition = LatLng(-6.200000, 106.816666); // Jakarta
  GoogleMapController? _mapController;
  LatLng? _selectedPosition;
  double? _distance;

  // Menghitung jarak antara dua lokasi
  Future<double> _calculateDistance(LatLng start, LatLng end) async {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  // Fungsi untuk memperbarui lokasi marker dan menghitung jarak
  void _onMapTapped(LatLng position) async {
    if (_selectedPosition != null) {
      double distance = await _calculateDistance(_selectedPosition!, position);
      setState(() {
        _distance = distance / 1000; // Konversi ke kilometer
      });
    }
    setState(() {
      _selectedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation with Distance'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12.0,
              ),
              onMapCreated: (controller) => _mapController = controller,
              markers: _selectedPosition != null
                  ? {
                Marker(
                  markerId: MarkerId('selected'),
                  position: _selectedPosition!,
                ),
              }
                  : {},
              onTap: _onMapTapped,
            ),
          ),
          if (_distance != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Jarak ke titik terakhir: ${_distance!.toStringAsFixed(2)} km',
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
