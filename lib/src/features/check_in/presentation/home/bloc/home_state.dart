class HomeState {
  HomeState({
    this.loading = true,
    this.todayAvailable = true,
    this.dates = const {},
    this.selectedPosition,
  });

  final bool loading;
  final bool todayAvailable;
  final Map<DateTime, bool> dates;
  final int? selectedPosition;

  HomeState copyWith({
    bool? loading,
    bool? todayAvailable,
    Map<DateTime, bool>? dates,
    int? selectedPosition,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      todayAvailable: todayAvailable ?? this.todayAvailable,
      dates: dates ?? this.dates,
      selectedPosition: selectedPosition ?? this.selectedPosition,
    );
  }
}
