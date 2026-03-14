import 'package:bkni/colors.dart';
import 'package:bkni/src/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String logoName = "assets/images/logo_vector.svg";
  final String boldLogo = "assets/images/bold_logo.png";
  final String google = "assets/images/google.svg";
  bool _isSignIn = false;
  bool _useEmail = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                Image.asset(
                  boldLogo,
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  _isSignIn ? "Welcome\n   Back!" : "  Join\nBukon!",
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!_useEmail) ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 50),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      AuthService().signInWithGoogle();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          google,
                          height: 25,
                          width: 25,
                          fit: BoxFit.scaleDown,
                          colorFilter: const ColorFilter.mode(
                              Colors.red, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _isSignIn
                              ? "Sign In With Google"
                              : "Sign Up With Google",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      AuthService().signInWithFacebook();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.facebook_outlined,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _isSignIn
                              ? "Sign In With Facebook"
                              : "Sign Up With Facebook",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _useEmail = true;
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mail_outlined,
                          color: Color(0xFF6D6D6D),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _isSignIn
                              ? "Sign In With Email"
                              : "Sign Up With Email",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _passwordObscured,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordObscured = !_passwordObscured;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          if (!_isSignIn) ...[
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _confirmPasswordObscured,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _confirmPasswordObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _confirmPasswordObscured =
                                          !_confirmPasswordObscured;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (!_isSignIn) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                }
                                return null;
                              },
                            ),
                          ],
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState?.validate() !=
                                          true) return;
                                      setState(() => _isLoading = true);
                                      String? error;
                                      if (_isSignIn) {
                                        error =
                                            await AuthService().signInWithEmail(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                        );
                                      } else {
                                        error =
                                            await AuthService().signUpWithEmail(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                        );
                                      }
                                      if (!mounted) return;
                                      setState(() => _isLoading = false);
                                      if (error != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(error),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(_isSignIn
                                                ? 'Signed in successfully!'
                                                : 'Account created!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    },
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      _isSignIn ? 'Sign In' : 'Sign Up',
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _useEmail = false;
                              });
                            },
                            child: const Text('Back to other options'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Color(0xFF6D6D6D)),
                      children: [
                        TextSpan(
                            text: _isSignIn
                                ? "Don't have an account? "
                                : "Already have an account? "),
                        TextSpan(
                          text: _isSignIn ? "Sign up" : "Sign in",
                          style: const TextStyle(color: mcgpalette0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                _isSignIn = !_isSignIn;
                              });
                            },
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
