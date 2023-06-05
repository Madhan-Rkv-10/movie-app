// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samplenavigationwithgrorouter/Home/models/movie_model.dart';

import '../../../app_router.dart';
import '../../controller/provider/providers.dart';
import 'movie_stack.dart';

class MovieDetailScreenModel extends HookConsumerWidget {
  final MovieData moviewValue;
  const MovieDetailScreenModel({required this.moviewValue, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(videoProvider(moviewValue.id!.toString()));

    return GestureDetector(
      onTap: () async {
        videos.when(
            data: (value) {
              return context.goNamed(AppRoute.detail.name, queryParameters: {
                "imdbValue": moviewValue.voteAverage.toString(),
                "voteAverage": moviewValue.voteAverage.toString(),
                "posterPath": moviewValue.posterPath ?? '',
                "popularity": moviewValue.popularity.toString(),
                "title": moviewValue.title ?? "",
                "overView": moviewValue.overview ?? '',
              }, pathParameters: {
                'id': value.videos.first.key.toString()
              });
              // return Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailPage(
              //       imdbValue: moviewValue.voteAverage.toString(),
              //       voteAverage: moviewValue.voteAverage!,
              //       posterPath: moviewValue.posterPath ?? '',
              //       popularity: moviewValue.popularity ?? 0,
              //       title: moviewValue.title ?? '',
              //       overView: moviewValue.overview ?? '',
              //       id: value.videos.first.key.toString(),
              //     ),
              //   ),

              // );
            },
            error: (error, stackTrace) {},
            loading: () => CircularProgressIndicator());
      },
      child: MovieStack(
          moviePath: moviewValue.posterPath.toString(),
          voteAverage: moviewValue.voteAverage.toString()),
    );
  }
}
