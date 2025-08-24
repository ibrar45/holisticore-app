import 'package:flutter/material.dart';
import '../../core/hcw_colors.dart';

class HCWSearchField extends StatelessWidget {
  const HCWSearchField({
    super.key,
    required this.controller,
    this.hint = 'Search…',
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.border),
        boxShadow: const [
          BoxShadow(
              color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
              ),
            ),
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.mic_none_rounded)),
        ],
      ),
    );
  }
}
