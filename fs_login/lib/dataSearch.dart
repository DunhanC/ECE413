import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {

  final foods = [
    "Soup",
    "Ice Cream",
    "Chocolate",
    "Apple",
    "Banana",

  ];

  final recentFoods = [
    "Coffee",
    "Bread",
    "Pizza",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Card(

      color: Colors.red,
      child: Center(
        child: Text(query),
      ),

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentFoods
        : foods.where((p)=> p .startsWith(query)).toList();
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemBuilder: (context, index)=> ListTile(
        onTap: (){

          showResults(context);

        },

      leading: Icon(Icons.fastfood),
      title: RichText(text: TextSpan(
        text: suggestionList[index].substring(0,query.length),
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold),
        children: [TextSpan(
          text: suggestionList[index].substring(query.length),
          style: TextStyle(color: Colors.grey)
        )]
        ),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }





}