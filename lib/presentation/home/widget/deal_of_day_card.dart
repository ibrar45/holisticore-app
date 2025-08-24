import 'dart:async';
import 'package:flutter/material.dart';

class DealOfDayCard extends StatefulWidget {
  const DealOfDayCard({super.key});

  @override
  State<DealOfDayCard> createState() => _DealOfDayCardState();
}

class _DealOfDayCardState extends State<DealOfDayCard> {
  late Duration left;
  Timer? _t;

  @override
  void initState() {
    super.initState();
    // demo countdown ~ 22h 55m 20s
    left = const Duration(hours: 22, minutes: 55, seconds: 20);
    _t = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => left = left - const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.inHours)}h ${two(d.inMinutes % 60)}m ${two(d.inSeconds % 60)}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF22C55E), // green
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Icon(Icons.local_fire_department, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Deal of the Day',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text('⏱ ${_fmt(left)} remaining',
                  style: const TextStyle(color: Colors.white)),
            ]),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white.withOpacity(.15),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {},
            icon: const Icon(Icons.chevron_right, color: Colors.white),
            label:
                const Text('View all', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
