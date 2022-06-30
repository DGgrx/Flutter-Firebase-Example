import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/screens/home/brew-list.dart';
import 'package:flutter_firebase/screens/home/settings_form.dart';
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

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.all(20.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[500],
          title: const Text(
            "Brew Crew",
            style: TextStyle(
                fontFamily: "HumbleCafe",
                fontSize: 38.0,
                letterSpacing: 2.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.logout_outlined),
            ),
            IconButton(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
