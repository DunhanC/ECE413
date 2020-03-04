import 'package:flutter/material.dart';
import 'package:fs_login/fruitStorage.dart';

class HorizontalList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection:  Axis.horizontal,
        children: <Widget>[

        MaterialButton(
          minWidth: 40,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Fruitstorage(),fullscreenDialog: true));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network('https://img.icons8.com/cotton/64/000000/grape.png',width: 55.0,
                height: 35.0,),
              Text(
                'Fruit',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
         /*
          Category(
              image_location: 'https://img.icons8.com/cotton/64/000000/grape.png',
              image_caption: 'Nut1',
            ),
*/
          Category(
              image_location: 'https://img.icons8.com/cotton/64/000000/ice-cream-fruit-cone.png',
              image_caption: 'Nut2',
          ),
          Category(
            image_location: 'https://img.icons8.com/cotton/64/000000/potatoes-1--v2.png',
            image_caption: 'Nut3',
          ),
          Category(
            image_location: 'https://img.icons8.com/pastel-glyph/64/000000/milk-bottle.png',
            image_caption: 'Nut4',

          ),
          Category(
            image_location: 'https://img.icons8.com/cotton/64/000000/steak.png',
            image_caption: 'Nut5',
          ),

        ],
      ),
    );
  }
}


class Category extends StatelessWidget{
  final String image_location;
  final String image_caption;

  Category({

    this.image_location,
    this.image_caption

});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: const EdgeInsets.all(2.0),
    child: InkWell(onTap: (){},
      child: Container(
        height: 100.0,
        width: 100.0,
        child: ListTile(
          title: Image.network(image_location,
          width: 55.0,
          height: 35.0,),
          subtitle: Container(

            alignment: Alignment.topCenter,
            child: Text(image_caption,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold

              ),
            ),
          )
        ),
      ),

    ),

    );
  }
}