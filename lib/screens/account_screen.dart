import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          // Logo header with back button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: Colors.grey.shade200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Image.asset("assets/images/fanaticfit.png", height: 70),
                ),
                Positioned(
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 36),
                const Text("Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),

                // Show Login only if NOT logged in
                if (user == null)
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                    child: _box(Icons.person_outline, "Login to your account"),
                  ),

                if (user == null) const SizedBox(height: 16),

                // Show Sign Out only if logged in
                if (user != null)
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                            (route) => false,
                      );
                    },
                    child: _box(Icons.logout, "Sign Out"),
                  ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable box widget
  Widget _box(IconData icon, String label) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 15, color: Colors.black87)),
        ],
      ),
    );
  }
}