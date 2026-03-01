import 'package:flutter/material.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController usernameController =
  TextEditingController();
  final TextEditingController passwordController =
  TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      // BACK BUTTON APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [

              const SizedBox(height: 30),

              // LOGO
              Image.asset(
                "assets/images/fanaticfit.png",
                height: 120,
              ),

              const SizedBox(height: 60),

              // USERNAME FIELD
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  enabledBorder:
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.shade400),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // PASSWORD FIELD WITH SHOW/HIDE
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder:
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.shade400),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                        !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Row(
                children: [

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.bold),
                    ),
                  ),

                  const SizedBox(width: 20),

                  const Text(
                    "Forgot Password?",
                    style:
                    TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const SignupScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Create New Account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}