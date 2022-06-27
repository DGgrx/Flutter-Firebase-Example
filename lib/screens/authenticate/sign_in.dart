import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;

  const SignIn({this.toggleView, Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool _isButtonEnabled = true;
  final _formKey = GlobalKey<FormState>();

  //regex
  RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        centerTitle: true,
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
                    validator: (value) => emailReg.hasMatch("$value")
                        ? null
                        : "Enter a valid Email ID.",
                    onChanged: (value) {
                      setState(() => email = value);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration("Password"),
                    obscureText: true,
                    validator: (value) => value!.length < 8
                        ? "Must be at least 6 characters in length."
                        : null,
                    onChanged: (value) {
                      setState(() => password = value);
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

                            if (_formKey.currentState!.validate()) {
                              dynamic result = await _auth
                                  .signInWithEmailandPass(email, password);
                              if (result == null) {
                                setState(() => error =
                                    "Please check your email and password and try again !");
                              }
                            }

                            setState(() {
                              _isButtonEnabled = true;
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(13.0),
                        primary: Colors.brown[400]),
                    icon: Icon(Icons.login_outlined),
                    label: const Text(
                      "Sign In",
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
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 240.0,
                  ),
                  TextButton(
                    onPressed: () {
                      widget.toggleView!();
                    },
                    child: const Text(
                      "Not a User ? Register Now !",
                      style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
