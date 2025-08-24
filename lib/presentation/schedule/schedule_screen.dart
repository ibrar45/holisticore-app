import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/hcw_colors.dart';
import 'widget/day_chip.dart';
import 'widget/schedule_class_tile.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime _weekStart; // Monday of current week
  int _selected = 0;

  // demo data
  final List<_ClassItem> _items = const [
    _ClassItem('Strength', 'Sector Y 28.1 mi', '9:00 am'),
    _ClassItem('Strength', 'Sector Y 28.1 mi', '11:30 am'),
    _ClassItem('Gym', 'Sector Y 28.1 mi', '7:30 am'),
  ];

  @override
  void initState() {
    super.initState();
    _weekStart = _mondayOf(DateTime.now());
    _selected = DateTime.now().weekday - 1; // 0..6
  }

  DateTime _mondayOf(DateTime d) => d.subtract(Duration(days: d.weekday - 1));

  void _goPrevWeek() =>
      setState(() => _weekStart = _weekStart.subtract(const Duration(days: 7)));
  void _goNextWeek() =>
      setState(() => _weekStart = _weekStart.add(const Duration(days: 7)));

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    final selectedDate = _weekStart.add(Duration(days: _selected));
    final monthLabel = "${_monthName(selectedDate.month)} ${selectedDate.day}";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
        title: const Text('Schedule',
            style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(monthLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          // Week strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: _goPrevWeek,
                      icon: const Icon(Icons.chevron_left,
                          color: Color(0xFF2563EB)),
                    ),
                    const Spacer(),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: _goNextWeek,
                      icon: const Icon(Icons.chevron_right,
                          color: Color(0xFF2563EB)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(7, (i) {
                    final d = _weekStart.add(Duration(days: i));
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: DayChip(
                          dayLabel: _weekdayShort(d.weekday),
                          dateNumber: d.day,
                          selected: _selected == i,
                          onTap: () => setState(() => _selected = i),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Schedule list
          ..._items.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ScheduleClassTile(
                  title: e.title,
                  subtitle: e.subtitle,
                  time: e.time,
                  onDetails: () {}, // hook later
                ),
              )),
        ],
      ),
    );
  }

  String _weekdayShort(int weekday) {
    const names = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    return names[weekday % 7]; // since DateTime uses 1..7 (Mon..Sun)
  }

  String _monthName(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[m - 1];
  }
}

class _ClassItem {
  final String title, subtitle, time;
  const _ClassItem(this.title, this.subtitle, this.time);
}
