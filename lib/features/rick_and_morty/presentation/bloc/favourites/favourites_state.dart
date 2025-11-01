import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract class FavouritesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<Character> favourites;

  FavouritesLoaded(this.favourites);

  @override
  List<Object?> get props => [favourites];
}

class FavouritesError extends FavouritesState {
  final String message;

  FavouritesError(this.message);

  @override
  List<Object?> get props => [message];
}
