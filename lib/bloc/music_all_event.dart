part of 'music_all_bloc.dart';

abstract class MusicAllEvent extends Equatable {
  const MusicAllEvent();

  @override
  List<Object> get props => [];
}

class LoadMusicEvent extends MusicAllEvent {}

class NoInternetEvent extends MusicAllEvent {}
