// Providers.dart
// import 'package:bkni/src/favorite_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Favorite Controller


final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final userChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

/*
final favoriteControllerProvider =
    StateNotifierProvider<FavoriteController, List<DocumentSnapshot>>((ref) {
  final user = ref.watch(userChangesProvider);
  if (user.data?.value?.uid != null) {
    return FavoriteController(user.data!.value!.uid);
  } else {
    return FavoriteController(null);
  }
}); */
