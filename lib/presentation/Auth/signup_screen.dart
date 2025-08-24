import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Core/hcw_colors.dart';
import 'widgets/hcw_text_field.dart';
import 'auth_scaffold.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = HCWColors();
    return AuthScaffold(
      title: 'Create an account',
      subtitle: 'Securely login to your account',
      children: const [
        SizedBox(height: 8),
        HCWTextField(hint: 'Full Name', icon: Icons.person_outline),
        SizedBox(height: 12),
        HCWTextField(
            hint: 'Email address',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress),
        SizedBox(height: 12),
        HCWTextField(
            hint: 'Enter number',
            icon: Icons.call_outlined,
            keyboardType: TextInputType.phone),
        SizedBox(height: 12),
        HCWTextField(hint: 'Password', icon: Icons.lock_outline, obscure: true),
      ],
      bottom: Column(
        children: [
          SizedBox(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/profile-setup'),
              child: const Text('Create Account'),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              const Text('I Already Have an Account '),
              GestureDetector(
                onTap: () => context.go('/login'),
                child: Text('Log in',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: colors.teal)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'By clicking Continue, you agree to our Terms of Service and Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }
}
