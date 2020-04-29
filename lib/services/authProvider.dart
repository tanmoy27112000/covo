import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _auth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
  );

  Future<bool> loginWithGoogle() async {
    GoogleSignInAccount account = await googleSignIn.signIn();
    AuthResult res = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken));
    return res.additionalUserInfo.isNewUser;
  }
  Future<FirebaseUser> getCurrentUser()async {
    return await _auth.currentUser();
  }
  signOut(){
    return _auth.signOut();
  }
}
