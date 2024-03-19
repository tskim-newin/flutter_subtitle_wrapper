import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_wrapper_package/bloc/subtitle/subtitle_bloc.dart';
import 'package:subtitle_wrapper_package/data/constants/view_keys.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_style.dart';

class SubtitleTextView extends StatelessWidget {
  const SubtitleTextView({
    required this.subtitleStyle,
    super.key,
    this.backgroundColor,
    this.textScaler,
    this.maxLines,
    this.overflow,
  });
  final SubtitleStyle subtitleStyle;
  final Color? backgroundColor;
  final TextScaler? textScaler;
  final int? maxLines;
  final TextOverflow? overflow;

  TextStyle get _textStyle {
    return subtitleStyle.hasBorder
        ? subtitleStyle.textStyle.copyWith(shadows: [
            Shadow(
                color: subtitleStyle.borderStyle.color,
                offset: Offset(-subtitleStyle.borderStyle.strokeWidth,
                    -subtitleStyle.borderStyle.strokeWidth)),
            Shadow(
                color: subtitleStyle.borderStyle.color,
                offset: Offset(-subtitleStyle.borderStyle.strokeWidth,
                    subtitleStyle.borderStyle.strokeWidth)),
            Shadow(
                color: subtitleStyle.borderStyle.color,
                offset: Offset(subtitleStyle.borderStyle.strokeWidth,
                    -subtitleStyle.borderStyle.strokeWidth)),
            Shadow(
                color: subtitleStyle.borderStyle.color,
                offset: Offset(subtitleStyle.borderStyle.strokeWidth,
                    subtitleStyle.borderStyle.strokeWidth)),
          ])
        : subtitleStyle.textStyle;
  }

  @override
  Widget build(BuildContext context) {
    final subtitleBloc = BlocProvider.of<SubtitleBloc>(context);

    // TODO(Joran-Dob): improve this workaround.
    void subtitleBlocListener(BuildContext _, SubtitleState state) {
      if (state is SubtitleInitialized) {
        subtitleBloc.add(LoadSubtitle());
      }
    }

    return BlocConsumer<SubtitleBloc, SubtitleState>(
      listener: subtitleBlocListener,
      builder: (context, state) {
        if (state is LoadedSubtitle && state.subtitle != null) {
          if (!state.showSubtitle) {
            return const SizedBox();
          }
          return Center(
            child: Container(
              color: backgroundColor,
              child: _TextContent(
                text: state.subtitle!.text,
                textStyle: _textStyle,
                textScaler: textScaler,
                maxLines: maxLines,
                overflow: overflow,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _TextContent extends StatelessWidget {
  const _TextContent({
    required this.textStyle,
    required this.text,
    this.textScaler,
    this.maxLines,
    this.overflow,
  });

  final TextStyle textStyle;
  final String text;
  final TextScaler? textScaler;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: ViewKeys.subtitleTextContent,
      textAlign: TextAlign.center,
      style: textStyle,
      textScaler: textScaler,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
