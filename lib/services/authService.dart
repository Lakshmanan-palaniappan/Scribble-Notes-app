import 'package:awesome_notes/change_notifier/registration_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;

  static Stream<User?> get userStream => _auth.userChanges();

  static bool get isemailVerified => user?.emailVerified ?? false;

  static User? get user => _auth.currentUser;

  static Future<void> logout()async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  static Future<void> register({
    required String fullName, required String email, required String password
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((credential) {
        credential.user?.sendEmailVerification();
        credential.user?.updateDisplayName(fullName);
      });
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }

  static Future<void> login(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

    } catch (e) {
      rethrow;
    }
  }
  static Future<void> resetPassword({
    required String email
  })async{
    await _auth.sendPasswordResetEmail(email: email);
    
  }


  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser==null){
       throw const NoGoogleAccountChosenException();
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}