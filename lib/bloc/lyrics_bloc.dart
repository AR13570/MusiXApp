// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:relu/services/LyricsService.dart';

import '../services/connectivityService.dart';

part 'lyrics_event.dart';
part 'lyrics_state.dart';

class LyricsBloc extends Bloc<LyricsEvent, LyricsState> {
  final LyricsService _lyricsService;
  final ConnectivityService _connectivityService;
  String trackID;
  LyricsBloc(
    this._lyricsService,
    this._connectivityService,
    this.trackID,
  ) : super(LyricsLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(NoInternetEvent());
      } else {
        add(LyricsRequested());
      }
    });
    on<LyricsRequested>((event, emit) async {
      final lyricsDetails = await _lyricsService.getLyrics(trackID);
      emit(LyricsLoadedState(lyricsBody: lyricsDetails!.lyrics.lyricsBody));
    });
    on<NoInternetEvent>((event, emit) {
      emit(InternetDisconnectedState());
    });
  }
}
