// import tetap
import 'package:flutter/material.dart';
import 'package:petcare/pages/signin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "PetCare",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 5),
            const Text(
              "Rawat Hewan Kesayangan dengan\nLebih Mudah",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF2686C2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.login_rounded,
                            size: 40,
                            color: Color(0xFF2686C2),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        buildInputField(
                          label: "Nomor Telepon",
                          icon: Icons.phone,
                          hintText: "No Telepon",
                          controller: _phoneController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Nomor telepon wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        buildInputField(
                          label: "Nama",
                          icon: Icons.person,
                          hintText: "Nama",
                          controller: _nameController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Nama wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        buildInputField(
                          label: "Password",
                          icon: Icons.lock,
                          hintText: "Password",
                          isPassword: true,
                          controller: _passwordController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Password wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // aksi simpan data atau kirim ke backend
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Sudah Punya Akun?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildSocialButton("lib/images/Google.png", 40),
                            const SizedBox(width: 15),
                            buildSocialButton("lib/images/facebook.png", 40),
                            const SizedBox(width: 15),
                            buildSocialButton("lib/images/instagram.png", 40),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField({
    required String label,
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon:
                isPassword
                    ? const Icon(Icons.visibility_off, color: Colors.grey)
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSocialButton(String imagePath, double size) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
