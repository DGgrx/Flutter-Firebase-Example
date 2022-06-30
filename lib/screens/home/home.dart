import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/screens/home/brew-list.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      initialData: [] ,
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Brew Crew"),
          actions: <Widget>[
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.settings),
            ),
            IconButton(
                onPressed: ()async{
                  await _auth.signOut();
                },
                icon: Icon(Icons.logout_outlined),
            )
          ],
        ),
        body: BrewList(),

      ),
    );
  }
}
