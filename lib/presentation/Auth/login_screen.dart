import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holistic_core_wellness_mobileapp/presentation/Core/hcw_colors.dart';

import 'widgets/hcw_text_field.dart';
import 'auth_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtl = TextEditingController();
  final passCtl = TextEditingController();
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    final colors = HCWColors();
    return AuthScaffold(
      title: 'Login',
      subtitle: 'Securely login to your account',
      children: [
        const SizedBox(height: 8),
        HCWTextField(
            hint: 'Emulodavid@gmail.com',
            icon: Icons.mail_outline,
            controller: emailCtl),
        const SizedBox(height: 12),
        HCWTextField(
            hint: '@Test2023',
            icon: Icons.lock_outline,
            controller: passCtl,
            obscure: true),
        const SizedBox(height: 8),
        Row(
          children: [
            Checkbox(
                value: remember,
                onChanged: (v) => setState(() => remember = v ?? false)),
            const Text('Remember me'),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('LOG IN'),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot Password'),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Create an Account '),
            GestureDetector(
              onTap: () => context.go('/signup'),
              child: Text('Sign Up',
                  style: TextStyle(
                      color: colors.teal, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ],
    );
  }
}
