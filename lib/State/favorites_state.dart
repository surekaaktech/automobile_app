import 'package:flutter/material.dart';

class FavoritesState {
  static final List<Map<String, dynamic>> favoritedCompanies = [];

  static void toggleFavorite(Map<String, dynamic> company) {
    final index = favoritedCompanies.indexWhere((c) => c["id"] == company["id"]);
    if (index >= 0) {
      favoritedCompanies.removeAt(index);
    } else {
      favoritedCompanies.add(company);
    }
  }

  static bool isFavorite(int id) {
    return favoritedCompanies.any((c) => c["id"] == id);
  }
}
