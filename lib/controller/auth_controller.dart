import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final Rx<User?> user = Rx<User?>(null);

  var googleuse = Rx<GoogleSignInAccount?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(auth.authStateChanges());
  }

  Future<void> googleSignIn() async {
    final GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
    googleuse.value = googleUser;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential).then((value) {
      Get.back();
    }).catchError((e) {
      Get.snackbar("Auth error", e.toString());
    });
  }

  Future<void> googleSignOut() async {
    await _googleSignIn.signOut().then((value) {
      user.value = null;
      googleuse.value = null;
    });
  }
}
