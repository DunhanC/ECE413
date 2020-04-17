import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fs_login/Counter.dart';
import 'package:fs_login/Pages/home.dart';
import 'package:fs_login/search_place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:scoped_model/scoped_model.dart';

const kGoogleApiKey = "AIzaSyCB1CWrcGJXIoudIpk0yG2N9RaNCvzJ1AQ";
final homeScaffoldKey = GlobalKey<ScaffoldState>();
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class Donation extends StatefulWidget {
  @override
  _DonationState createState() => _DonationState();
}



class _DonationState extends State<Donation> {
  DonationModel model;
  DateTime _StartDate = DateTime.now();
  DateTime _EndDate = DateTime.now().add(Duration(days: 7));
  var _address;
  var latt;
  var longi;
  var quantities;

  Future displayDateRangePicker(BuildContext context) async{
      final List<DateTime> picked = await DateRangePicker.showDatePicker(

          context: context,
          initialFirstDate: _StartDate,
          initialLastDate: _EndDate,
          firstDate: new DateTime(DateTime.now().year - 50),
          lastDate: new DateTime(DateTime.now().year + 50)
      );
      if(picked != null && picked.length == 2){
        setState(() {
          _StartDate = picked[0];
          _EndDate = picked[1];
        });

      }

  }

  var foodType;
  Food _currentFood;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> _foodType = <String>[
    'Fruit',
    'Protein',
    'Bread',
    'Vegetable',
    'Frozen',
    'Canned',
    'Drink',
    'Instant',
    'Seafood',
    'Dessert',
  ];

  @override

  void initState() {
    super.initState();
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);

    if (foodNotifier.currentFood != null) {
      _currentFood = foodNotifier.currentFood;
    } else {
      _currentFood = Food();
    }

  }

  Widget _itemname(){

      return Container(
        padding: EdgeInsets.only(top: 0.0, left: 150.0,right: 150.0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Item Name is required';
            }

            if (value.length < 3 || value.length > 20) {
              return 'Name must be more than 3 and less than 20';
            }

            return null;
          },
          onSaved: (String value){
            _currentFood.itemname = value;
            print(_currentFood.itemname);
          } ,
          decoration: InputDecoration(
              labelText: 'Item Name',
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
        ),
      );
  }

  Widget _quantityContainer(DonationModel model){

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: (){
              model.decrement();
              quantities = model.count;
            },
            child: Icon(FontAwesomeIcons.minus,
            color: Colors.redAccent,
            size: 15.0,),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Color(0xffFAF4F2),
            padding: const EdgeInsets.all(10.0),
          ),
          Text(model.count.toString(), style: TextStyle(fontSize: 15),),
          RawMaterialButton(
            onPressed: (){
              model.increment();
              quantities = model.count;
            },
            child: Icon(FontAwesomeIcons.plus,
              color: Colors.redAccent,
              size: 15.0,),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Color(0xffFAF4F2),
            padding: const EdgeInsets.all(10.0),
          ),

        ],
      ),
    );
  }

  Widget _foodTypes(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.fastfood,
          size: 25,
          color: Colors.redAccent,
        ),
        SizedBox(width: 10,),
        DropdownButton(
            focusColor: Colors.redAccent,
            items: _foodType.map((value)=> DropdownMenuItem(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.redAccent
                ),
              ),
              value: value,

            )).toList(),
          onChanged: (selectedFoodType){
              setState(() {
                foodType = selectedFoodType;
              });
          },
          value: foodType,
        ),
      ],
    );
  }

  File imageFile;
  String imagepath;

  _openGallery(BuildContext context) async{
      var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
      this.setState((){
        imageFile = picture;
      });
      Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{

    var picture  = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showchoiceDialog(BuildContext context){
      return showDialog(context: context,
          builder: (BuildContext context){
              return AlertDialog(
                title: Text('Photos From'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        child: Text('Gallery'),
                        onTap: (){
                          _openGallery(context);
                        },

                      ),
                      Padding(padding: EdgeInsets.all(8.0)),

                      GestureDetector(
                        child: Text('Camera'),
                        onTap: (){
                          _openCamera(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
          });
  }

  Widget _decideImageView(){
    if(imageFile == null){
        return Padding(
            padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
          child: new Icon(Icons.add, color: Colors.redAccent,),
        );
    }
    else{
      return Image.file(imageFile, fit: BoxFit.cover,);
    }
  }

  donateFood(Food food, String itemName, String foodType, {String imageurl}) async{

    CollectionReference foodRef = await Firestore.instance.collection('Category')
        .document('FoodCategory').collection(foodType);
    _currentFood.imagePath = imageurl;
    DocumentReference documentReference = await foodRef.add(food.toMap());
    print('uploaded food successfully: ${food.toString()}');

    await documentReference.setData(food.toMap(), merge: true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true));
  }


  void uploadImage() async{
    final StorageReference postImageRef = FirebaseStorage.instance.ref().child("Food Images");
    var timeKey = new DateTime.now();
    final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString() + ".jpg").putFile(imageFile);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    imagepath = imageUrl.toString();
    donateFood(_currentFood, _currentFood.itemname, foodType, imageurl: imagepath);
  }



  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      language: "en",
      components: [Component(Component.country, "usa")],
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Donation",style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),

      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
                SizedBox(height: 5,),
                Container (
                  height: 180,
                  width: 180,
                  //padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                  child: OutlineButton(
                      borderSide: BorderSide(color: Colors.redAccent.withOpacity(0.5), width: 2.5),
                      onPressed: (){
                        _showchoiceDialog(context);
                      },
                      child: _decideImageView()
                  ),
          ),

              Form(
                key: _formKey,
                autovalidate: true,
                //padding: EdgeInsets.only(top: 10.0, left: 20.0,right: 20.0),
                child: Column(

                  children: <Widget>[
                    _foodTypes(),
                    _itemname(),
                    Material(
                      child: ScopedModelDescendant<DonationModel>(
                        builder: (context,child,model){
                          return _quantityContainer(model);
                        },
                      ),
                    ),


                  ],
                ),
              ),

              RaisedButton(
                elevation: 7.0,
                color: Colors.redAccent,
                child: Text('Locate Place', style: TextStyle(color: Colors.white),),
                onPressed: _handlePressButton
              ),

              Text(_address!= null?_address:'Choose Address'),

              SizedBox(height: 10,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.redAccent, //color of the main banner
                  accentColor: Colors.redAccent, //color of circle indicating the selected date
                  buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme.primary //color of the text in the button "OK/CANCEL"
                  ),
                ),
                child: Builder(
                  builder: (context){
                    return RaisedButton(
                      color: Colors.redAccent,
                      child: Text('Select Dates'),
                      onPressed: () async{

                        await displayDateRangePicker(context);
                      },
                    );
                  },
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Start Date: ${DateFormat('MM/dd/yyyy').format(_StartDate).toString()}"),
                  Text("End Date: ${DateFormat('MM/dd/yyyy').format(_EndDate).toString()}"),
                ],
              ),

              RaisedButton(
                elevation: 7.0,
                color: Colors.redAccent,
                child: Text('Donate',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  _currentFood.address = _address;
                  _currentFood.quantity = quantities;
                  _currentFood.startDate = _StartDate;
                  _currentFood.endDate = _EndDate;
                  _currentFood.reserved = false;
                  _currentFood.coordinates = GeoPoint(latt,longi);
                  _formKey.currentState.save();
                  uploadImage();
                },
              )

            ],
          ),
        ),
      ),

    );
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      setState(() {
        _address = p.description;
        latt = lat;
        longi = lng;

      });

      print(_address);
      print(latt);
      print(longi);
      scaffold.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  }

}

