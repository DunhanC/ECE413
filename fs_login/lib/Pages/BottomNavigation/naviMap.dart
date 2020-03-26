import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

class NMap extends StatefulWidget {
  @override
  _NMapState createState() => _NMapState();
}

class _NMapState extends State<NMap> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController gmapController;
  Location _locationTracker = new Location();
  Circle circle;
  StreamSubscription _locationSubscription;
  static final CameraPosition initialLocation = CameraPosition(target: LatLng(25.716250, -80.280849),zoom: 12);
  Marker marker;


  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<Uint8List> getMarker() async{
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/car_Icon.jpg");
    return byteData.buffer.asUint8List();

  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState((){
      marker = Marker(
        markerId: MarkerId("home"),
        position: latLng,
        rotation: newLocalData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5,0.5),
        icon: BitmapDescriptor.fromBytes(imageData)
      );

      circle = Circle(
        circleId: CircleId("car"),
        radius: newLocalData.accuracy,
        zIndex: 1,
        strokeColor: Colors.redAccent,
        center: latLng,
        fillColor: Colors.redAccent.withAlpha(70)
      );

    });

  }


  void getCurrentLocation() async{
    try{
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();
      updateMarkerAndCircle(location, imageData);

      if(_locationSubscription != null){
        _locationSubscription.cancel();

      }

      _locationSubscription = _locationTracker.onLocationChanged().listen((newLocalData){
        if(gmapController != null){

          gmapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 18.00
              )
            )
          );
        }


       }
      );

  } on PlatformException catch(e){
      if(e.code == 'PERMISSION_DENIED'){
        debugPrint("Permission Denied");

      }
    }
  }



  @override

  var currentLocation;
  var clients = [];
  void initState(){
    super.initState();
    Geolocator().getCurrentPosition().then((currLoc) {
      setState(() {
        currentLocation = currLoc;
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
          _zoominfunction(),
          _zoomoutfunction(),


        ],
      ),
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.location_searching, color: Colors.redAccent,size: 25,),
        onPressed: (){
          getCurrentLocation();
        },
      ),

    );
  }

Widget _googlemap(BuildContext context){

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        onMapCreated: (GoogleMapController controller){

          //_controller.complete(controller);
          gmapController = controller;
        },

        myLocationButtonEnabled: true,
        compassEnabled: true,

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


  Widget _zoomoutfunction(){

    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(Icons.add_box, color: Colors.redAccent,),
        onPressed: (){
          zoomVal ++;
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

