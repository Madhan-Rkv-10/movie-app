import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/favorite_movie_model.dart';
import '../../models/genres_model.dart';
import '../../models/movie_model.dart';
import '../../models/video_reponse.dart';
import '../../presentation/filters.dart';
import '../../repository/movie_repository.dart';
import '../genres_controller.dart';
import '../movie_controller.dart';

///StateProviders
final movieFilterProvider = StateProvider((ref) => MovieType.popular);
final isLoadingProvider = StateProvider<bool>((ref) => false);
final appliedFilter = StateProvider<bool>((ref) => false);
final themeProvider = StateProvider<bool>((ref) => false);
final selectedGenresListProvider = StateProvider<Iterable<Genres>>((ref) {
  final res = ref
      .watch(genresListProvider)
      .genres
      .where((element) => element.selected == true);
  return res;
});

///Repository Provider
final repoProvider = Provider((ref) => MovieRepository());

///movieControllerProvider
final movieControllerProvider =
    StateNotifierProvider.autoDispose<MovieController, Movies?>((ref) {
  return MovieController(ref);
});

///genresListController

final genresListProvider =
    StateNotifierProvider<GenresController, GenresList>((ref) {
  return GenresController(ref);
});
final fav = FutureProvider<FavoriteMovies>((ref) {
  final data = ref.watch(repoProvider);
  return data.fetchFavMovies();
});

///Future VideoProvider
final videoProvider = FutureProvider.family<VideosList, String>(
  (ref, arg) {
    final provider = ref.watch(repoProvider);
    return provider.movieVideos(arg);
  },
);
