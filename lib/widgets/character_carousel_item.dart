import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterCarouselItem extends StatelessWidget {
  final Character character;
  const CharacterCarouselItem({super.key, required this.character});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ), // margem do card
      width: double.infinity, // ocupa toda largura disponível no carrossel
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16), // padding interno menor
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: 'character_${character.id}',
                  child: CachedNetworkImage(
                    imageUrl: character.image.isNotEmpty
                        ? character.image
                        : 'https://placehold.co/600x400?text=No%20Image',
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                character.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
