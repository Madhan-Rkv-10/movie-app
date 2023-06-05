import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:samplenavigationwithgrorouter/Home/presentation/fav_screen.dart';

import 'package:samplenavigationwithgrorouter/Home/presentation/widgets/categories.dart';
import 'package:samplenavigationwithgrorouter/Home/presentation/widgets/movie_filters.dart';
import 'package:samplenavigationwithgrorouter/Home/presentation/widgets/movie_results.dart';
import 'package:samplenavigationwithgrorouter/Home/presentation/widgets/search_item.dart';
import 'package:samplenavigationwithgrorouter/utils.dart';
import 'dart:developer' as d show log;
import '../controller/provider/providers.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool value = false;
  @override
  Widget build(
    BuildContext context,
  ) {
    final sets = ref.watch(selectedGenresListProvider);

    final isFiltered = ref.watch(appliedFilter);
    final data = ref.watch(movieControllerProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              'The Movie Database',
              style: context.theme.textTheme.titleLarge,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      d.log("onpreseed");
                      return context.go('/fav');
                    },
                    icon: Icon(
                      Icons.favorite_outlined,
                      color: !themeMode ? Colors.grey : Colors.white,
                      size: 28,
                    )),
                CupertinoSwitch(
                  value: themeMode,
                  onChanged: (v) {
                    ref.read(themeProvider.notifier).state = v;
                  },
                  trackColor: Colors.grey,
                  activeColor:
                      value ? Colors.black.withOpacity(0.4) : Colors.grey,
                ),
              ],
            ),
          )),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: MovieFilter(),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const SearchMovie(),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Top Results',
                        style: context.theme.textTheme.titleLarge),
                  ],
                ),
              ),
            ),
          ),
          const Flexible(child: Categories()),
          data == null
              ? const Align(
                  alignment: Alignment.center,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.grey,
                  )),
                )
              : (isFiltered && sets.isEmpty)
                  ? const Text("No result found")
                  : const MovieResult(),
        ],
      ),
    );
  }
}
