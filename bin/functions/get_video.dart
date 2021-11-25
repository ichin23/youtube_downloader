import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<Video> get(String url, YoutubeExplode yt) async {
  return await yt.videos.get(url);
}
