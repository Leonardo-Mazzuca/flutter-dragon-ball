import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_ball_app/models/transformation_detail.dart';
import 'package:flutter/material.dart';

class TransformationDetailScreen extends StatelessWidget {
  @override
  final TransformationDetail transformation;

  const TransformationDetailScreen({super.key, required this.transformation});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          transformation.name,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 228, 172, 16),
      ),
      body: (Center(
        child: Column(
          children: [
            SizedBox(
              height: 320,
              child: Hero(
                tag: 'character_${transformation.id}',
                child: CachedNetworkImage(
                  imageUrl: transformation.image.isNotEmpty
                      ? transformation.image
                      : 'https://placehold.co/600x400?text=No%20Image',
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const SizedBox(
                    height: 320,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(
                    height: 320,
                    child: Center(child: Icon(Icons.error, size: 48)),
                  ),
                ),
              ),
            ),
            // Nome e ID
            Text(
              transformation.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'KI: ${transformation.ki}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )),
    );
  }
}
