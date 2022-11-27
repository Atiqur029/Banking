import 'package:banking/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<Map<String, String>?> Signingoogle() async {
  await Firebase.initializeApp();
  final googleSigninAccount = await googleSignIn.signIn();
  final authentication = await googleSigninAccount!.authentication;
  final credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken, idToken: authentication.idToken);

  final authresult = await auth.signInWithCredential(credential);
  final User? user = authresult.user;
  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final currentUser = auth.currentUser;
    assert(user.uid == currentUser!.uid);
    String userName = user.displayName.toString();
    String userEmail = user.email.toString();
    String userImgUrl = user.photoURL.toString();
    return {
      "userName": userName,
      "userEmail": userEmail,
      "userImgUrl": userImgUrl
    };
  }
  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
}
