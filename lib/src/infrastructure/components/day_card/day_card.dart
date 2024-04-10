import 'package:daily_in/src/infrastructure/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayCard extends StatelessWidget {
  const DayCard({
    super.key,
    required this.date,
    this.color,
    this.elevation,
    this.onTap,
  });

  final DateTime date;
  final Color? color;
  final double? elevation;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                DateFormat.d(context.locale).format(date),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              Text(DateFormat.E(context.locale).format(date)),
            ],
          ),
        ),
      ),
    );
  }
}
