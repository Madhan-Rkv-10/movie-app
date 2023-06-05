import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samplenavigationwithgrorouter/Home/controller/provider/providers.dart';
import 'package:samplenavigationwithgrorouter/Home/presentation/filters.dart';

import '../models/movie_model.dart';
import '../repository/movie_repository.dart';

///Movies List Data Controller
class MovieController extends StateNotifier<Movies?> {
  MovieController(this.ref) : super(null) {
    repo = ref!.read(repoProvider);

    ///Init State fetch Values
    fetchMovies();
  }
  late MovieRepository? repo;
  final StateNotifierProviderRef? ref;
  Future<void> fetchMovies({String filterValue = ''}) async {
    ///TO Check the whether the filter is enabled or not
    final isSearched = ref!.watch(appliedFilter);
    if (isSearched == true) {
      final filter = ref!.watch(movieFilterProvider);

      ///Checking the selected generes list

      final sets = ref!.watch(selectedGenresListProvider);
      final value = await repo?.loadData(filterValue, filterType: filter.value);
      final filteredData = sets.isEmpty
          ? value?.item.toList()
          : value?.item
              .where(
                (element) => Set.of(element.genrId!)
                    .containsAll(sets.map((e) => e.id).toList()),
              )
              .toList();
      if (!mounted) {
        return;
      } else {
        state = sets.isEmpty
            ? value!
            : Movies(
                item: filteredData!,
              );
      }
    } else {
      ///  Check  whether the filters are selected or not
      final filter = ref!.watch(movieFilterProvider);
      final value = await repo?.loadData(filterValue, filterType: filter.value);
      if (!mounted) {
        return;
      } else {
        state = value!;
      }
    }
  }
}
