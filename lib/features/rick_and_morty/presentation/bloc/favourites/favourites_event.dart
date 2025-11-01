import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract class FavouritesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavourites extends FavouritesEvent {}

class AddToFavourites extends FavouritesEvent {
  final Character character;

  AddToFavourites(this.character);

  @override
  List<Object?> get props => [character];
}

class RemoveFromFavourites extends FavouritesEvent {
  final Character character;

  RemoveFromFavourites(this.character);

  @override
  List<Object?> get props => [character];
}
