part of 'glossary_bloc.dart';

@immutable
abstract class GlossaryEvent {}

class LoadGlossary extends GlossaryEvent {}

class SearchGlossary extends GlossaryEvent {
  final String query;

  SearchGlossary({required this.query});
}

class ResetSearch extends GlossaryEvent {} // Nuevo evento para resetear la búsqueda