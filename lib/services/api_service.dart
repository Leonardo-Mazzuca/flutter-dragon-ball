import 'dart:convert';

import 'package:dragon_ball_app/models/character.dart';
import 'package:dragon_ball_app/models/character_detail.dart';
import 'package:dragon_ball_app/models/transformation_detail.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseURL =
      'https://dragon-ball-api-055bab372b94.herokuapp.com/api';
  static Future<List<Character>> fetchCharacters() async {
    final uri = Uri.parse('$_baseURL/characters');
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Erro ao chamar API: ${resp.statusCode}');
    }
    List<dynamic> items = json.decode(resp.body);
    return items
        .map((e) => Character.fromJson(e))
        .whereType<Character>()
        .toList();
  }

  static Future<CharacterDetail> fetchCharacterById(int id) async {
    final url = Uri.parse("$_baseURL/characters/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CharacterDetail.fromJson(data);
    } else {
      throw Exception("Erro ao buscar personagem: ${response.statusCode}");
    }
  }

  static Future<List<TransformationDetail>> fetchTransformationById(int id) async {
    final url = Uri.parse("$_baseURL/characters/$id/transformations");
    final resp = await http.get(url);
    if (resp.statusCode != 200) {
      throw Exception('Erro ao chamar API: ${resp.statusCode}');
    }
    List<dynamic> items = json.decode(resp.body);
    return items.map((e) => TransformationDetail.fromJson(e))
        .whereType<TransformationDetail>()
        .toList();
  }
}
