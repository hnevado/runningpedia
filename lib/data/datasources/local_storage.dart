import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<List<int>> getFavorites();
  Future<void> saveFavorites(List<int> favorites);
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences prefs;

  LocalStorageImpl({required this.prefs});

  @override
  Future<List<int>> getFavorites() async {
    final favorites = prefs.getStringList('favorites') ?? [];
    return favorites.map((id) => int.parse(id)).toList();
  }

  @override
  Future<void> saveFavorites(List<int> favorites) async {
    await prefs.setStringList('favorites', favorites.map((id) => id.toString()).toList());
  }
}