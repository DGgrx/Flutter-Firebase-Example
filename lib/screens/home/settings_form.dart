import 'package:flutter/material.dart';
import 'package:flutter_firebase/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            "Update your Brew User Settings.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: textInputDecoration("Name").copyWith(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.brown.withOpacity(0.7), width: 2.0))),
            validator: (value) => value!.isEmpty ? "Please Enter a name" : null,
            onChanged: (value) => setState(() => _currentName = value),
          ),
          const SizedBox(
            height: 20.0,
          ),

          //dropdown
          DropdownButtonFormField(
            decoration: textInputDecoration("Sugars").copyWith(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.brown.withOpacity(0.7), width: 2.0))),
            value: _currentSugars ?? '0',
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text("$sugar Sugars"),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSugars = val as String?),
          ),
          const SizedBox(
            height: 20.0,
          ),

          //slider

          const SizedBox(
            height: 20.0,
          ),
          Slider(
              inactiveColor: Colors.brown[300],
              activeColor: Colors.brown[_currentStrength ?? 100],
              value: (_currentStrength ?? 100).toDouble(),
              min: 100,
              max: 900,
              divisions: 8,
              onChanged: (val) =>
                  setState(() => _currentStrength = val.round())),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                print(_currentName);
                print(_currentStrength);
                print(_currentSugars);
              }
            },
            icon: const Icon(
              Icons.update,
              color: Colors.white,
            ),
            label: const Text(
              "Update",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
                backgroundColor: MaterialStateProperty.all(Colors.brown[500])),
          ),
        ],
      ),
    );
  }
}
