import 'dart:async';

import 'package:daily_in/src/features/check_in/shared/hero_animation.dart';
import 'package:daily_in/src/infrastructure/components/scaffold/app_scaffold.dart';
import 'package:daily_in/src/infrastructure/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  static const _kCountDownSeconds = 3;

  late Timer timer;

  int _currentCount = _kCountDownSeconds;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentCount = _currentCount - 1;

      if (_currentCount >= 1) {
        setState(() {});
      } else {
        Navigator.of(context).pop();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: checkInButtonTag,
      child: AppScaffold(
        showAppBar: false,
        hasScroll: false,
        backgroundColor: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.tr.checkInSuccessTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            AspectRatio(
              aspectRatio: 1.5,
              child: SvgPicture.asset(
                'assets/svg/healthy_habit.svg',
              ),
            ),
            Text(
              context.tr.checkInSuccessWarning(_currentCount),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
