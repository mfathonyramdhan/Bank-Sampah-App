import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../extension/firebase_user_extension.dart';
import '../models/response_handler.dart';
import '../models/user.dart' as model;
import '../services/user_services.dart';

class SocialServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<ResponseHandler> signInGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return ResponseHandler(
        success: false, 
        message: "Google Sign In Cancelled",
      );
    }

    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential result = await _auth.signInWithCredential(credential);
    final User? user = result.user;

    model.User userConverted = result.user!.convertToUser(
      name: result.user!.displayName,
    );

    await UserServices.updateUser(userConverted);

    return ResponseHandler(
      user: user,
      success: true,
      message: "Success Google Sign In",
    );
  }
}