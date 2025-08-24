import 'package:flutter/material.dart';
import '../../core/hcw_colors.dart';

class ScheduleClassTile extends StatelessWidget {
  const ScheduleClassTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.onDetails,
  });

  final String title;
  final String subtitle;
  final String time;
  final VoidCallback? onDetails;

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3FAF2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.border),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEFF5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.sports_gymnastics, color: Colors.pink),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Color(0xFF64748B))),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onDetails,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999)),
            ),
            child: const Text('DETAILS'),
          ),
        ],
      ),
    );
  }
}
