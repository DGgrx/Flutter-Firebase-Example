import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';



class Register extends StatefulWidget {

  final Function? toggleView;
  const Register({this.toggleView,Key? key}): super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  bool _isButtonEnabled = true;
  final _formKey = GlobalKey<FormState>();

  //Regex
  RegExp emailReg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String email = "";
  String password = "";
  String error = "";

  //loading Screen
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.1),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
          child: Text(
            "Brew Crew",
            style: TextStyle(
                fontFamily: "HumbleCafe",
                fontSize: 45.0,
                letterSpacing: 3.0,
                color: Colors.brown[600],
                fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/base.jpg"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 230.0, 30.0, 0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: textInputDecoration("Email ID"),

                      validator: (value) =>
                        emailReg.hasMatch("$value") ? null : "Enter a valid Email ID."
                      ,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: textInputDecoration("Password"),
                      validator: (value) => value!.length < 8 ? "Must be at least 6 characters in length.": null ,
                      onChanged: (value) {
                        setState(() {password = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: _isButtonEnabled
                          ? () async {

                        setState(() {
                          _isButtonEnabled = false;
                        });

                        if(_formKey.currentState!.validate()){
                          setState(()=>loading = true);
                                dynamic result = await _auth.registerWithEmailandPass(email, password);
                                if(result == null){
                                  setState(() {
                                    error =
                                    "Please check your email and password and try again !";
                                    _isButtonEnabled = true;
                                    loading = false;
                                  });
                                }
                              }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(13.0),
                          primary: Colors.brown[400]
                      ),
                      icon: Icon(Icons.person_add_alt_1)
                      ,
                      label: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red[600],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0
                      ),
                    ),
                    SizedBox(
                      height: error.isEmpty ? 240.0 : 215.0,
                    ),
                    TextButton(
                      onPressed: () {
                        widget.toggleView!();
                      },
                      child: const Text("Already a User ? Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
