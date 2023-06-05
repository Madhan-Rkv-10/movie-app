import 'package:flutter/material.dart';
import '../../../utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MovieStack extends HookConsumerWidget {
  const MovieStack({
    super.key,
    required this.moviePath,
    required this.voteAverage,
  });
  final String moviePath;
  final String voteAverage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 0.7,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(Utils.posterPathUrl(moviePath))),
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(20),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        voteAverage,
                        style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        height: 30,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "IMBD  $voteAverage",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
