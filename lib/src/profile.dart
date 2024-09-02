import 'package:bkni/colors.dart';
import 'package:bkni/src/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String logoName = "assets/images/logo_vector.svg";
  final String google = "assets/images/google.svg";

  void _incrementCounter() {
    setState(() {});
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  logoName,
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "  Join\nBukon!",
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    backgroundColor: Colors.black,
                  ),
                  onPressed:() {
                    AuthService().signInWithGoogle();
                  },
                  child: Row(
                    children: [
                      //Icon(Icons.facebook_outlined, color: Colors.blueAccent,),
                      SvgPicture.asset(
                        google,
                        height: 25,
                        width: 25,
                        fit: BoxFit.scaleDown,
                        colorFilter:
                            const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Sign Up With Google",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(280, 50),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: _incrementCounter,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.facebook_outlined,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Sign Up With Facebook",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: _incrementCounter,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.mail_outlined,
                        color: Color(0xFF6D6D6D),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Sign Up With Email",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Color(0xFF6D6D6D)),
                      children: [
                        TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: "Sign in",
                          style: TextStyle(color: mcgpalette0),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Color(0xFF6D6D6D)),
                      children: [
                        TextSpan(text: "By signing up, you agree to our "),
                        TextSpan(
                          text: "Terms of",
                          style: TextStyle(color: mcgpalette0),
                        ),
                      ]),
                ),
                RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Color(0xFF6D6D6D)),
                      children: [
                        TextSpan(
                          text: "Service ",
                          style: TextStyle(color: mcgpalette0),
                        ),
                        TextSpan(text: "and acknowledge that our "),
                        TextSpan(
                          text: "Privacy",
                          style: TextStyle(color: mcgpalette0),
                        ),
                      ]),
                ),
                RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Color(0xFF6D6D6D)),
                      children: [
                        TextSpan(
                          text: "Policy ",
                          style: TextStyle(color: mcgpalette0),
                        ),
                        TextSpan(text: "applies to you."),
                      ]),
                ),
                const SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
