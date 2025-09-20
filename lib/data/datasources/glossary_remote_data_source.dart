import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/wine_term.dart';

class GlossaryRemoteDataSource {
  Future<List<WineTerm>> fetchGlossary() async {
    try {
      // Cargar el JSON desde assets
      final String data = await rootBundle.loadString('assets/definiciones.json');
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => WineTerm.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load glossary from assets: $e');
    }
  }
}