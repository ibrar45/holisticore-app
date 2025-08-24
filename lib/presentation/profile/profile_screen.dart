import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/hcw_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: c.border),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 38,
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/150?img=12'),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.edit,
                            color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('James Wick',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                      SizedBox(height: 4),
                      Text('jameswich@gmail.com',
                          style: TextStyle(color: Color(0xFF94A3B8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Settings list (full-width rows with dividers)
          _RowTile(title: 'Reminder Sound', onTap: () {}),
          _RowTile(
            title: 'Reminder Mode',
            trailingText: 'As device settings',
            highlight: true,
            onTap: () {},
          ),
          _RowTile(title: 'History', onTap: () => context.push('/schedule')),
          _RowTile(
            title: 'Light or dark interface',
            trailingText: 'Light',
            highlight: true,
            onTap: () {},
          ),
          _RowTile(
            title: 'Intake goal',
            trailingText: '2000 ml',
            highlight: true,
            onTap: () {},
          ),
          _RowTile(title: 'FeedBack', onTap: () {}),
          const SizedBox(height: 8),
          _RowTile(
            title: 'Sign Out',
            danger: true,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Signed out (placeholder)')),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowTile extends StatelessWidget {
  const _RowTile({
    required this.title,
    this.trailingText,
    this.highlight = false,
    this.danger = false,
    this.onTap,
  });

  final String title;
  final String? trailingText;
  final bool highlight;
  final bool danger;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    final Color? trailColor = danger
        ? const Color(0xFFEF4444)
        : highlight
            ? const Color(0xFF2563EB)
            : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: c.border),
          bottom: BorderSide(color: c.border),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: danger ? const Color(0xFFEF4444) : null,
          ),
        ),
        trailing: trailingText != null
            ? Text(trailingText!,
                style:
                    TextStyle(color: trailColor, fontWeight: FontWeight.w700))
            : null,
        onTap: onTap,
      ),
    );
  }
}
