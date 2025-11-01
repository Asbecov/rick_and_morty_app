import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_event.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/favourites/favourites_event.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/favourites/favourites_state.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Characters'),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () => context.read<ThemeBloc>().add(ToggleTheme()),
                tooltip: state.isDarkMode ? 'Light Mode' : 'Dark Mode',
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavouritesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<FavouritesBloc>().add(LoadFavourites()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is FavouritesLoaded) {
            final favs = state.favourites;

            if (favs.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No favourite characters yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              itemCount: favs.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final character = favs[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      character.imageUrl,
                    ),
                  ),
                  title: Text(character.name),
                  subtitle: Text('${character.gender} • ${character.status}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => context.read<FavouritesBloc>().add(
                      RemoveFromFavourites(character),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
