import 'package:duet_clinic/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

String categoryNameWhenUserLogin = '';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  MyUser _userFromFirebase(User user) {
    return MyUser(uid: user.uid, photoURL: user.photoURL!, displayName: user.displayName!, email: user.email!);
  }

  //stream for auth state change
  Stream<MyUser> get user {
    return _auth.authStateChanges().map((firebaseUser) => _userFromFirebase(firebaseUser!));
  }

  //code for signin with google goes here
  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleSignInAuthentication = await _googleSignInAccount!.authentication;

      final AuthCredential _credential = GoogleAuthProvider.credential(
        accessToken: _googleSignInAuthentication.accessToken,
        idToken: _googleSignInAuthentication.idToken,
      );

      final UserCredential _authResult = await _auth.signInWithCredential(_credential);
      final User? _user = _authResult.user;

      if (_user != null) {
        assert(!_user.isAnonymous);
        final User? _currentUser = _auth.currentUser;
        assert(_user.uid == _currentUser!.uid);
        debugPrint("sign in with google succed ${_user.uid}");
        categoryNameWhenUserLogin=_user.uid;
        return '$_user';
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  //code for signout goes here
  Future signOutGoogle() async {
    try {
      debugPrint("User Signed Out");
      await _auth.signOut();
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint("Error in signout");
      debugPrint(e.toString());
    }
  }
}
