import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/glossary_bloc.dart';
import '../widgets/search_bar.dart';
import '../widgets/term_list_item.dart';
import 'detail_page.dart';
import 'favorites_page.dart'; // Añadir esta importación

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Glosario del running'),
      surfaceTintColor: Colors.white,
        backgroundColor: const Color(0xFF800020),
        foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesPage()),
          ),
        ),
      ],
    ),
    body: Column(
      children: [
        const WineSearchBar(),
        Expanded(
          child: BlocBuilder<GlossaryBloc, GlossaryState>(
            builder: (context, state) {
              if (state is GlossaryInitial) {
                context.read<GlossaryBloc>().add(LoadGlossary());
                return const Center(child: CircularProgressIndicator());
              } else if (state is GlossaryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GlossaryError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is GlossaryLoaded) {
                final terms = state.terms;
                
                if (terms.isEmpty && state.isSearching) {
                  return const Center(
                    child: Text('No se encontraron resultados'),
                  );
                }
                
                return ListView.builder(
                  itemCount: terms.length,
                  itemBuilder: (context, index) {
                    final term = terms[index];
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
              return const SizedBox();
            },
          ),
        ),
      ],
    ),
  );
}}