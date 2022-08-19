// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'lyrics_bloc.dart';

abstract class LyricsState extends Equatable {
  const LyricsState();

  @override
  List<Object> get props => [];
}

class LyricsLoadingState extends LyricsState {}

class LyricsLoadedState extends LyricsState {
  String lyricsBody;
  LyricsLoadedState({
    required this.lyricsBody,
  });
  @override
  List<Object> get props => [
        lyricsBody,
      ];
}

class InternetDisconnectedState extends LyricsState {}
