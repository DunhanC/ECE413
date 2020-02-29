import 'package:flutter/material.dart';
import 'package:fs_login/donation.dart';
import 'package:fs_login/reserve.dart';
class Modal{

  mainBottomSheet(BuildContext context){

    showModalBottomSheet(context: context,
        builder: (BuildContext context){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _createTile(context, 'Donate', Icons.card_giftcard, _action1),
                _createTile(context, 'Reserve', Icons.assignment_returned, _action2),
              ],

            );

        });
  }
  ListTile _createTile(BuildContext context, String name, IconData icon, Function action){

    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: (){
        
        Navigator.pop(context);
        action(context);
        
      },
    );

  }

  _action1(BuildContext context){

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Donation(),fullscreenDialog: true));
  }

  _action2(BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Reservation(),fullscreenDialog: true));
  }
}