part of 'subtitle_bloc.dart';

abstract class SubtitleState extends Equatable {
  const SubtitleState();
}

class SubtitleInitial extends SubtitleState {
  @override
  List<Object> get props => [];
}

class SubtitleInitializing extends SubtitleState {
  @override
  List<Object> get props => [];
}

class SubtitleInitialized extends SubtitleState {
  @override
  List<Object> get props => [];
}

class LoadingSubtitle extends SubtitleState {
  @override
  List<Object> get props => [];
}

class LoadedSubtitle extends SubtitleState {
  const LoadedSubtitle(this.subtitle, {required this.showSubtitle});
  final Subtitle? subtitle;
  final bool showSubtitle;

  @override
  List<Object?> get props => [subtitle, showSubtitle];
}

class CompletedSubtitle extends SubtitleState {
  @override
  List<Object> get props => [];
}
