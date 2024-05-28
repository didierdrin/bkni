// Current Profile Page
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentProfile extends StatefulWidget {
  const CurrentProfile({super.key});
  @override
  State<CurrentProfile> createState() => _CurrentProfile();
}

class _CurrentProfile extends State<CurrentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60,),
            Container(
              height: 100, 
              width: 100,
              decoration: const BoxDecoration(shape: BoxShape.circle,),
              child: Image.network("${FirebaseAuth.instance.currentUser!.photoURL}", fit: BoxFit.cover,),
            ),
            const SizedBox(height: 20,),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            const SizedBox(height: 10,),
            Text("${FirebaseAuth.instance.currentUser!.email}"),
            
          ],
        ),
      ),
    );
  }
}
