import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<Playlist> getPlaylist(String url, YoutubeExplode yt) async {
  return await yt.playlists.get(url);
}
