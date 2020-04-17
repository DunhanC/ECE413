import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          hintColor: Colors.transparent
      ),
      child:  Container(
        height: 42,
        child: TextField(
          onTap: ()async{
            Prediction p = await PlacesAutocomplete.show(context: context, apiKey: "AIzaSyCB1CWrcGJXIoudIpk0yG2N9RaNCvzJ1AQ",
            language: "en", components: [
              Component(Component.country, "usa")
                ]);
          },
          decoration: InputDecoration(
              hintText: "Search Place",
              hintStyle: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 16
              ),
            prefixIcon: Icon(Icons.search, color: Color(0xFF757575),),
            border: OutlineInputBorder(
              borderRadius:  BorderRadius.circular(30)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            fillColor: Color(0xFFEEEEEE),
            filled: true
          ),
        ),

      ),
    );
  }
}