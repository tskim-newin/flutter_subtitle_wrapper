import 'package:equatable/equatable.dart' show Equatable;
import 'package:subtitle_wrapper_package/data/models/subtitle_token.dart';

class Subtitle extends Equatable {
  final Duration startTime;
  final Duration endTime;
  List<SubtitleToken> subtitleTokens;

  final String text;

  Subtitle(
      {required this.startTime,
      required this.endTime,
      required this.text,
      required this.subtitleTokens});

  List<SubtitleToken> getNTokens(List<String> tokens) {
    final tmp = subtitleTokens;
    tmp.sort((a, b) => a.token!.compareTo(b.token!));
    final res = <SubtitleToken>[];
    for (final item in tokens) {
      final foundIndex = _binarySearch(tmp.map((e) => e.token!).toList(), item);
      if (foundIndex != -1) {
        res.add(tmp[foundIndex]);
      }
    }
    return res;
  }

  SubtitleToken getOneToken(String token) {
    final tmp = subtitleTokens;
    tmp.sort((a, b) => a.token!.compareTo(b.token!));
    final foundIndex = _binarySearch(tmp.map((e) => e.token!).toList(), token);
    if (foundIndex != -1) return subtitleTokens[foundIndex];
    return SubtitleToken();
  }

  int _binarySearch(List<String> arr, String x) {
    int l = 0, r = arr.length - 1;
    while (l <= r) {
      final int m = (l + (r - l) / 2).floor();

      final int res = x.compareTo(arr[m]);

      // Check if x is present at mid
      if (res == 0) return m;

      // If x greater, ignore left half
      if (res > 0) {
        l = m + 1;
      } else {
        r = m - 1;
      }
    }

    return -1;
  }

  @override
  List<Object?> get props => [startTime, endTime, text];
}
