import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/hcw_colors.dart';
import 'class_detail_args.dart';
import 'widgets/upcoming_class_tile.dart';

class ClassDetailScreen extends StatelessWidget {
  const ClassDetailScreen({super.key, required this.args});
  final ClassDetailArgs args;

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.pop()),
        title: Text(args.name,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          // HERO IMAGE
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                Positioned.fill(
                  child: args.heroImageUrl.isEmpty
                      ? Container(color: const Color(0xFFE5E7EB))
                      : Image.network(args.heroImageUrl, fit: BoxFit.cover),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {}),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Title & meta
              Text(args.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text('${args.category}  •  ${args.distance}',
                  style: const TextStyle(color: Color(0xFF64748B))),

              const SizedBox(height: 16),
              const _SectionTitle('About'),
              const SizedBox(height: 6),
              const Text(
                'Perfect flat for 4 people. Peaceful and good location, close to bus stops and many restaurants.',
              ),

              const SizedBox(height: 16),
              const _SectionTitle('Reviews'),
              const SizedBox(height: 8),
              Row(
                children: [
                  const CircleAvatar(
                      radius: 16,
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/64')),
                  const SizedBox(width: 10),
                  const Text('James',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  const Icon(Icons.star, size: 18, color: Color(0xFFFFB300)),
                  Text(args.rating.toStringAsFixed(1)),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Perfect flat for 4 people. Peaceful and good location, close to bus stops and many restaurants.',
              ),

              const SizedBox(height: 16),
            ]),
          ),

          // MAP PREVIEW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network('https://picsum.photos/seed/map/1200/800',
                    fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Address & phone
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: const [
              _IconText(
                  icon: Icons.location_on_outlined,
                  text: 'Any City, any street, 12346'),
              SizedBox(height: 6),
              _IconText(icon: Icons.call_outlined, text: '+92 321 1234 567'),
            ]),
          ),

          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _SectionTitle('Upcoming Classes'),
          ),
          const SizedBox(height: 8),

          // Upcoming cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: const [
              UpcomingClassTile(
                  time: '9:00 am',
                  title: 'Strength',
                  subtitle: 'Sector Y 28.1 mi'),
              SizedBox(height: 10),
              UpcomingClassTile(
                  time: '11:30 am',
                  title: 'Strength',
                  subtitle: 'Sector Y 28.1 mi'),
            ]),
          ),
        ],
      ),

      // Bottom buttons
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: null, // grey disabled like mock
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE5E7EB),
                  foregroundColor: const Color(0xFF6B7280)),
              child: const Text('View Details'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.push('/schedule'),
              child: const Text('View Schedule'),
            ),
          ),
        ]),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800));
  }
}

class _IconText extends StatelessWidget {
  const _IconText({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: c.teal),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }
}
