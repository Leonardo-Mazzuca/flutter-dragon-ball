import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dragon_ball_app/models/character.dart';
import 'package:dragon_ball_app/screens/detail_screen.dart';
import 'package:dragon_ball_app/services/api_service.dart';
import 'package:dragon_ball_app/widgets/character_carousel_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Character>> _futureCharacters;
  @override
  void initState() {
    super.initState();
    _futureCharacters = ApiService.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DRAGON BALL", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 228, 172, 16),
      ),
      body: FutureBuilder<List<Character>>(
        future: _futureCharacters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final chars = snapshot.data ?? [];
          if (chars.isEmpty) {
            return const Center(child: Text('Nenhum personagem encontrado'));
          }
          return Column(
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: chars.length,
                  itemBuilder: (context, index, realIdx) {
                    final ch = chars[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(character: ch),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: CharacterCarouselItem(character: ch),
                      ),
                    );
                  },
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
    );
  }
}
