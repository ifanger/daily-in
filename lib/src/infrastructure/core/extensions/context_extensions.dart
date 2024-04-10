import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension InternacionalizationExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;

  String? get locale => Localizations.maybeLocaleOf(this)?.toLanguageTag();
}
