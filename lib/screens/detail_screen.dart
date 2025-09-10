import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dragon_ball_app/models/character.dart';
import 'package:dragon_ball_app/screens/transformation_detail_screen.dart';
import 'package:dragon_ball_app/services/api_service.dart';
import 'package:dragon_ball_app/widgets/transformation_caroulsel_item.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Character character;
  const DetailScreen({super.key, required this.character});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final character = widget.character;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          character.name,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 228, 172, 16),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 320,
                child: Hero(
                  tag: 'character_${character.id}',
                  child: CachedNetworkImage(
                    imageUrl: character.image.isNotEmpty
                        ? character.image
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
              const SizedBox(height: 16),
              // Nome e ID
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'ID: ${character.id}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 18),
              FutureBuilder(
                future: ApiService.fetchCharacterById(character.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  final characterDetail = snapshot.data;
                  if (characterDetail == null) {
                    return const Center(
                      child: Text('Sem informações conhecidas'),
                    );
                  } else {
                    return Column(
                      children: [Text(characterDetail.description)],
                    );
                  }
                },
              ),

              const SizedBox(height: 16),

              FutureBuilder(
                future: ApiService.fetchTransformationById(character.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  // snapshot.data é uma lista com os resultados
                  final transformationData = snapshot.data ?? [];
                  return Column(
                    children: [
                      SizedBox(
                        height: 500,
                        child: CarouselSlider(
                          items: transformationData
                              .map(
                                (td) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            TransformationDetailScreen(transformation: td),
                                      ),
                                    );
                                  },
                                  child: TransformationCaroulselItem(
                                    detail: td,
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            enableInfiniteScroll: true,
                            viewportFraction: 0.68,
                            height: double.infinity,
                            //enlargeStrategy: CenterPageEnlargeStrategy.height,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
