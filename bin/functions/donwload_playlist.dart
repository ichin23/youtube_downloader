import 'dart:io';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'get_playlist.dart';

downloadPlaylist(
    String playUrl, YoutubeExplode yt, String tipo, String path) async {
  var playlist = await getPlaylist(playUrl, yt);

  print("Baixando playlist: " + playlist.title);
  await for (var music in yt.playlists.getVideos(playlist.id)) {
    print("Baixando: ${music.title}");

    var file;
    if (tipo == "MP3") {
      file = await File(
              "$path${playlist.title}/${music.title.replaceAll('|', "-").replaceAll('\\', '-').replaceAll('/', '-').replaceAll('.', '-')}.mp3")
          .create(recursive: true);
    } else {
      file = await File(
              "$path${music.title.replaceAll('|', "-").replaceAll('\\', '-').replaceAll('/', '-').replaceAll('.', '-')}.mp4")
          .create(recursive: true);
    }

    var fileStream = file.openWrite();
    var manifest = await yt.videos.streams.getManifest(music.id);

    var stream =
        yt.videos.streamsClient.get(manifest.audioOnly.withHighestBitrate());

    await stream.pipe(fileStream).catchError((err) {
      print(err);
    }).then((val) => print(music.title + "   ----   OK"));
  }
  yt.close;
  exit(0);
}
