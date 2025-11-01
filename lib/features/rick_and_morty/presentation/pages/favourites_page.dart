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
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: character.imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                              width: 120,
                              height: 120,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 120,
                              height: 120,
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.broken_image,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${character.gender} • ${character.status}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => context
                                        .read<FavouritesBloc>()
                                        .add(RemoveFromFavourites(character)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
