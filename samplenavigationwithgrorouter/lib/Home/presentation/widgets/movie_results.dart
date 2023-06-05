import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samplenavigationwithgrorouter/Home/presentation/widgets/movie_details_widget.dart';
import 'package:samplenavigationwithgrorouter/app_router.dart';

import '../../controller/provider/providers.dart';
import '../detail_page.dart';
import 'movie_stack.dart';

class MovieResult extends HookConsumerWidget {
  const MovieResult({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(movieControllerProvider);
    final isLoading = ref.watch(isLoadingProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : data!.item.isEmpty
              ? const Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: data.item.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    final moviewValue = data.item[index];
                    return MovieDetailScreenModel(moviewValue: moviewValue);
                  }),
                ),
    );
  }
}
