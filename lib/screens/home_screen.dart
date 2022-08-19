// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu/bloc/music_all_bloc.dart';
import 'package:relu/services/MusicAllService.dart';
import 'package:lottie/lottie.dart';
import 'package:relu/services/connectivityService.dart';
import 'lyrics_screen.dart';

class HomeScreen extends StatelessWidget {
  final MusicService _musicService = MusicService();
  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MusicAllBloc(_musicService, _connectivityService)
        ..add(LoadMusicEvent()),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Center(
                child: Text(
              "MusiX",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
            )),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocConsumer<MusicAllBloc, MusicAllState>(
                listener: (context, state) {
              if (state is MusicAllLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.blueGrey.shade700,
                  content: const Text("Connected to Internet"),
                  duration: const Duration(milliseconds: 300),
                ));
              }
            }, builder: (context, state) {
              if (state is MusicAllLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MusicAllLoadedState) {
                return Stack(
                  children: [
                    Positioned(
                      top: -30,
                      left: 0,
                      right: 0,
                      child: Center(
                          child: SizedBox(
                              height: 300,
                              child: Lottie.asset("assets/music.json",
                                  animate: true))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 230,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Library",
                            style: TextStyle(
                                fontSize: 40,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Colors.cyanAccent),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 55.0),
                            child: Center(
                              child: Divider(
                                thickness: 1,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                          Center(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.trackList.length,
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: Colors.white24)),
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.only(
                                              left: 20,
                                              bottom: 10,
                                              top: 4,
                                              right: 20),
                                          trailing: Icon(
                                            Icons.lyrics_rounded,
                                            size: 25,
                                            color: Colors.amber.shade200,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          title: Text(
                                            state.trackList[index].track
                                                .albumName,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "By ${state.trackList[index].track.artistName}",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.indigo[200])),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              state.trackList[index].track
                                                          .explicit ==
                                                      1
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0.1,
                                                          horizontal: 3),
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white60,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: const Text(
                                                        "EXPLICIT",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsScreen(
                                                          track: state
                                                              .trackList[index]
                                                              .track))),
                                        ),
                                      ),
                                    )),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (state is NoInternetState) {
                return Center(
                  child: Column(
                    children: const [
                      Icon(Icons.wifi_off_rounded, size: 50),
                      Text("Disconnected")
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
          )),
    );
  }
}
