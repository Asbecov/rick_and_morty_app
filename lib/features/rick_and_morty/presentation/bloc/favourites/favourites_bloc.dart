import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/usecases/add_favourite_use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/usecases/load_favourites_use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/usecases/remove_favourite_use_case.dart';
import 'favourites_event.dart';
import 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final LoadFavouritesUseCase loadFavouritesUseCase;
  final AddFavouriteUseCase addFavouriteUseCase;
  final RemoveFavouriteUseCase removeFavouriteUseCase;

  FavouritesBloc({
    required this.loadFavouritesUseCase,
    required this.addFavouriteUseCase,
    required this.removeFavouriteUseCase,
  }) : super(FavouritesInitial()) {
    on<LoadFavourites>(_onLoadFavourites);
    on<AddToFavourites>(_onAddToFavourites);
    on<RemoveFromFavourites>(_onRemoveFromFavourites);
  }

  Future<void> _onLoadFavourites(
    LoadFavourites event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(FavouritesLoading());

    final result = await loadFavouritesUseCase.call(
      const LoadFavouritesParams(),
    );

    result.fold(
      (failure) => emit(FavouritesError(failure.toString())),
      (favourites) => emit(FavouritesLoaded(favourites)),
    );
  }

  Future<void> _onAddToFavourites(
    AddToFavourites event,
    Emitter<FavouritesState> emit,
  ) async {
    final result = await addFavouriteUseCase.call(
      AddFavouriteParams(event.character),
    );

    result.fold(
      (failure) => emit(FavouritesError(failure.toString())),
      (_) => add(LoadFavourites()),
    );
  }

  Future<void> _onRemoveFromFavourites(
    RemoveFromFavourites event,
    Emitter<FavouritesState> emit,
  ) async {
    final result = await removeFavouriteUseCase.call(
      RemoveFavouriteParams(event.character),
    );

    result.fold(
      (failure) => emit(FavouritesError(failure.toString())),
      (_) => add(LoadFavourites()),
    );
  }
}
