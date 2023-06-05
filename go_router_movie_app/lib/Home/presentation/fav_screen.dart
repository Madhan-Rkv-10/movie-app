import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils.dart';
import '../controller/provider/providers.dart';
import 'detail_page.dart';

class FavScreen extends HookConsumerWidget {
  const FavScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(fav);
    print("object");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: context.theme.textTheme.titleLarge!.color,
            )),
        title: Text(
          "Favorite Movies List",
          style: context.theme.textTheme.titleLarge,
        ),
      ),
      body: d.when(
        data: (data) {
          return ListView.builder(
              itemCount: data.item.length,
              itemBuilder: (context, index) {
                final movieItem = data.item.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      final videos =
                          ref.watch(videoProvider(movieItem.id!.toString()));
                      String url = videos.value!.videos.first.key.toString();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            imdbValue: movieItem.voteAverage.toString(),
                            voteAverage: movieItem.voteAverage!,
                            posterPath: movieItem.posterPath ?? '',
                            popularity: movieItem.popularity ?? 0,
                            title: movieItem.title ?? '',
                            overView: movieItem.overview ?? '',
                            id: url,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image.network(
                        Utils.posterPathUrl(
                          movieItem.posterPath.toString(),
                        ),
                      ),
                      title: Text(
                        movieItem.title.toString(),
                      ),
                      subtitle: Text(
                        movieItem.overview.toString(),
                        maxLines: 2,
                        style: context.theme.textTheme.displaySmall,
                      ),
                    ),
                  ),
                );
              });
        },
        error: (s, t) {
          return const Text("Error");
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
