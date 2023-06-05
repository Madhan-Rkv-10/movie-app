import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/provider/providers.dart';
import '../filters.dart';

class MovieFilter extends ConsumerWidget {
  const MovieFilter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieType = ref.watch(movieFilterProvider);
    final themeMode = ref.watch(themeProvider);
    final sets = ref.watch(selectedGenresListProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: MovieType.values
          .map(
            (type) => GestureDetector(
              onTap: () {
                ref.read(movieFilterProvider.notifier).state = type;
                if (sets.isNotEmpty) {
                  ref.read(appliedFilter.notifier).state = true;
                } else {
                  ref.read(appliedFilter.notifier).state = false;
                }
              },
              child: Container(
                height: 30,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: type == movieType
                      ? themeMode
                          ? Colors.white
                          : const Color(0xffF8B88B)
                      : null,
                ),
                child: Text(
                  type.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: type != movieType
                          ? themeMode
                              ? Colors.white
                              : const Color(0xffF8B88B)
                          : themeMode
                              ? const Color(0xffF8B88B)
                              : Colors.white),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
