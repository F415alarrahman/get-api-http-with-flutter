import 'package:flutter/material.dart';
import 'package:week8/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AuthService _authService = AuthService();

  String? _nameError;

  String? _emailError;

  String? _passwordError;

  void _register(context) async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _retypePasswordController.text) {
        try {
          final response = await _authService.register(_nameController.text,
              _emailController.text, _passwordController.text);
          print(response);
          if (response["status"]) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(response["message"])));
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            setState(() {
              _nameError = response["error"]["name"]?[0];
              _emailError = response["error"]["email"]?[0];
              _passwordError = response["error"]["password"]?[0];
            });
          }
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Failed: $e")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Password do not match")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                    InputDecoration(labelText: "Name", errorText: _nameError),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    InputDecoration(labelText: "Email", errorText: _emailError),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", errorText: _passwordError),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _retypePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Retype Password", errorText: _passwordError),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password ';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    _register(context);
                  },
                  child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}
