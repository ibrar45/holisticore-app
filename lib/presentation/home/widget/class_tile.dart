import 'package:flutter/material.dart';
import '../../Core/hcw_colors.dart';

class ClassTile extends StatelessWidget {
  final String title, subtitle, ratingText;
  final IconData icon;
  final Color iconBg;
  const ClassTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ratingText,
    required this.icon,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.border),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: Colors.pink),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(color: Color(0xFF64748B))),
            ]),
          ),
          const Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
          const SizedBox(width: 4),
          Text(ratingText, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
