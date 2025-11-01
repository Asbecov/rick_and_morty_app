import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract class CharacterListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharacterListInitial extends CharacterListState {}

class CharacterListLoading extends CharacterListState {
  final List<Character> previousCharacters;

  CharacterListLoading({this.previousCharacters = const []});

  @override
  List<Object?> get props => [previousCharacters];
}

class CharacterListLoaded extends CharacterListState {
  final List<Character> characters;
  final int currentPage;
  final bool hasReachedMax;

  CharacterListLoaded({
    required this.characters,
    this.currentPage = 1,
    this.hasReachedMax = false,
  });

  CharacterListLoaded copyWith({
    List<Character>? characters,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return CharacterListLoaded(
      characters: characters ?? this.characters,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [characters, currentPage, hasReachedMax];
}

class CharacterListError extends CharacterListState {
  final String message;
  final List<Character> previousCharacters;

  CharacterListError(this.message, {this.previousCharacters = const []});

  @override
  List<Object?> get props => [message, previousCharacters];
}
