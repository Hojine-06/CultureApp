import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/arts_model.dart';

class ArtsRepository {
  Future<List<Art>> loadArts() async {
    final String response = await rootBundle.loadString('assets/data/arts.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Art.fromJson(json)).toList();
  }
}
