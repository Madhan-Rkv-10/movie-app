// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samplenavigationwithgrorouter/utils.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulHookConsumerWidget {
  const DetailPage({
    Key? key,
    required this.imdbValue,
    required this.voteAverage,
    required this.posterPath,
    required this.popularity,
    required this.title,
    required this.overView,
    required this.id,
  }) : super(key: key);
  final String imdbValue;
  final num voteAverage;
  final String posterPath;
  final double popularity;
  final String title;
  final String overView;
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late YoutubePlayerController youtubePlayerController;
  @override
  void initState() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: context.theme.textTheme.titleLarge!.color,
            )),
        title: Text(
          widget.title,
          style: context.theme.textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child: YoutubePlayer(controller: youtubePlayerController),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              backgroundColor: Colors.amber,
                              labelStyle: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                              label: Text(
                                'IMDB ${widget.voteAverage}, ',
                                style: TextStyle(
                                    color: context
                                        .theme.textTheme.titleLarge!.color),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.star,
                              size: 30,
                              color: Colors.amber,
                            ),
                          ),
                          Text(
                            '${widget.voteAverage}',
                            style: context.theme.textTheme.bodySmall,
                          ),
                          Text(
                            ' (${(widget.popularity).round()}K reviews)',
                            style: TextStyle(
                              color: context.theme.textTheme.titleLarge!.color,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      Text(
                        widget.title,
                        textAlign: TextAlign.left,
                        style: context.theme.textTheme.displayLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 25),
                        child: SizedBox(
                          child: Text(
                            widget.overView,
                            style: context.theme.textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
