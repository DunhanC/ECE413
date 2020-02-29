import 'package:flutter/material.dart';

class HorizontalList1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection:  Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'https://img.icons8.com/doodle/48/000000/tin-can--v1.png',
            image_caption: 'Nut6',
          ),
          Category(
            image_location: 'https://img.icons8.com/pastel-glyph/64/000000/orange-soda--v1.png',
            image_caption: 'Nut7',
          ),
          Category(
            image_location: 'https://img.icons8.com/doodle/48/000000/soup-plate.png',
            image_caption: 'Nut8',
          ),
          Category(
            image_location: 'https://img.icons8.com/cotton/64/000000/italian-pizza.png',
            image_caption: 'Nut9',
          ),
          Category(
            image_location: 'https://img.icons8.com/cotton/64/000000/fish-food.png',
            image_caption: 'Nut10',
          ),
          Category(
            image_location: 'https://img.icons8.com/dusk/64/000000/organic-food.png',
            image_caption: 'Nut11',
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