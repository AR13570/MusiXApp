import 'dart:convert';
import 'package:http/http.dart' as http;

MusicAll welcomeFromJson(String str) => MusicAll.fromJson(json.decode(str));

class MusicAll {
  MusicAll({required this.trackList});

  List<TrackList> trackList;

  factory MusicAll.fromJson(Map<String, dynamic> json) {
    return MusicAll(
      trackList: List<TrackList>.from(json["message"]["body"]["track_list"]
          .map((x) => TrackList.fromJson(x))),
    );
  }
}

class TrackList {
  TrackList({
    required this.track,
  });

  Track track;

  factory TrackList.fromJson(Map<String, dynamic> json) => TrackList(
        track: Track.fromJson(json["track"]),
      );
}

class Track {
  Track(
      {required this.trackId,
      required this.trackName,
      required this.hasLyrics,
      required this.albumName,
      required this.artistName,
      required this.trackShareUrl,
      required this.trackEditUrl,
      required this.trackRating,
      required this.explicit});

  int trackId;
  String trackName;
  int hasLyrics;
  String albumName;
  String artistName;
  String trackShareUrl;
  String trackEditUrl;
  int trackRating;
  int explicit;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
      trackId: json["track_id"],
      trackName: json["track_name"],
      hasLyrics: json["has_lyrics"],
      albumName: json["album_name"],
      artistName: json["artist_name"],
      trackShareUrl: json["track_share_url"],
      trackEditUrl: json["track_edit_url"],
      trackRating: json["track_rating"],
      explicit: json["explicit"]);
}

class MusicService {
  Future<MusicAll?> getMusicAll() async {
    try {
      //if any "String is not a subtype of int or index" error comes
      //its because the daily limit for the api calls has been exhausted

      final http.Response response = await http.get(Uri.parse(
          'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=831fb7cf8898ae03e5e7f1ad0595e04d'));

      if (response.statusCode == 200) {
        final MusicAll musicAll = welcomeFromJson(response.body);
        return musicAll;
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
