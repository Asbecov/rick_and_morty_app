import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/pages/characters_page.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/pages/favourites_page.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/presentation/widgets/scaffold_with_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorCharactersKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellCharacters',
);
final _shellNavigatorFavouritesKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellFavourites',
);

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/characters',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCharactersKey,
            routes: [
              GoRoute(
                path: '/characters',
                name: 'characters',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const CharactersListTab(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorFavouritesKey,
            routes: [
              GoRoute(
                path: '/favourites',
                name: 'favourites',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const FavouritesPage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
