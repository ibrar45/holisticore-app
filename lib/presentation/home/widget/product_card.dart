import 'package:flutter/material.dart';
import '../../Core/hcw_colors.dart';
import '../home_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductItem item;
  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth; // width of the grid cell
        final scale = (w / 200).clamp(0.85, 1.35); // responsive scale factor

        // Tune image aspect for different widths so cards look balanced
        final imgAspect =
            w < 150 ? 1.05 : (w < 200 ? 1.15 : (w < 260 ? 1.25 : 1.35));

        final radius = BorderRadius.circular(16 * scale);
        final pad = 10.0 * scale;
        final starSize = 16.0 * scale;

        final titleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize:
                  (Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14) *
                      (0.95 + (scale - 1) * 0.8),
            );

        final priceStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize:
                  (Theme.of(context).textTheme.titleSmall?.fontSize ?? 16) *
                      (1.0 + (scale - 1) * 0.9),
            );

        final metaStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize:
                  (Theme.of(context).textTheme.bodySmall?.fontSize ?? 12) *
                      (0.95 + (scale - 1) * 0.8),
            );

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius,
            border: Border.all(color: c.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: radius.topLeft),
                child: AspectRatio(
                  aspectRatio: imgAspect,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    // Better UX on slow networks:
                    loadingBuilder: (ctx, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2));
                    },
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFF3F3F3),
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                    // Hint to engine for memory/perf (rounded to int)
                    cacheWidth:
                        (w * MediaQuery.of(context).devicePixelRatio).toInt(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(pad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle,
                    ),
                    SizedBox(height: 4 * scale),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star,
                            color: const Color(0xFFFFB300), size: starSize),
                        SizedBox(width: 4 * scale),
                        Flexible(
                          child: Text(
                            '${item.rating.toStringAsFixed(1)}  •  ${item.ratingCount}',
                            overflow: TextOverflow.ellipsis,
                            style: metaStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6 * scale),
                    Text('\$${item.price.toStringAsFixed(2)}',
                        style: priceStyle),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
