import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Utils {
  static String posterPathUrl(String url) {
    return 'https://image.tmdb.org/t/p/w185/$url';
  }

  static String apiUrl() {
    return 'https://api.themoviedb.org/3/';
  }

  static String fetchMovieParams() =>
      '?api_key=${dotenv.env['APIKEY']}&language=en-US&sort_by=created_at.asc&page=1&session_id=${dotenv.env['SESSION_ID']}';
  static String fetchMovieUrl(String params) =>
      '${apiUrl()}account/16291825/favorite/movies$params';

  static String movieVideos(String id) =>
      '${apiUrl()}movie/$id/videos?api_key=${dotenv.env['APIKEY']}&language=en-US';
}

extension ContextUtils on BuildContext {
  ThemeData get theme => Theme.of(this);
}
