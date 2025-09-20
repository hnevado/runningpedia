import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/models/wine_term.dart';
import '../../data/repositories/glossary_repository.dart';
import '../widgets/fuzzy_search.dart';

part 'glossary_event.dart';
part 'glossary_state.dart';

class GlossaryBloc extends Bloc<GlossaryEvent, GlossaryState> {
  final GlossaryRepository glossaryRepository;
  List<WineTerm> _allTerms = [];

  GlossaryBloc({required this.glossaryRepository}) : super(GlossaryInitial()) {
    on<LoadGlossary>(_onLoadGlossary);
    on<SearchGlossary>(_onSearchGlossary);
    on<ResetSearch>(_onResetSearch);
  }

  Future<void> _onLoadGlossary(LoadGlossary event, Emitter<GlossaryState> emit) async {
    emit(GlossaryLoading());
    try {
      _allTerms = await glossaryRepository.getGlossary();
      emit(GlossaryLoaded(terms: _allTerms));
    } catch (e) {
      emit(GlossaryError(message: e.toString()));
    }
  }

  void _onSearchGlossary(SearchGlossary event, Emitter<GlossaryState> emit) {
    if (event.query.isEmpty) {
      // Búsqueda vacía = mostrar todos
      emit(GlossaryLoaded(terms: _allTerms));
    } else if (_allTerms.isNotEmpty) {
      // Realizar búsqueda con los términos disponibles
      final results = FuzzySearch.search(event.query, _allTerms);
      emit(GlossaryLoaded(
        terms: results, 
        searchQuery: event.query,
        isSearching: true,
      ));
    }
  }

  void _onResetSearch(ResetSearch event, Emitter<GlossaryState> emit) {
    emit(GlossaryLoaded(terms: _allTerms));
  }
}