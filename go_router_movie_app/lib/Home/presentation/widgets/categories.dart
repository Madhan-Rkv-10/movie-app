import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/provider/providers.dart';

class Categories extends HookConsumerWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sets = ref.watch(selectedGenresListProvider);
    final filteredDataProvider = ref.watch(appliedFilter);
    final themeMode = ref.watch(themeProvider);
    return Container(
      margin: const EdgeInsets.only(left: 20),
      height: 70,
      child: Row(
        mainAxisAlignment: filteredDataProvider
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
                backgroundColor:
                    !themeMode ? Colors.white : Colors.grey.withOpacity(0.3),
                foregroundColor:
                    !themeMode ? const Color(0xffF8B88B) : Colors.white),
            onPressed: () {
              if (sets.isEmpty) {
                ref.read(appliedFilter.notifier).state = false;
              }
              showModalBottomSheet(
                backgroundColor: Colors.transparent.withOpacity(0.0),
                isScrollControlled: true,
                isDismissible: true,
                elevation: 0,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: Container(
                            color: Colors.transparent,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.cancel_presentation_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        HookConsumer(builder: (context, r, child) {
                          final data = r.watch(genresListProvider);
                          return Container(
                            color: !themeMode ? Colors.white : Colors.black,
                            height: MediaQuery.of(context).size.height * 0.70,
                            child: ListView.builder(
                              itemCount: data.genres.length,
                              itemBuilder: (context, index) {
                                final element = data.genres.elementAt(index);
                                return ListTile(
                                  leading: Checkbox(
                                    autofocus: true,
                                    side: const BorderSide(color: Colors.grey),
                                    activeColor: Colors.grey,
                                    checkColor: Colors.white,
                                    value: element.selected,
                                    onChanged: (value) async {
                                      ref
                                          .read(genresListProvider.notifier)
                                          .updateOption(element.id, value!);
                                    },
                                  ),
                                  title: Text(
                                    element.name,
                                    style: TextStyle(
                                        color: !themeMode
                                            ? Colors.grey
                                            : Colors.grey),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                        Container(
                          color: !themeMode ? Colors.white : Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 80,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: ElevatedButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              movieControllerProvider.notifier)
                                          .fetchMovies();
                                      ref.read(appliedFilter.notifier).state =
                                          true;
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Apply')),
                              ),
                              Container(
                                height: 40,
                                width: 80,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (!filteredDataProvider) {
                                        ref.invalidate(genresListProvider);
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel')),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.sort_sharp),
            label: const Text('Filter'),
          ),
          // if (filteredDataProvider==tru)
          if (sets.isNotEmpty)
            Expanded(
              child: Container(
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sets.length,
                  itemBuilder: (context, index) {
                    final data = ref.watch(selectedGenresListProvider);
                    final element = data.elementAt(index);
                    final s = sets.toList();
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: !themeMode
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.3),
                              foregroundColor: !themeMode
                                  ? Color(0xffF8B88B)
                                  : Colors.white),
                          onPressed: () async {
                            ref
                                .read(genresListProvider.notifier)
                                .updateOption(element.id, false);
                            final s = ref.watch(selectedGenresListProvider);
                            if (s.isNotEmpty) {
                              await ref
                                  .read(movieControllerProvider.notifier)
                                  .fetchMovies();
                            } else {
                              await ref
                                  .read(movieControllerProvider.notifier)
                                  .fetchMovies();
                              if (!filteredDataProvider) {
                                ref.invalidate(genresListProvider);
                              }

                              ref.read(appliedFilter.notifier).state = false;
                            }
                          },
                          child: Text(s[index].name,
                              textAlign: TextAlign.justify)),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
