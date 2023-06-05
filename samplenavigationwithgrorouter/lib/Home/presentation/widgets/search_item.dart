import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/provider/providers.dart';
import '../../models/movie_model.dart';

class SearchMovie extends HookConsumerWidget {
  const SearchMovie({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(movieControllerProvider);
    final themeMode = ref.watch(themeProvider);

    return Autocomplete<MovieData>(
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text == '') {
          return List.empty();
        } else {
          return data!.item
              .where(
                (element) => element.title!.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    ),
              )
              .toList();
        }
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, Function onFieldSubmitted) {
        return TextField(
          onSubmitted: (value) async {
            FocusManager.instance.primaryFocus?.unfocus();
            FocusScope.of(context).unfocus();
            ref
                .read(movieControllerProvider.notifier)
                .fetchMovies(filterValue: value);
          },
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                  color: !themeMode ? Colors.black54 : Colors.white,
                  fontWeight: FontWeight.normal),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.92,
                  maxHeight: MediaQuery.of(context).size.height * 0.07),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20.0),
              ),
              filled: true,
              fillColor: !themeMode
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.5),
              prefixIconColor: Colors.red,
              prefixIcon: IconButton(
                onPressed: (() async {}),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              suffixIconColor: Colors.grey),
        );
      },
      onSelected: (option) async {
        try {
          ref
              .read(movieControllerProvider.notifier)
              .fetchMovies(filterValue: option.title!.toLowerCase());
          FocusManager.instance.primaryFocus?.unfocus();
        } catch (e) {
          throw 'Error Ocuured';
        }
      },
      displayStringForOption: (option) {
        return option.title!;
      },
    );
  }
}
