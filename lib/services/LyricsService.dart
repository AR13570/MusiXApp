// To parse this JSON data, do
//
//     final lyricsService = lyricsServiceFromJson(jsonString);

import 'dart:convert';

import 'package:http/http.dart' as http;

LyricsData lyricsServiceFromJson(String str) =>
    LyricsData.fromJson(json.decode(str));

class LyricsData {
  LyricsData({
    required this.lyrics,
  });

  Lyrics lyrics;

  factory LyricsData.fromJson(Map<String, dynamic> json) => LyricsData(
        lyrics: Lyrics.fromJson(json["message"]["body"]["lyrics"]),
      );
}

class Lyrics {
  Lyrics({
    required this.lyricsBody,
  });

  String lyricsBody;

  factory Lyrics.fromJson(Map<String, dynamic> json) => Lyrics(
        lyricsBody: json["lyrics_body"],
      );
}

class LyricsService {
  Future<LyricsData?> getLyrics(String trackID) async {
    try {
      final http.Response response = await http.get(Uri.parse(
          "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${trackID}&apikey=831fb7cf8898ae03e5e7f1ad0595e04d"));
      //print(response.body);
      if (response.statusCode == 200) {
        final LyricsData lyricsData = lyricsServiceFromJson(response.body);
        return lyricsData;
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
