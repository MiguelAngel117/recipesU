import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipes/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _passwordError = '';
  String _confirmPasswordError = '';

  void register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final name = _nameController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Las contraseñas no coinciden")));
      return;
    }

    try {
      await authService.signUpWithEmailAndPassword(email, password);
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: " + e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          //Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Nombre', border: OutlineInputBorder()),
            ),
          ),
          //Email
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
          ),
          //Password
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                errorText: _passwordError.isEmpty ? null : _passwordError,
              ),
              onChanged: (value) {
                setState(() {
                  _passwordError = _validatePassword(value);
                });
              },
            ),
          ),
          //Confirm Password
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                errorText: _confirmPasswordError.isEmpty
                    ? null
                    : _confirmPasswordError,
              ),
              onChanged: (value) {
                setState(() {
                  _confirmPasswordError = _validateConfirmPassword(value);
                });
              },
            ),
          ),
          //Register Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: register,
              child: const Text('Registrarse'),
            ),
          ),
          Center(
              child:
                  Lottie.asset('assets/images/Animation - 1732679714279.json')),
        ],
      ),
    );
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'La contraseña no puede estar vacía';
    } else if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra mayúscula';
    } else if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
      return 'La contraseña debe tener al menos un número';
    }
    return '';
  }

  String _validateConfirmPassword(String value) {
    if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return '';
  }
}
