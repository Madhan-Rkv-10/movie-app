// ignore: constant_identifier_names
enum MovieType { popular, upcoming, now_playing, top_rated }

extension MovieTypeExtension on MovieType {
  String get value => toString().split('.').last;
  String get name {
    String name;
    switch (this) {
      case MovieType.popular:
        name = "Popular";
        break;
      case MovieType.upcoming:
        name = "Up Coming";
        break;
      case MovieType.now_playing:
        name = "Now Playing";
        break;
      case MovieType.top_rated:
        name = "Top rated";
        break;
    }
    return name;
  }
}
