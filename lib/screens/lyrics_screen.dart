// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:relu/bloc/lyrics_bloc.dart';
import 'package:relu/services/LyricsService.dart';
import 'package:relu/services/MusicAllService.dart';
import 'package:relu/services/connectivityService.dart';

class LyricsScreen extends StatelessWidget {
  final Track track;
  final LyricsService _lyricsService = LyricsService();
  final ConnectivityService _connectivityService = ConnectivityService();
  LyricsScreen({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LyricsBloc(
          _lyricsService, _connectivityService, track.trackId.toString())
        ..add(LyricsRequested()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<LyricsBloc, LyricsState>(
              builder: (context, state) {
                if (state is LyricsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LyricsLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(track.trackName,
                                style: TextStyle(
                                    color: Colors.indigo[100], fontSize: 40))),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.1, horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.cyanAccent),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(20))),
                              child: const Text(
                                "Artist",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                track.artistName,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.cyanAccent),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.1, horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.cyanAccent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: const Text(
                                "Album",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                track.albumName,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.cyanAccent),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.1, horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.cyanAccent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: const Text(
                                "Rating",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${track.trackRating.toString()}%",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.cyanAccent),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        track.explicit == 1
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.1, horizontal: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color: Colors.white60,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: const Text(
                                    "EXPLICIT",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              )
                            : Container(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Center(
                            child: Divider(
                              thickness: 1,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Lyrics",
                          style: TextStyle(
                              fontSize: 35,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: Colors.cyanAccent),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.lyricsBody,
                          style: const TextStyle(
                              fontSize: 17, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  );
                } else if (state is InternetDisconnectedState) {
                  Navigator.pop(context);
                  return Container();
                } else {
                  return Container();
                }
              },
            )),
      ),
    );
  }
}
