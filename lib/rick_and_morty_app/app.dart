import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/common/di/dependencies.dart';
import 'package:rick_and_morty_app/common/navigation/app_router.dart';
import 'package:rick_and_morty_app/common/theme/app_themes.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_event.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/character_list/character_list_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/character_list/character_list_event.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/favourites/favourites_event.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = ThemeBloc();
            bloc.add(LoadTheme());
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) {
            final bloc = CharacterListBloc(
              loadCharactersUseCase: loadCharactersUseCase,
            );
            bloc.add(LoadCharactersPage(1, isInitialLoad: true));
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) {
            final bloc = FavouritesBloc(
              loadFavouritesUseCase: loadFavouritesUseCase,
              addFavouriteUseCase: addFavouriteUseCase,
              removeFavouriteUseCase: removeFavouriteUseCase,
            );
            bloc.add(LoadFavourites());
            return bloc;
          },
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: "Rick And Morty App",
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: state.themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
