import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holistic_core_wellness_mobileapp/presentation/Auth/auth_scaffold.dart';
import 'package:holistic_core_wellness_mobileapp/presentation/Auth/widgets/hcw_text_field.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Profile Setup',
      subtitle: '',
      children: const [
        SizedBox(height: 8),
        HCWTextField(
            hint: 'User Age',
            icon: Icons.calendar_today_outlined,
            keyboardType: TextInputType.number),
        SizedBox(height: 12),
        HCWTextField(hint: 'Gender', icon: Icons.female_outlined),
        SizedBox(height: 12),
        HCWTextField(
            hint: 'Weight',
            icon: Icons.monitor_weight_outlined,
            keyboardType: TextInputType.number),
      ],
      bottom: SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: () => GoRouter.of(context).go('/'),
          child: const Text('Setup Account'),
        ),
      ),
    );
  }
}
