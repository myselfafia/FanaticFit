import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [

              const SizedBox(height: 30),

              // LOGO
              Image.asset(
                "assets/images/fanaticfit.png",
                height: 120,
              ),

              const SizedBox(height: 60),

              // EMAIL FIELD
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // PASSWORD FIELD
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.grey.shade400),
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
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // CONFIRM PASSWORD FIELD
              TextField(
                controller: confirmController,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.grey.shade400),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirm = !_obscureConfirm;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // CREATE ACCOUNT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {

                    if (passwordController.text ==
                        confirmController.text) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Account Created Successfully"),
                        ),
                      );

                      Navigator.pop(context);

                    } else {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content:
                          Text("Passwords do not match"),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}