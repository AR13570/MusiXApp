// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:relu/services/connectivityService.dart';

import '../services/MusicAllService.dart';

part 'music_all_event.dart';
part 'music_all_state.dart';

class MusicAllBloc extends Bloc<MusicAllEvent, MusicAllState> {
  final MusicService _musicService;
  final ConnectivityService _connectivityService;
  MusicAllBloc(
    this._musicService,
    this._connectivityService,
  ) : super(MusicAllLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(NoInternetEvent());
      } else {
        add(LoadMusicEvent());
      }
    });
    on<LoadMusicEvent>((event, emit) async {
      final music = await _musicService.getMusicAll();
      emit(MusicAllLoadedState(trackList: music!.trackList));
    });
    on<NoInternetEvent>((event, emit) {
      emit(NoInternetState());
    });
  }
}
