import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/datasources/local_storage.dart';
import 'package:meta/meta.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final LocalStorage localStorage;

  FavoritesBloc({required this.localStorage}) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) async {
    final favorites = await localStorage.getFavorites();
    emit(FavoritesLoaded(favorites: favorites));
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<FavoritesState> emit) async {
    final List<int> updatedFavorites = List.from(state.favorites);
    if (updatedFavorites.contains(event.termId)) {
      updatedFavorites.remove(event.termId);
    } else {
      updatedFavorites.add(event.termId);
    }
    await localStorage.saveFavorites(updatedFavorites);
    emit(FavoritesLoaded(favorites: updatedFavorites));
  }
}