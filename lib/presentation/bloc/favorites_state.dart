part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {
  final List<int> favorites;

  const FavoritesState({required this.favorites});
}

class FavoritesInitial extends FavoritesState {
  FavoritesInitial() : super(favorites: []);
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required List<int> favorites}) : super(favorites: favorites);
}