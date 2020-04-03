import "package:google_maps_flutter/google_maps_flutter.dart";

class food_mark {
  String shopName;
  String address;
  String thumbNail;
  LatLng locationCoords;

  food_mark(
      {this.shopName,
        this.address,
        this.thumbNail,
        this.locationCoords});
}

final List<food_mark> foodShops = [
  food_mark(
      shopName: 'University of Miami',
      address: '1306 Standford Circle',
      locationCoords: LatLng(25.719546,-80.277107),
      thumbNail: 'https://res.cloudinary.com/popmenu/image/upload/c_limit,f_auto,h_1440,q_auto,w_1440/ykmqejwygnhqizxms6bh.jpg'
  ),
  food_mark(
      shopName: 'University Inn',
      address: '1280 S Alhambra Cir',
      locationCoords: LatLng(25.710518, -80.280849),
      thumbNail: 'https://media2.s-nbcnews.com/j/newscms/2018_02/1309354/canned-foods-today-tease-180109_074cd38ce3f3d26fd10bb0fce13557e7.fit-760w.jpg'
  ),
  food_mark(
      shopName: 'School of Bussiness',
      address: '5250 University Dr',
      locationCoords: LatLng(25.720194,-80.276324),
      thumbNail: 'https://media3.s-nbcnews.com/j/newscms/2019_33/2203981/171026-better-coffee-boost-se-329p_67dfb6820f7d3898b5486975903c2e51.fit-760w.jpg'
  )
];