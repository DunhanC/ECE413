import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class NMap extends StatefulWidget {
  @override
  _NMapState createState() => _NMapState();
}

class _NMapState extends State<NMap> {
  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override

  var currentLocation;
  var clients = [];
  void initState(){
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        populateClients();
      });


    });
  }
  double zoomVal =5.0;

  populateClients(){
    clients=[];
    Firestore.instance.collection('markers').getDocuments().then((docs) {
      if(docs.documents.isNotEmpty) {
        for(int i = 0; i < docs.documents.length; ++i){
          clients.add(docs.documents[i].data);
          initMarker(docs.documents[i].data, docs.documents[i].documentID);
        }
      }
    });

  }

initMarker(client, docId){
    var markerIdVal = docId;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(client['location'].latitude, client['location'].longitude),
        infoWindow:  InfoWindow(title: client['clientName']),
        );
    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Google Map"),
        automaticallyImplyLeading: false,

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){

            },
          )
        ],
      ),

      body: Stack(
        children: <Widget>[
          _googlemap(context),
          //_zoominfunction(),
          //_zoommoutfunction(),


        ],
      ),


    );
  }

Widget _googlemap(BuildContext context){

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(25.716250, -80.280849),zoom: 12),
        onMapCreated: (GoogleMapController controller){

          _controller.complete(controller);

        },
/*
        markers:{
          miamiMarker,
          miami2Marker
        },
*/
        markers: Set<Marker>.of(markers.values),


      ),

    );
}

Widget _zoominfunction(){

    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.indeterminate_check_box, color: Colors.redAccent,),
        onPressed: (){
          zoomVal --;
          _minus(zoomVal);

        },
      ),
    );
}

Future<void> _minus(double zoomVal) async{
    
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(25.716250, -80.280849))));
    
}


}

Marker miamiMarker = Marker(
  markerId: MarkerId('coralgables1'),
  position: LatLng(25.716250, -80.278215),
  infoWindow:  InfoWindow(title: 'University of Miami'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

);

Marker miami2Marker = Marker(
  markerId: MarkerId('coralgables2'),
  position: LatLng(25.710518, -80.280849),
  infoWindow:  InfoWindow(title: 'University Inn'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

);