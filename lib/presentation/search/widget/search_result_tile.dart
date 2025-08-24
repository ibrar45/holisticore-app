import 'package:flutter/material.dart';
import '../../core/hcw_colors.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ratingText,
    this.onTap, // 👈 NEW
  });

  final String title;
  final String subtitle;
  final String ratingText;
  final VoidCallback? onTap; // 👈 NEW

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    return InkWell(
      // 👈 tap wrapper
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3FAF2),
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
                color: const Color(0xFFFFEFF5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.sports_gymnastics, color: Colors.pink),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(color: Color(0xFF64748B))),
                ],
              ),
            ),
            const Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
            const SizedBox(width: 4),
            Text(ratingText,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
