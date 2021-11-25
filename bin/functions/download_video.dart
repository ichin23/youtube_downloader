import 'dart:io';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'get_video.dart';

downloadVideo(String video, YoutubeExplode yt, String tipo, String path) async {
  var url = video;
  var music = await get(url, yt);
  print("Baixando: ${music.title}");

  var file;

  if (tipo == "MP3") {
    file = await File(
            "$path${music.title.replaceAll('|', "-").replaceAll('\\', '-').replaceAll('/', '-').replaceAll('.', '-')}.mp3")
        .create(recursive: true);
  } else {
    file = await File(
            "$path${music.title.replaceAll('|', "-").replaceAll('\\', '-').replaceAll('/', '-').replaceAll('.', '-')}.mp4")
        .create(recursive: true);
  }

  var fileStream = file.openWrite();
  var manifest = await yt.videos.streams.getManifest(music.id);

  var type;
  if (tipo == "MP3") {
    type = manifest.audioOnly.withHighestBitrate();
  } else {
    type = manifest.muxed.withHighestBitrate();
  }

  var stream = yt.videos.streamsClient.get(type);

  await stream.pipe(fileStream).catchError((err) {
    print(err);
  }).then((val) => print(music.title + "   ----   OK"));

  yt.close;
  exit(0);
}
