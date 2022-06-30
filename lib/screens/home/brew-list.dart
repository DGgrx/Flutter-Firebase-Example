import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/models/brew.dart';


class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context);
    for (var brew in brews) {
      print(brew.name);
      print(brew.sugar);
      print(brew.strength);
    }

    return Container(

    );
  }
}
