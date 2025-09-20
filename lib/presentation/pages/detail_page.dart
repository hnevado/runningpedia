import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/wine_term.dart';
import '../bloc/favorites_bloc.dart';

class DetailPage extends StatelessWidget {
  final WineTerm term;

  const DetailPage({Key? key, required this.term}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(term.termino),
        backgroundColor: const Color(0xFF800020),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (term.imagenUrl.isNotEmpty)
              Center(
                child: Image.asset(
                  'assets/${term.imagenUrl}',
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 50, color: Colors.grey),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              term.definicionLarga,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            if (term.ejemplo.isNotEmpty) ...[
              const Text(
                'Ejemplo:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                term.ejemplo,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
            const SizedBox(height: 16),
            if (term.sinonimos.isNotEmpty) ...[
              const Text(
                'Sinónimos:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: term.sinonimos
                    .map((sinonimo) => Chip(
                          label: Text(sinonimo),
                          backgroundColor: const Color(0xFFF5F5F5),
                        ))
                    .toList(),
              ),
            ],
            const SizedBox(height: 16),
            if (term.categoria.isNotEmpty) ...[
              const Text(
                'Categoría:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Chip(
                label: Text(
                  term.categoria,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color(0xFF800020),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final isFavorite = state.favorites.contains(term.id);
          return FloatingActionButton(
            backgroundColor: const Color(0xFFD4AF37),
            onPressed: () {
              context.read<FavoritesBloc>().add(ToggleFavorite(term.id));
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}