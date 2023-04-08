import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/state/auth/constants/constants.dart';
import 'package:instagram_clone/state/auth/models/auth_result.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

class Authenticator {
  const Authenticator();

  User? get currentUser => FirebaseAuth.instance.currentUser;
  UserId? get userId => currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => currentUser?.displayName ?? '';
  String? get email => currentUser?.email;
  final String me = '';

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResult> loginWithFacebook() async {
    //this will display the facebook login dialog to the user
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (token == null) {
      // User has aborted the logging in process
      return AuthResult.aborted;
    }

    //Get the token
    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      //Sign in with the token
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);

      //If successful return success
      return AuthResult.success;
    } //If failed
    on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        //If user has logged in with google before
        if (providers.contains(Constants.googleCom)) {
          //Login with google
          await loginWithGoogle();

          //Link both the facebook and google credentials
          currentUser?.linkWithCredential(credential);
        }

        //If the code above runs successfully, then the user has successfully logged in
        return AuthResult.success;
      }
      //Else failure
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      Constants.emailScope,
    ]);

    //This will display the google sign in dialog to the user
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
