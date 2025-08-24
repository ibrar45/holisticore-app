import 'package:flutter/material.dart';

class ChipPill extends StatelessWidget {
  const ChipPill({
    super.key,
    required this.text,
    this.active = false,
    this.muted = false,
    this.onTap,
  });

  final String text;
  final bool active;
  final bool muted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color bg = active
        ? const Color(0xFF2563EB) // blue active
        : muted
            ? const Color(0xFFF1F5F9)
            : const Color(0xFFF8FAFC);
    final Color fg = active ? Colors.white : const Color(0xFF111827);

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
