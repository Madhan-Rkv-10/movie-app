import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samplenavigationwithgrorouter/Home/controller/provider/providers.dart';

import '../models/genres_model.dart';
import '../repository/movie_repository.dart';

///Generes List Controller
class GenresController extends StateNotifier<GenresList> {
  GenresController(this.ref) : super(GenresList(genres: [])) {
    repo = ref!.read(repoProvider);
    fetchGenresList();
  }
  final StateNotifierProviderRef? ref;

  late MovieRepository? repo;

  ///fetch List of generes
  Future<void> fetchGenresList() async {
    final data = await repo?.getGenresList();
    state = data!;
  }

  ///Updates the selection of generes to filter the movie

  Future<void> updateOption(int index, bool value) async {
    state = state.copyWith(
        genres: state.genres.map((e) {
      if (e.id == index) {
        return e.copyWith(selected: value);
      } else {
        return e;
      }
    }).toList());
  }
}
