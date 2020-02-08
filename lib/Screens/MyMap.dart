
import 'dart:async';

import './MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMap extends StatefulWidget {
 double latitude;
  double longitude;

  String equipLatitude;
  String equipLongitude;
  MyMap(this.latitude,this.longitude,this.equipLatitude,this.equipLongitude);

  
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _marker={};
   
   
//  static const LatLng _center = const LatLng(widget.latitude, widget.longitude);
  void _onMapCreated(GoogleMapController controller) {
    // print('Equip Details ${double.parse(widget.equipLatitude)}');
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId('456'),
        position: LatLng(widget.latitude,widget.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Your Location',

        )
      ));
       _marker.add(Marker(
        markerId: MarkerId('4567'),
        // position: LatLng(double.parse(widget.equipLatitude)+1,double.parse(widget.equipLongitude)),
        position: LatLng(28.526445,77.5766666),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Equipment Location',

        )
      ));
    });
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.latitude} and longitude is ${widget.longitude}');
    print('${widget.equipLatitude} and longitude is ${widget.equipLongitude}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: MyAppBar(context),
        body: GoogleMap(
          compassEnabled: true,
          mapType: MapType.hybrid,
          markers: _marker,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 11.0,
            
          ),
        ),
      ),
    );
  }
}