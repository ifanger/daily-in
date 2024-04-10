import 'package:daily_in/src/features/check_in/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily In',
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        ...HomeModule().routes(),
      },
      initialRoute: HomeModule.routeHome,
    );
  }
}
