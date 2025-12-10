import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  static const _kFavoritesKey = 'favorites';
  List<Favorite> _favorites = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kFavoritesKey) ?? [];
    _favorites = list.map((s) => Favorite.decode(s)).toList();
    setState(() => _loading = false);
  }

  Future<void> _removeFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    _favorites.removeWhere((f) => f.id == id);
    await prefs.setStringList(
        _kFavoritesKey, _favorites.map((f) => f.encode()).toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _favorites.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite_border, size: 72, color: Colors.pinkAccent),
                        const SizedBox(height: 12),
                        const Text(
                          'Vous n\'avez pas encore de favoris',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Ajoutez des questions ou événements en favoris pour les retrouver ici.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/quiz'),
                              child: const Text('Explorer les quiz'),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () => Navigator.pushNamed(context, '/events'),
                              child: const Text('Voir événements'),
                              style: OutlinedButton.styleFrom(foregroundColor: Colors.pinkAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: _favorites.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    final f = _favorites[i];
                    return ListTile(
                      title: Text(f.title),
                      subtitle: Text(f.type),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _confirmRemove(f),
                      ),
                      onTap: () {
                        // Optionally navigate to detail based on type
                      },
                    );
                  },
                ),
      floatingActionButton: _favorites.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () async {
                // Clear all favorites
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove(_kFavoritesKey);
                await _loadFavorites();
              },
              icon: const Icon(Icons.clear_all),
              label: const Text('Supprimer tout'),
            )
          : null,
    );
  }

  void _confirmRemove(Favorite f) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer le favori ?'),
        content: Text('Supprimer "${f.title}" des favoris ?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Annuler')),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await _removeFavorite(f.id);
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
