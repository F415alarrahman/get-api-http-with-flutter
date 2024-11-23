import 'package:flutter/material.dart';
import 'package:week8/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthService _authService = AuthService();
  void _login(context) async {
    try {
      final response = await _authService.login(
          _emailController.text, _passwordController.text);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response["message"])));
      if (response["status"]) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: "Password"),
          ),
          ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text("Login")),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Belum punya akun? Daftar dong disini!"))
        ],
      ),
    );
  }
}
