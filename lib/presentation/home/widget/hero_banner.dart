import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Replace with your asset
            Positioned.fill(
                child: Image.network(
                    'https://picsum.photos/seed/fitness/1200/800',
                    fit: BoxFit.cover)),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.black.withOpacity(.45), Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('DAILY\nWORKOUT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          height: 1.05)),
                  SizedBox(height: 6),
                  Text('for beginner', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              left: 16,
              bottom: 14,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.location_on_outlined),
                label: const Text('Deals Near You →'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
