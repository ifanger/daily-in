import 'package:daily_in/src/features/check_in/home_module.dart';
import 'package:daily_in/src/features/check_in/presentation/home/bloc/home_bloc.dart';
import 'package:daily_in/src/features/check_in/presentation/home/bloc/home_state.dart';
import 'package:daily_in/src/features/check_in/shared/hero_animation.dart';
import 'package:daily_in/src/infrastructure/components/day_card/day_card.dart';
import 'package:daily_in/src/infrastructure/components/scaffold/app_scaffold.dart';
import 'package:daily_in/src/infrastructure/core/di/injection.dart';
import 'package:daily_in/src/infrastructure/core/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injection.get<HomeBloc>()..load(),
      child: AppScaffold(
        hasScroll: false,
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 96.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: state.dates.entries.length,
                  reverse: true,
                  itemBuilder: (context, position) {
                    final date = state.dates.entries.elementAt(position);

                    return DayCard(
                      date: date.key,
                      elevation:
                          position == state.selectedPosition ? 4.0 : null,
                      color: date.value ? Colors.green.shade100 : null,
                      onTap: () {
                        int newPosition = -1;

                        if (state.selectedPosition != position) {
                          newPosition = position;
                        }

                        context.read<HomeBloc>().setSelected(newPosition);
                      },
                    );
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.todayAvailable
                        ? context.tr.homeCheckInCTA
                        : context.tr.homeCheckInDisabled,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _PulsingCheckInButton(state.todayAvailable),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _PulsingCheckInButton extends StatefulWidget {
  const _PulsingCheckInButton(this.enabled);

  final bool enabled;

  @override
  State<_PulsingCheckInButton> createState() => _PulsingCheckInButtonState();
}

class _PulsingCheckInButtonState extends State<_PulsingCheckInButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3000),
  )..repeat();

  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 0.6,
    end: 1.4,
  ).animate(_controller);

  late final Animation<double> _fadeAnimation = Tween<double>(
    begin: 1,
    end: 0.0,
  ).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Visibility(
            visible: widget.enabled,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade300,
                  ),
                ),
              ),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1.3,
          child: Hero(
            tag: checkInButtonTag,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey.shade300;
                  }

                  return Colors.green;
                }),
                shape: const MaterialStatePropertyAll(CircleBorder()),
              ),
              onPressed: widget.enabled
                  ? () {
                      context.read<HomeBloc>().create();
                      Navigator.of(context).pushNamed(HomeModule.routeCheckIn);
                    }
                  : null,
              child: const SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
