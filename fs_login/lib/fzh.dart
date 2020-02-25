import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
    State<StatefulWidget>createState(){
      return MyAppState();
  }
}
class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final tabs = [
    Center(child:Text('Item 1')),
    Center(child:Text('Item 2')),
    Center(child: Text('Item 3')),
    Center(child:Text('Item 4')),
    Center(child:Text('Item 5')),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('FoodSvaior')),
       body: tabs[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          selectedFontSize: 13,
          unselectedFontSize: 11,
          backgroundColor: Colors.white,
          //selectedItemColor: Colors.green, // 选中的tab的icon与title的颜色。与fixedColor互斥，效果与fixedColor貌似一样
          //unselectedItemColor: Colors.black,// 非选中状态的tab的icon与title的颜色。
          selectedIconTheme: IconThemeData(color: Colors.blue,opacity: 1),
          unselectedIconTheme: IconThemeData(color: Colors.black26,opacity: 1),

          onTap: (index){
            setState(() {
              _selectedPage = index;
            });
          },
         items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home',style:TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: Colors.black12
            ),
           BottomNavigationBarItem(
               icon: Icon(Icons.place),
               title: Text('Map',style: TextStyle(fontWeight: FontWeight.bold)),
               backgroundColor: Colors.black12
           ),
           BottomNavigationBarItem(
               icon: Icon(Icons.add_circle_outline),
               title: Text(''),
               backgroundColor: Colors.black12
           ),
           BottomNavigationBarItem(
               icon: Icon(Icons.bookmark_border),
               title: Text('Favorite',style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold)),
               backgroundColor: Colors.black12
           ),
           BottomNavigationBarItem(
               icon: Icon(Icons.rate_review),
               title: Text('Feedback',style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold)),
               backgroundColor: Colors.black12
           ),
        ],
        ),
      ),
    );
  }
}