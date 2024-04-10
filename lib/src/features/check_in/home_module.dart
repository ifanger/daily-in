import 'package:daily_in/src/features/check_in/data/data_source/check_in_firebase_data_source.dart';
import 'package:daily_in/src/features/check_in/domain/repository/check_in_repository.dart';
import 'package:daily_in/src/features/check_in/domain/use_case/get_days_and_checked_in_use_case.dart';
import 'package:daily_in/src/features/check_in/presentation/home/bloc/home_bloc.dart';
import 'package:daily_in/src/features/check_in/presentation/home/home_page.dart';
import 'package:daily_in/src/features/check_in/presentation/result/check_in_page.dart';
import 'package:daily_in/src/infrastructure/core/di/injection.dart';
import 'package:daily_in/src/infrastructure/core/module/app_module.dart';
import 'package:flutter/material.dart';

class HomeModule extends AppModule {
  static const String routeHome = '/home';
  static const String routeCheckIn = '/check-in';

  @override
  void dependencies() {
    Injection.factory<CheckInFirebaseDataSource>(
      () => CheckInFirebaseDataSource(),
    );

    Injection.factory<CheckInRepository>(
      () => CheckInFirebaseRepository(Injection.get()),
    );

    Injection.factory(() => GetDaysAndCheckedInUseCase(Injection.get()));

    Injection.factory<HomeBloc>(() => HomeBloc(
          Injection.get(),
          Injection.get(),
        ));
  }

  @override
  Map<String, Widget Function(BuildContext context)> routes() => {
        routeHome: (context) => const HomePage(),
        routeCheckIn: (context) => const CheckInPage(),
      };
}
