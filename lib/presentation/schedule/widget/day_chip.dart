import 'package:flutter/material.dart';

class DayChip extends StatelessWidget {
  const DayChip({
    super.key,
    required this.dayLabel,
    required this.dateNumber,
    this.selected = false,
    this.onTap,
  });

  final String dayLabel;
  final int dateNumber;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color bg = selected ? const Color(0xFF2563EB) : Colors.white;
    final Color fg = selected ? Colors.white : const Color(0xFF111827);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF2563EB) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dayLabel,
                style: TextStyle(
                    color: fg.withOpacity(.85), fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                dateNumber.toString(),
                style: TextStyle(color: fg, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
