part of 'glossary_bloc.dart';

@immutable
abstract class GlossaryState {}

class GlossaryInitial extends GlossaryState {}

class GlossaryLoading extends GlossaryState {}

class GlossaryLoaded extends GlossaryState {
  final List<WineTerm> terms;
  final String? searchQuery;
  final bool isSearching;

  GlossaryLoaded({
    required this.terms,
    this.searchQuery,
    this.isSearching = false,
  });
}

class GlossaryError extends GlossaryState {
  final String message;

  GlossaryError({required this.message});
}