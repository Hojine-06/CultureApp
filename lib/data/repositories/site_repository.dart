import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/site_model.dart';

class SiteRepository {
  Future<List<Site>> loadSites() async {
    final String response = await rootBundle.loadString('assets/data/sites.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Site.fromJson(json)).toList();
  }
}
