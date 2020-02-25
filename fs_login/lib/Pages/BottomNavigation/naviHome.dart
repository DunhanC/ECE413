import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fs_login/Pages/Setup/signIn.dart';
import 'package:fs_login/Pages/BottomNavigation/profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fs_login/horizontal_List.dart';
import 'package:fs_login/horizontal_List2.dart';
import 'package:fs_login/dataSearch.dart';

class NHome extends StatefulWidget {
  @override
  _NHomeState createState() => _NHomeState();
}

class _NHomeState extends State<NHome> {

  //ZM: Image Slider
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'https://images6.alphacoders.com/339/thumb-1920-339410.jpg',
    'https://assets.vogue.com/photos/58918cfc8c64075803ad1000/master/pass/canned-food.jpg',
    'https://images.wallpaperscraft.com/image/drinks_soda_bottles_114807_1920x1080.jpg',
    'https://c4.wallpaperflare.com/wallpaper/158/908/866/vitamins-wallpaper-preview.jpg',
    'https://assets.epicurious.com/photos/5a3002b504847a34b821cb4a/16:9/w_1600,c_limit/seared-scallops-with-brown-butter-and-lemon-pan-sauce-recipe-BA-121217.jpg'
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text('FoodSavior');
  String mainProfileImage = "http://hd.wallpaperswide.com/thumbs/coffee_bokeh_2-t2.jpg";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.redAccent,

          title: Center(
              child: Text('Food Savior')
          ),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            })
          ],

        ),


      drawer: new Drawer(
        child: Container(
          color: Colors.white,
          child: new ListView(
//            padding: EdgeInsets.all(0.0),
            children: <Widget>[

              new UserAccountsDrawerHeader(
                accountName: new Text("Dunhan Chen"),
                accountEmail: new Text("chendunhan622@gmail.com"),
                currentAccountPicture: new CircleAvatar(
                    backgroundImage: new AssetImage('assets/images/AccountPic.jpeg')

                ),
                decoration: new BoxDecoration(
                  color: Colors.redAccent,
                    /*
                    image: new DecorationImage(
                      image: new NetworkImage(mainProfileImage),
                      fit: BoxFit.cover,
                    )
                     */
                ),
              ),
              new Divider(
                indent: 15,
                endIndent: 15,),
              new ListTile(
                title: new Text("Home"),
                leading: new Icon(Icons.home),
              ),
              new ListTile(
                title: new Text("My Account"),
                leading: new Icon(Icons.account_circle),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Profile(),fullscreenDialog: true));
                },
              ),
              new ListTile(
                title: new Text("My Oders"),
                leading: new Icon(Icons.shopping_basket),
              ),
              new Divider(
                indent: 15,
                endIndent: 15,
              ),
              new ListTile(
                title: new Text("Setting"),
                leading: new Icon(Icons.settings),
              ),
              new ListTile(

                leading: new Icon(Icons.exit_to_app),
                title: new Text("Log out"),

                onTap: (){
                  logOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyLoginPage(),fullscreenDialog: true));
                },
              ),
              new Divider(
                indent: 15,
                endIndent: 15,
              )
            ],
          ),
        ),
      ),

      body:

        new ListView(

        children: <Widget>[
          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text("Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0
              ),
            ),
          ),
          //horizontal list view
          HorizontalList(),
          HorizontalList1(),
          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text("What's available",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0
            ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                carouselSlider = CarouselSlider(
                  height: 150.0,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  reverse: false,
                  enableInfiniteScroll: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  items: imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(imgList, (index, url) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? Colors.blueGrey : Colors.grey,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

        ],

      ),



    );
  }
}

Future<void> logOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
  } catch (e) {
    print("error logging out");
  }
}

