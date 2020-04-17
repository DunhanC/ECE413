import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:fs_login/Pages/BottomNavigation/googleMap.dart';
import 'package:fs_login/Pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' show cos, sqrt, asin;


class NMap extends StatefulWidget {
  NMap({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NMapState createState() => _NMapState();
}

class _NMapState extends State<NMap> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  List<Marker> allMarkers = [];

  List<String> address_list = [];
  List<double> _distance = [];
  PageController _pageController;
  int prevPage;
  double _currentLat;
  double _currentLon;

  @override

  void initState() {
    // TODO: implement initState
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context,listen: false);
    super.initState();
    getFruits(foodNotifier);
    /*
    foodShops.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.shopName),
          draggable: false,
          infoWindow:
          InfoWindow(title: element.shopName, snippet: element.address),
          position: element.locationCoords));
    });
    */
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      //moveCamera();
    }
  }

  _coffeeShopList(FoodNotifier foodNotifier, index){
    var arr = foodNotifier.foodList[index].address.split(",");

    var _len = arr.length;

    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            moveCamera(foodNotifier, index);
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          foodNotifier.foodList[index].imagePath),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(child: Text(foodNotifier.foodList[index].itemname,
                                    style: TextStyle(color: Colors.redAccent, fontSize: 18.0,fontWeight: FontWeight.bold),)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(child: Text("4.3",
                                            style: TextStyle(color: Colors.black54, fontSize: 12.0,),)),
                                          Container(child: Icon(
                                            FontAwesomeIcons.solidStar, color: Colors.amber,
                                            size: 15.0,),),
                                          Container(child: Icon(
                                            FontAwesomeIcons.solidStar, color: Colors.amber,
                                            size: 15.0,),),
                                          Container(child: Icon(
                                            FontAwesomeIcons.solidStar, color: Colors.amber,
                                            size: 15.0,),),
                                          Container(child: Icon(
                                            FontAwesomeIcons.solidStar, color: Colors.amber,
                                            size: 15.0,),),
                                          Container(child: Icon(
                                            FontAwesomeIcons.solidStarHalf, color: Colors.amber,
                                            size: 15.0,),),
                                          Container(child: Text(_distance.elementAt(index).toString()+
                                              "mi",
                                            style: TextStyle(color: Colors.black54, fontSize: 12.0,),)),

                                        ],)),
                                ),
                                Container(child: Text(arr[0]
                                    //+ ',' + arr[_len-3] + ',' + arr[_len-2]
                                    ,
                                  style: TextStyle(color: Colors.black54, fontSize: 12.0,fontWeight: FontWeight.bold),)
                                ),
                              ],
                            )
                          )
                        ]))))
          ])),
    );
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(25.716250, -80.280849),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 2,
          strokeColor: Colors.redAccent,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {

    try {
     // Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

     // updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged().listen((newLocalData) async{
        if (_controller != null) {
          /*
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 18.00)));

           */
          _currentLat = newLocalData.latitude;
          _currentLon = newLocalData.longitude;
         // updateMarkerAndCircle(newLocalData, imageData);
        }
      }

      );
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void getDistance(lat2, lon2){
/*
    var dis = await Geolocator().distanceBetween(25.716250, -80.280849, endLatitude, endLongitude);
    var distance = dis *0.000621371;
    var value = double.parse(distance.toStringAsFixed(2));
    print(value);
*/
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - 25.716250) * p)/2 +
        c(25.716250 * p) * c(lat2 * p) *
            (1 - c((lon2 - -80.280849) * p))/2;
    var distance = 12742 * 0.621371* asin(sqrt(a));
    var value = double.parse(distance.toStringAsFixed(2));
    //await new Future.delayed(new Duration(seconds: 1));
    _distance.add(value);

  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  /*
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Google Map"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }

   */

  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    //getCurrentLocation();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Maps'),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                markers: Set.from(allMarkers),
                //circles: Set.of((circle != null) ? [circle] : []),
                onMapCreated:  (GoogleMapController controller) {
                  _controller = controller;
                },
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: foodNotifier.foodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _coffeeShopList(foodNotifier,index);
                  },
                ),
              ),
            )
          ],
        ),

    );

  }

  getFruits(FoodNotifier foodNotifier) async{

    QuerySnapshot snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Fruit').getDocuments();
    List<Food> _foodList = [];
    await Future.delayed(new Duration(milliseconds: 1));
    snapshot.documents.forEach((document){
      if(document.data['Quantity'] > 0)  {
        Food fruit = Food.fromMap(document.data);
        _foodList.add(fruit);
        address_list.add(document['Address']);
        allMarkers.add(Marker(
            markerId: MarkerId(document['ItemName']),
            draggable: false,
            infoWindow:
            InfoWindow(
                title: document['ItemName'], snippet: document['Address']),
            position: LatLng(document['Coordinate'].latitude,
                document['Coordinate'].longitude)));
        print('1');
        getDistance(document['Coordinate'].latitude,
            document['Coordinate'].longitude);
      }


    });


    foodNotifier.foodList = _foodList;
  }




  moveCamera(FoodNotifier foodNotifier, index) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        //target: foodShops[_pageController.page.toInt()].locationCoords,
        target:LatLng(foodNotifier.foodList[index].coordinates.latitude, foodNotifier.foodList[index].coordinates.longitude),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}


