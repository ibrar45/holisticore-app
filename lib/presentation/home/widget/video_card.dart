import 'package:flutter/material.dart';
import 'section_header.dart';

class VideoCard extends StatelessWidget {
  final String title, subtitle, buttonText;
  const VideoCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.network(
                        'https://picsum.photos/seed/workout/1200/800',
                        fit: BoxFit.cover)),
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.play_arrow, size: 36),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(color: Color(0xFF64748B))),
              ],
            )),
            TextButton(onPressed: () {}, child: Text(buttonText)),
          ],
        ),
      ],
    );
  }
}
