import 'package:flutter/material.dart';
import 'register.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget {
  final String? registeredUsername;
  final String? registeredPassword;

  const LoginScreen({super.key, this.registeredUsername, this.registeredPassword});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

void _login() {
  final inputUsername = usernameController.text;
  final inputPassword = passwordController.text;

  if (inputUsername.isEmpty || inputPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Username dan Password wajib diisi")),
    );
    return;
  }

  if (inputUsername == widget.registeredUsername &&
      inputPassword == widget.registeredPassword) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HealthTrackerPage()), // Bukan HealthTrackerApp!
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Username atau Password salah")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                ),
              ),
            ),
            const SizedBox(height: 30),
             ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // warna background tombol
                  foregroundColor: Colors.white, // warna teks tombol (jadi putih)
                  minimumSize: const Size(double.infinity, 60), // full width & tinggi lebih besar
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _login,
                child: const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  },
                  child: const Text('Sign Up', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
