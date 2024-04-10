import 'package:daily_in/src/features/check_in/domain/entity/check_in_entity.dart';
import 'package:daily_in/src/features/check_in/domain/repository/check_in_repository.dart';
import 'package:daily_in/src/features/check_in/domain/use_case/get_days_and_checked_in_use_case.dart';
import 'package:daily_in/src/features/check_in/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc(
    this._getDaysAndCheckedInUseCase,
    this._checkInRepository,
  ) : super(HomeState());

  final GetDaysAndCheckedInUseCase _getDaysAndCheckedInUseCase;
  final CheckInRepository _checkInRepository;

  Future<void> load() async {
    _getDaysAndCheckedInUseCase().listen((checkIns) {
      emit(HomeState(
        loading: false,
        todayAvailable: !checkIns.values.first,
        selectedPosition: 0,
        dates: checkIns,
      ));
    });
  }

  void setSelected(int? position) {
    bool todayAvailable = false;

    if (position != null &&
        position >= 0 &&
        position < state.dates.values.length) {
      todayAvailable = !state.dates.values.elementAt(position);
    }

    emit(state.copyWith(
      selectedPosition: position,
      todayAvailable: todayAvailable,
    ));
  }

  void create() {
    DateTime selectedDate = DateTime.now();
    final position = state.selectedPosition;

    if (position != null &&
        position >= 0 &&
        position < state.dates.values.length) {
      selectedDate = state.dates.keys.elementAt(position);
    }

    _checkInRepository.create(CheckInEntity(
      id: '',
      date: selectedDate,
      completed: true,
    ));
  }
}
