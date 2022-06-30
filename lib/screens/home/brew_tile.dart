import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  const BrewTile({required this.brew, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(20.0,7.0,0.0,7.0),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/coffee_icon.png"),
            radius: 30.0,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19.0
          ),),
          subtitle: Text("Takes ${brew.sugar} Sugar(s)"),
        ),
      ),
    );
  }
}
