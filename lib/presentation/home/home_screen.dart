import 'package:flutter/material.dart';
import '../Core/hcw_colors.dart';
import 'widget/class_tile.dart';
import 'widget/deal_of_day_card.dart';
import 'widget/hero_banner.dart';
import 'widget/product_card.dart';
import 'widget/section_header.dart';
import 'widget/video_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        _SearchBar(),
        const SizedBox(height: 12),
        const HeroBanner(), // big image w/ copy + CTA tag
        const SizedBox(height: 16),
        const DealOfDayCard(),
        const SizedBox(height: 16),
        const SectionHeader(title: 'Classes', actionText: 'View all'),
        const SizedBox(height: 8),
        // classes list
        ...List.generate(3, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ClassTile(
              title: const ['Aimfit', 'Strength', 'Gym'][i],
              subtitle: 'Sector Y 28.1 mi',
              ratingText: '16.5 K',
              iconBg: const Color(0xFFFFEFF5),
              icon: Icons.sports_gymnastics,
            ),
          );
        }),
        const SizedBox(height: 12),
        const VideoCard(
          title: 'Workout',
          subtitle: 'Lorem ipsum dolor sit',
          buttonText: 'View all',
        ),
        const SizedBox(height: 12),
        const SectionHeader(title: 'Our Products'),
        const SizedBox(height: 8),
        // products grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220, // ~card width; more cols on wider screens
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75, // tune to match your ProductCard height
          ),
          itemCount: _demoProducts.length,
          itemBuilder: (_, i) => ProductCard(item: _demoProducts[i]),
        )
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: c.border)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 48,
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 8),
          const Expanded(
              child: Text('Search any Product...',
                  style: TextStyle(color: Color(0xFF94A3B8)))),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.mic_none_rounded)),
        ],
      ),
    );
  }
}

class ProductItem {
  final String title, imageUrl;
  final double price;
  final double rating;
  final int ratingCount;
  ProductItem(
      this.title, this.imageUrl, this.price, this.rating, this.ratingCount);
}

final _demoProducts = <ProductItem>[
  ProductItem(
      'Collagen', 'https://picsum.photos/seed/col/400/300', 5.00, 4.5, 6890),
  ProductItem(
      'Vitamin D', 'https://picsum.photos/seed/vitd/400/300', 5.00, 4.6, 6890),
  ProductItem(
      'Vitamin C', 'https://picsum.photos/seed/vitc/400/300', 5.00, 4.4, 6890),
  ProductItem(
      'Hair, Skin', 'https://picsum.photos/seed/hair/400/300', 5.00, 4.2, 6890),
];
