import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/wine_term.dart';
import '../bloc/glossary_bloc.dart';
import '../bloc/favorites_bloc.dart';
import '../widgets/term_list_item.dart';
import 'detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos Favoritos'),
        backgroundColor: const Color(0xFF800020),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, favoritesState) {
          return BlocBuilder<GlossaryBloc, GlossaryState>(
            builder: (context, glossaryState) {
              if (glossaryState is GlossaryLoaded) {
                final favoriteTerms = glossaryState.terms
                    .where((term) => favoritesState.favorites.contains(term.id))
                    .toList();
                
                if (favoriteTerms.isEmpty) {
                  return const Center(
                    child: Text('No tienes términos favoritos aún.'),
                  );
                }
                
                return ListView.builder(
                  itemCount: favoriteTerms.length,
                  itemBuilder: (context, index) {
                    final term = favoriteTerms[index];
                    return TermListItem(
                      term: term,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(term: term),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}