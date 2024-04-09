import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign Up',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            AuthField(hintText: 'name', controller: nameController),
            const SizedBox(height: 10),
            AuthField(hintText: 'email', controller: emailController),
            const SizedBox(height: 10),
            AuthField(hintText: 'password', controller: passwordController)
          ],
        ),
      ),
    );
  }
}
