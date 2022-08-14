class TimerService {
  Stream<DateTime> timeStream = Stream.periodic(
    const Duration(seconds: 30),
    (_) {
      return DateTime.now();
    },
  );
}

String smartDiff({required DateTime now, required DateTime old}) {
  final difference = now.difference(old);

  final intervals = {
    'day': difference.inDays,
    'hour': difference.inHours,
    'minute': difference.inMinutes,
    'second': difference.inSeconds,
  };

  for (var interval in intervals.entries) {
    if (interval.value != 0) {
      final plural = (interval.value != 1) ? 's' : '';
      return '${interval.value} ${interval.key}$plural ago';
    }
  }
  return 'Just now';
}
