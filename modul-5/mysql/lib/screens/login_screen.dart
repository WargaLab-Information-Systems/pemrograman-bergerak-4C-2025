import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import 'screen.dart'; // Import file screen.dart

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        await _authService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (!mounted) return;

        // Arahkan ke Screen setelah login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DoaPage()),
        );
      } catch (e) {
        setState(() {
          _errorMessage = _getFirebaseErrorMessage(e.toString());
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

 String _getFirebaseErrorMessage(String error) {
  if (error.contains('user-not-found')) {
    return 'Email tidak ditemukan';
  } else if (error.contains('wrong-password')) {
    return 'Password salah';
  } else if (error.contains('invalid-email')) {
    return 'Format email tidak valid';
  } else if (error.contains('user-disabled')) {
    return 'Akun telah dinonaktifkan';
  } else if (error.contains('too-many-requests')) {
    return 'Terlalu banyak percobaan login. Coba lagi nanti';
  } else if (error.contains('invalid-credential')) {
    return 'Email atau password salah atau tidak valid.';
  } else {
    return 'Terjadi kesalahan: $error';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Toko Laptop Lenovo'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Icon(
                      Icons.laptop,
                      size: 80,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Silakan login untuk melanjutkan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    if (_errorMessage.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red[800]),
                        ),
                      ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!value.contains('@')) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _login,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Belum punya akun?'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text('Daftar Sekarang'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
