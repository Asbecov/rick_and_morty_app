import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/usecases/load_characters_use_case.dart';
import 'character_list_event.dart';
import 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final LoadCharactersUseCase loadCharactersUseCase;

  CharacterListBloc({required this.loadCharactersUseCase})
    : super(CharacterListInitial()) {
    on<LoadCharactersPage>(_onLoadCharactersPage);
  }

  Future<void> _onLoadCharactersPage(
    LoadCharactersPage event,
    Emitter<CharacterListState> emit,
  ) async {
    final currentState = state;

    if (event.isInitialLoad || currentState is! CharacterListLoaded) {
      emit(CharacterListLoading());

      final result = await loadCharactersUseCase.call(
        LoadCharactersParams(event.page),
      );

      result.fold(
        (failure) => emit(CharacterListError(failure.toString())),
        (characters) => emit(
          CharacterListLoaded(
            characters: characters,
            currentPage: event.page,
            hasReachedMax: characters.isEmpty,
          ),
        ),
      );
    } else {
      final currentLoaded = currentState;

      if (currentLoaded.hasReachedMax) return;

      emit(CharacterListLoading(previousCharacters: currentLoaded.characters));

      final result = await loadCharactersUseCase.call(
        LoadCharactersParams(event.page),
      );

      result.fold(
        (failure) => emit(
          CharacterListError(
            failure.toString(),
            previousCharacters: currentLoaded.characters,
          ),
        ),
        (newCharacters) {
          final List<Character> allCharacters = [
            ...currentLoaded.characters,
            ...newCharacters,
          ];

          emit(
            CharacterListLoaded(
              characters: allCharacters,
              currentPage: event.page,
              hasReachedMax: newCharacters.isEmpty,
            ),
          );
        },
      );
    }
  }
}
