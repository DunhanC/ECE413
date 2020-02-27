import 'package:flutter/material.dart';
import 'package:fs_login/Pages/BottomNavigation/naviHome.dart';
import 'package:fs_login/Pages/BottomNavigation/naviMap.dart';
import 'package:fs_login/Pages/BottomNavigation/naviFavor.dart';
import 'package:fs_login/Pages/BottomNavigation/naviFeeback.dart';
import 'package:fs_login/Modal.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Modal modal = new Modal();
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    NHome(),
    NFavor(),
    NMap(),

    NFeeback(),
  ];
  // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = NHome(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: () => modal.mainBottomSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            NHome(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.redAccent : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.redAccent : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            NFavor(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.bookmark_border,
                          color: currentTab == 1 ? Colors.redAccent : Colors.grey,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.redAccent : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            NMap(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.place,
                          color: currentTab == 2 ? Colors.redAccent : Colors.grey,
                        ),
                        Text(
                          'Map',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.redAccent : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            NFeeback(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.rate_review,
                          color: currentTab == 3 ? Colors.redAccent : Colors.grey,
                        ),
                        Text(
                          'Feedback',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.redAccent : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }


  }
