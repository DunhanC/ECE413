import 'package:flutter/material.dart';
import 'package:fs_login/Pages/Setup/signIn.dart';
import 'package:fs_login/Pages/home.dart';
import 'package:fs_login/fruitStorage.dart';
import 'package:fs_login/fruit_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:fs_login/auth_notifier.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => AuthNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context) => FruitNotifier(),
    ),
  ],
  child: MyApp(),
)
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child){
          return notifier.user != null ? Home(): MyLoginPage();
        },
      ),
    );
  }
}
