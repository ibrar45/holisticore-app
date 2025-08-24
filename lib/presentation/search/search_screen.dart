import 'package:flutter/material.dart';
import '../core/hcw_colors.dart';
import 'widget/search_field.dart';
import 'widget/chip_pill.dart';
import 'widget/search_result_tile.dart';
import 'package:go_router/go_router.dart';
import '../classes/class_detail_args.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _query = TextEditingController();

  // simple demo data
  final List<_Place> _all = const [
    _Place(
        name: 'Aimfit',
        distance: 'Sector Y 28.1 mi',
        ratingCount: '16.5 K',
        category: 'concerts'),
    _Place(
        name: 'Strength',
        distance: 'Sector Y 28.1 mi',
        ratingCount: '12.1 K',
        category: 'gym'),
    _Place(
        name: 'Gym',
        distance: 'Sector Y 28.1 mi',
        ratingCount: '9.3 K',
        category: 'distance'),
  ];

  bool chipConcerts = true;
  bool chipDistance = false;

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();

    // filter demo list
    final q = _query.text.trim().toLowerCase();
    final results = _all.where((p) {
      final okQuery = q.isEmpty || p.name.toLowerCase().contains(q);
      final okConcerts = chipConcerts ? p.category == 'concerts' : true;
      final okDistance = chipDistance ? p.category == 'distance' : true;
      return okQuery && okConcerts && okDistance;
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final pad = EdgeInsets.fromLTRB(16, 12, 16, 16);
        final maxWidth = 700.0;

        final content = ListView(
          padding: pad,
          children: [
            HCWSearchField(
              controller: _query,
              hint: 'Search any Product..',
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),

            // chips row
            Row(
              children: [
                ChipPill(text: 'SORT BY', muted: true, onTap: () {}),
                const SizedBox(width: 8),
                ChipPill(
                  text: 'CONCERTS',
                  active: chipConcerts,
                  onTap: () => setState(() => chipConcerts = !chipConcerts),
                ),
                const SizedBox(width: 8),
                ChipPill(
                  text: 'DISTANCE',
                  active: chipDistance,
                  onTap: () => setState(() => chipDistance = !chipDistance),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune, color: Color(0xFF2563EB)),
                  tooltip: 'Filters',
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Text('Search',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),

            if (results.isEmpty)
              Container(
                height: 140,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: c.border),
                ),
                child: const Text('No results'),
              )
            else
              ...results.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SearchResultTile(
                      title: p.name,
                      subtitle: p.distance,
                      ratingText: p.ratingCount,
                      onTap: () {
                        context.push(
                          '/class/${p.name.toLowerCase()}', // route slug
                          extra: ClassDetailArgs(
                            // pass data to the screen
                            name: p.name,
                            category: 'Gym Classes | Nutrition | Other',
                            distance: p.distance,
                            rating: 4.8,
                            heroImageUrl:
                                'https://picsum.photos/seed/aimfit/1200/800',
                          ),
                        );
                      },
                    ),
                  )),
          ],
        );

        // center on wide screens
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: content,
          ),
        );
      },
    );
  }
}

class _Place {
  final String name, distance, ratingCount, category;
  const _Place({
    required this.name,
    required this.distance,
    required this.ratingCount,
    required this.category,
  });
}
