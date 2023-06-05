import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samplenavigationwithgrorouter/Home/presentation/detail_page.dart';
import 'package:samplenavigationwithgrorouter/Home/presentation/home_screen.dart';

import 'Home/presentation/fav_screen.dart';

enum AppRoute { home, detail }

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: AppRoute.detail.name,
          path: 'detail/:id',
          // path: 'family/:fid',

          // builder: (context, state) => const FavScreen(),
          ///for transaltion for bottom to top we can use page builder
          pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,

              ///which Enables transition from bottom it enables[cross(x)] icon from normal back
              fullscreenDialog: true,
              child: DetailPage(
                  imdbValue: state.queryParameters['imdbValue'] ?? '',
                  voteAverage:
                      num.parse(state.queryParameters['voteAverage'] ?? '0'),
                  posterPath: state.queryParameters['posterPath'] ?? '',
                  popularity:
                      double.parse(state.queryParameters['popularity'] ?? '0'),
                  title: state.queryParameters['title'] ?? '',
                  overView: state.queryParameters['overView'] ?? '',
                  id: state.pathParameters['id']!)),
        ),
        GoRoute(
          path: 'fav',
          // builder: (context, state) => const FavScreen(),
          ///for transaltion for bottom to top we can use page builder
          pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,

              ///which Enables transition from bottom it enables[cross(x)] icon from normal back
              fullscreenDialog: true,
              child: const FavScreen()),
        ),
      ],
    ),
  ],
);
