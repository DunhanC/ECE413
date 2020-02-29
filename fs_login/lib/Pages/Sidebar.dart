import 'package:flutter/material.dart';

class SideBar extends StatelessWidget{
  String mainProfileImage = "http://hd.wallpaperswide.com/thumbs/coffee_bokeh_2-t2.jpg";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Dunhan Chen"),
              accountEmail: new Text("chendunhan622@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                  backgroundImage: new AssetImage('assets/images/AccountPic.jpeg')

              ),
              decoration: new BoxDecoration(

                  image: new DecorationImage(
                    image: new NetworkImage(mainProfileImage),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Page One"),
              trailing: new Icon(Icons.arrow_drop_down_circle),
            ),
            new ListTile(
              title: new Text("Page Two"),
              trailing: new Icon(Icons.arrow_drop_down_circle),
            ),
            new ListTile(
              title: new Text("Page Three"),
              trailing: new Icon(Icons.arrow_drop_down_circle),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Page Four"),
              trailing: new Icon(Icons.arrow_drop_down_circle),
            ),
            new ListTile(
              title: new Text("Page Five"),
              trailing: new Icon(Icons.arrow_drop_down_circle),
            ),
            new Divider()
          ],
        ),
      ),
    );
  }





}