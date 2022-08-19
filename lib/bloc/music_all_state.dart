// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'music_all_bloc.dart';

abstract class MusicAllState extends Equatable {
  const MusicAllState();

  @override
  List<Object> get props => [];
}

//class MusicAllNotLoaded extends MusicAllState {}
class MusicAllLoadingState extends MusicAllState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class MusicAllLoadedState extends MusicAllState {
  List<TrackList> trackList;
  MusicAllLoadedState({
    required this.trackList,
  });
  @override
  List<Object> get props => [this.trackList];
}

class NoInternetState extends MusicAllState {}
