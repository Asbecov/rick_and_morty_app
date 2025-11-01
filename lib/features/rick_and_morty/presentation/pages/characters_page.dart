import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_event.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/character_list/character_list_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/character_list/character_list_event.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/character_list/character_list_state.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/favourites/favourites_event.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/bloc/favourites/favourites_state.dart';

class CharactersListTab extends StatefulWidget {
  const CharactersListTab({super.key});

  @override
  State<CharactersListTab> createState() => _CharactersListTabState();
}

class _CharactersListTabState extends State<CharactersListTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<CharacterListBloc>().state;
      if (state is CharacterListLoaded && !state.hasReachedMax) {
        context.read<CharacterListBloc>().add(
          LoadCharactersPage(state.currentPage + 1),
        );
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  List<Character> _getCharacters(CharacterListState state) {
    if (state is CharacterListLoaded) {
      return state.characters;
    } else if (state is CharacterListLoading) {
      return state.previousCharacters;
    } else if (state is CharacterListError) {
      return state.previousCharacters;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
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
      body: BlocBuilder<CharacterListBloc, CharacterListState>(
        builder: (context, state) {
          if (state is CharacterListLoading &&
              state.previousCharacters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CharacterListError && state.previousCharacters.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<CharacterListBloc>().add(
                      LoadCharactersPage(1, isInitialLoad: true),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final List<Character> characters = _getCharacters(state);

          if (characters.isEmpty) {
            return const Center(child: Text('No data'));
          }

          return BlocBuilder<FavouritesBloc, FavouritesState>(
            builder: (context, favState) {
              final Set<int> favIds = (favState is FavouritesLoaded)
                  ? favState.favourites.map((c) => c.id).toSet()
                  : <int>{};

              return ListView.separated(
                controller: _scrollController,
                itemCount: characters.length + 1,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index >= characters.length) {
                    return state is CharacterListLoading
                        ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox.shrink();
                  }

                  final character = characters[index];
                  final isFav = favIds.contains(character.id);

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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: Icon(
                                        isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFav ? Colors.red : null,
                                      ),
                                      onPressed: () {
                                        final bloc = context
                                            .read<FavouritesBloc>();
                                        if (isFav) {
                                          bloc.add(
                                            RemoveFromFavourites(character),
                                          );
                                        } else {
                                          bloc.add(AddToFavourites(character));
                                        }
                                      },
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
            },
          );
        },
      ),
    );
  }
}
