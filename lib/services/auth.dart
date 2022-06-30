import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  UserCustom? _userFromFirebaseUser(User? user ){
    return user!= null ? UserCustom(uid: user.uid): null ;
  }

  //Auth change user stream
  Stream<UserCustom?> get user{
    return _auth.authStateChanges()
        .map((User? user)=> _userFromFirebaseUser(user));

  }

  //sign in anon
  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e);
      return null;
    }
}

  //sign in with email and pass
  Future signInWithEmailandPass(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      print(user);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e);
      return null;
    }
  }


  //register with email and pass
  Future registerWithEmailandPass(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData("New User", "0", 100);

      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e);
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      await _auth.signOut();

    }catch(e){
      print(e.toString());
      return null;
    }
  }

}