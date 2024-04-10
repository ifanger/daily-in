import 'package:daily_in/src/features/check_in/domain/repository/check_in_repository.dart';

class GetDaysAndCheckedInUseCase {
  GetDaysAndCheckedInUseCase(this._checkInRepository);

  final CheckInRepository _checkInRepository;

  static const _kDaysLimit = 180;

  final List<DateTime> days = [];

  Stream<Map<DateTime, bool>> call() {
    final now = DateTime.now();

    for (int i = 0; i < _kDaysLimit; i++) {
      days.add(DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i)));
    }

    return _checkInRepository.stream.map((checkins) {
      final result = <DateTime, bool>{};

      for (final DateTime day in days) {
        result[day] = checkins.any((entity) =>
            entity.date.year == day.year &&
            entity.date.month == day.month &&
            entity.date.day == day.day);
      }

      return result;
    });
  }
}
