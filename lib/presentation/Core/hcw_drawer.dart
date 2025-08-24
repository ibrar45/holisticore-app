import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/hcw_colors.dart';

class HCWDrawer extends StatelessWidget {
  const HCWDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();

    return Drawer(
      width: 320,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        NetworkImage('https://i.pravatar.cc/150?img=12'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('James Wick',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16)),
                        SizedBox(height: 2),
                        Text('jameswich@gmail.com',
                            style: TextStyle(
                                color: Color(0xFF64748B), fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Items
            _Tile(
              icon: Icons.home_outlined,
              text: 'Home',
              onTap: () => _go(context, '/'),
            ),
            _Tile(
              icon: Icons.search,
              text: 'Search',
              onTap: () => _go(context, '/search'),
            ),
            _Tile(
              icon: Icons.calendar_month_outlined,
              text: 'Schedule',
              onTap: () => _go(context, '/schedule'),
            ),
            _Tile(
              icon: Icons.monitor_weight_outlined,
              text: 'BMI Calculator',
              onTap: () => _go(context, '/bmi'),
            ),
            _Tile(
              icon: Icons.person_outline,
              text: 'Profile',
              onTap: () => _go(context, '/profile'),
            ),
            _Tile(
              icon: Icons.local_offer_outlined,
              text: 'Deals',
              onTap: () => _go(context, '/deals'),
            ),

            const Spacer(),
            const Divider(height: 1),
            _Tile(
              icon: Icons.logout,
              text: 'Sign Out',
              danger: true,
              onTap: () {
                Navigator.of(context).pop(); // close drawer
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed out (placeholder)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _go(BuildContext context, String route) {
    Navigator.of(context).pop(); // close the drawer first
    context.go(route);
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.text,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? const Color(0xFFEF4444) : null;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}
