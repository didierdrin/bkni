import 'package:bkni/colors.dart';
import 'package:bkni/src/auth.dart';
import 'package:bkni/src/settings.dart';
import 'package:flutter/material.dart';
// imports - General Dependencies.
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'colors.dart';
// Providers
// import 'package:bkni/src/providers.dart';
import 'firebaseOptions.dart';

Future<void> initializeFirebase() async {
  FirebaseApp app = await Firebase.initializeApp(
    options: const MyCustomFirebaseOptions(), name: "bkniapp"
  );

  if (Firebase.apps.isEmpty) {
    app = await Firebase.initializeApp(
      options: const MyCustomFirebaseOptions(), name: "bkniapp1"
    );
  } else {
    app = Firebase.app();
  }
}

//Firebase.initializeApp(options: const MyCustomFirebaseOptions(),);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bukoni',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: mcgpalette0),
        useMaterial3: true,
      ),
      home: AuthService().handleAuthState(),
      routes: {
        "/settings": (_) => const SettingsPage(),
      },
    );
  }
}
