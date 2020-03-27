import 'package:flutter/material.dart';
import 'package:fs_login/drinkstorage.dart';
import 'package:fs_login/instantstorage.dart';
import 'package:fs_login/seafoodstorage.dart';
import 'package:fs_login/dessertstorage.dart';
import 'package:fs_login/cannedstorage.dart';

class HorizontalList1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          MaterialButton(
            minWidth: 105,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cannedstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  'https://img.icons8.com/doodle/48/000000/tin-can--v1.png',
                  width: 55.0,
                  height: 35.0,
                ),
                Text(
                  'Canned',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          MaterialButton(
            minWidth: 105,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Drinkstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'https://img.icons8.com/pastel-glyph/64/000000/orange-soda--v1.png',
                    width: 55.0,
                    height: 35.0),
                Text(
                  'Drink',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          MaterialButton(
            minWidth: 105,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Instantstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'https://img.icons8.com/doodle/48/000000/soup-plate.png',
                    width: 55.0,
                    height: 35.0),
                Text(
                  'Instant',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          MaterialButton(
            minWidth: 105,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Seafoodstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'https://img.icons8.com/cotton/64/000000/dressed-fish.png',
                    width: 55.0,
                    height: 35.0),
                Text(
                  'Seafood',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          MaterialButton(
            minWidth: 105,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dessertstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'https://img.icons8.com/cotton/64/000000/fruit-ice-cream-cone.png',
                    width: 55.0,
                    height: 35.0),
                Text(
                  'Dessert',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 100.0,
          width: 100.0,
          child: ListTile(
              title: Image.network(
                image_location,
                width: 55.0,
                height: 35.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  image_caption,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}










