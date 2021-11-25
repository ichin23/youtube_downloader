import 'dart:io';

import 'package:args/args.dart';
import 'package:download_youtube/download_youtube.dart' as download_youtube;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'functions/donwload_playlist.dart';
import 'functions/download_video.dart';

void main(List<String> args) async {
  final parse = ArgParser();
  parse.addOption("playlist", abbr: "p", help: "Baixar Playlist");
  parse.addOption("video", abbr: "v", help: "Baixar Video");
  parse.addOption("path", abbr: "d", help: "Caminho do Download");
  parse.addOption("type",
      abbr: "t", help: "Tipo de download", allowed: ["MP4", "MP3"]);
  parse.addFlag("help", abbr: "h", help: "Lista de Comando");
  final results = parse.parse(args);
  YoutubeExplode yt = YoutubeExplode();

  if (results.wasParsed('help')) {
    print(parse.usage);
    exit(0);
  }

  if (!results.wasParsed("type")) {
    print("'type' argumment is necessary");
    print(parse.usage);
    exit(0);
  }

  if (results.wasParsed("path")) {
    if (results.wasParsed("video")) {
      downloadVideo(results['video'], yt, results['type'], results['path']);
    } else if (results.wasParsed("playlist")) {
      downloadPlaylist(
          results['playlist'], yt, results['type'], results['path']);
    }
  } else {
    print("'path' argumment is necessary");
    print(parse.usage);
  }
  yt.close;
  exit(0);
}
