// Firebase Authentification Logics
// import 'package:firebase_core/firebase_core.dart';
import 'package:bkni/src/home.dart';
import 'package:bkni/src/product_service.dart';
import 'package:flutter/material.dart';
import 'package:bkni/src/control.dart';
import 'package:bkni/src/profile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  // 1. handleAuthState

  // 2. Sign in with Google()

  // 3. Signout()
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Determine if the user is authenticated.
  // handleAuthState() {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return const ControlPage(
  //             customIndex: 0,
  //             product: widget.product,
  //           );
  //         } else {
  //           return const ProfilePage();
  //         }
  //       });
  // }

  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<List<ProductData>>(
            future: ProductService.getProductList(),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.done) {
                if (productSnapshot.hasData &&
                    productSnapshot.data!.isNotEmpty) {
                  // Ensure the list is not empty before accessing the first element
                  return ControlPage(
                    customIndex: 0,
                    product:
                        productSnapshot.data!.first, // Pass the first product
                  );
                } else {
                  return const Center(child: Text('No products available'));
                }
              } else {
                return const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          );
        } else {
          return const ProfilePage();
        }
      },
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>['email']).signIn();
      if (googleUser == null) {
        return null; // user cancelled
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create credential using only idToken (accessToken no longer exposed)
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status != LoginStatus.success ||
          loginResult.accessToken == null) {
        return null;
      }

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } catch (e) {
      print("Facebook sign-in error: $e");
      return null;
    }
  }

  /// Returns null on success, or an error message String on failure.
  Future<String?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _emailAuthErrorMessage(e.code);
    } catch (e) {
      return 'Sign up failed. Please try again.';
    }
  }

  /// Returns null on success, or an error message String on failure.
  Future<String?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _emailAuthErrorMessage(e.code);
    } catch (e) {
      return 'Sign in failed. Please try again.';
    }
  }

  static String _emailAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Try signing in.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Wrong password.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}

//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // Trigger the flow
//       // final GoogleSignInAccount? googleUser =
//       //     await GoogleSignIn(scopes: <String>["email"]).signIn();

//     final GoogleSignInAccount? googleUser =
//     await GoogleSignIn.instance.signIn();

//       if (googleUser == null) {
//         return null; // User might have canceled sign-in
//       }

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // Create a new credential (idToken is sufficient with recent google_sign_in)
//       final credential =
//           GoogleAuthProvider.credential(idToken: googleAuth.idToken);

//       // Once signed in, return the UserCredential
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       print("Error signing in with Google: ${e.code}");
//       // Handle specific FirebaseAuthException codes here
//       // (e.g., show error message to user)
//       return null;
//     } catch (e) {
//       print("Error signing in: $e");
//       // Handle other exceptions
//       return null;
//     }
//   }
// }
