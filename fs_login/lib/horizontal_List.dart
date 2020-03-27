import 'package:flutter/material.dart';
import 'package:fs_login/breadStorage.dart';
import 'package:fs_login/fruitStorage.dart';
import 'package:fs_login/proteinstorage.dart';
import 'package:fs_login/frozenStorage.dart';
import 'package:fs_login/vegetableStorage.dart';

class HorizontalList extends StatelessWidget {
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
                      builder: (context) => Fruitstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  'https://img.icons8.com/cotton/64/000000/grape.png',
                  width: 55.0,
                  height: 35.0,
                ),
                Text(
                  'Fruit',
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
                      builder: (context) => Proteinstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'https://img.icons8.com/cotton/64/000000/steak.png',
                    width: 55.0,
                    height: 35.0),
                Text(
                  'Protein',
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
                      builder: (context) => Breadstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'https://img.icons8.com/cotton/64/000000/bread--v1.png',
                    width: 55.0,
                    height: 35.0),
                Text(
                  'Bread',
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
                      builder: (context) => Vegetablestorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'https://img.icons8.com/cotton/64/000000/potatoes-1--v2.png',
                    width: 55.0,
                    height: 35.0),
                Text(
                  'Vegetable',
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
                      builder: (context) => Frozenstorage(),
                      fullscreenDialog: true));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'https://img.icons8.com/cotton/64/000000/food-truck--v3.png',
                    width: 55.0,
                    height: 35.0),
                Text(
                  'Frozen',
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
