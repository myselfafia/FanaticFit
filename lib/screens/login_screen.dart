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

  bool _password = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade200,

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

              Image.asset(
                "assets/images/fanaticfit.png",
                height: 120,
              ),

              const SizedBox(height: 60),

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

              TextField(
                controller: passwordController,
                obscureText: _password,
                decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder:
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.shade400),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _password
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _password =
                        !_password;
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
                      backgroundColor: Colors.red,
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
                          FontWeight.bold,
                      color: Colors.white),
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
                    color: Colors.black
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