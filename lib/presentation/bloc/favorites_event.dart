part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final int termId;

  ToggleFavorite(this.termId);
}