import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bmi_result_args.dart';

class BMIResultScreen extends StatelessWidget {
  const BMIResultScreen({super.key, required this.args});
  final BMIResultArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.pop()),
        title: const Text('Your Result',
            style: TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          children: [
            const SizedBox(height: 6),
            Text(
              args.bmi.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 96,
                height: 0.9,
                fontWeight: FontWeight.w800,
                color: args.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(args.label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              args.message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF64748B)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => context.go('/bmi'),
                child: const Text('Re-Calculate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
