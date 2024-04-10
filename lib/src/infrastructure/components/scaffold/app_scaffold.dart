import 'package:daily_in/src/infrastructure/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.child,
    this.backgroundColor,
    this.showAppBar = true,
    this.hasScroll = true,
  });

  final Widget? child;
  final Color? backgroundColor;
  final bool showAppBar;
  final bool hasScroll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: showAppBar
          ? AppBar(
              title: Text(context.tr.title),
            )
          : null,
      body: SafeArea(
        child: hasScroll
            ? SingleChildScrollView(
                child: child,
              )
            : child ?? const SizedBox.shrink(),
      ),
    );
  }
}
