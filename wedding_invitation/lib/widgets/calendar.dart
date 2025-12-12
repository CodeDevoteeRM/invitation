import 'dart:math';
import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  final AnimationController animationController;

  const CalendarWidget({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Январь 2026',
          style: TextStyle(
            color: colorScheme.secondary,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
            fontFamily: 'Gnocchi',
          ),
        ),
        const SizedBox(height: 20),

        Container(
          width: 340,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.15), // #4C6444
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.1), // #4C6444
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'].map((day) {
                  return Text(
                    day,
                    style: TextStyle(
                      color: colorScheme.primary.withOpacity(0.7), // #4C6444
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: 35,
                itemBuilder: (context, index) {
                  final dayNumber = index - 2;

                  if (dayNumber < 1 || dayNumber > 31) {
                    return const SizedBox.shrink();
                  }

                  final isWeddingDay = dayNumber == 11;

                  return isWeddingDay
                      ? _buildWeddingDayCell(context, dayNumber)
                      : _buildRegularDayCell(context, dayNumber);
                },
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withOpacity(0.1), // #BA9B8E
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.tertiary.withOpacity(0.2), // #BA9B8E
                  ),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 8, // Расстояние между строками если будет перенос
                  children: [
                    // AnimatedBuilder(
                    //   animation: animationController,
                    //   builder: (context, child) {
                    //     final beatCycle = animationController.value % 0.8;
                    //     double iconSize = 16;

                    //     if (beatCycle < 0.15) {
                    //       iconSize = 16 + sin(beatCycle * 40) * 4;
                    //     } else if (beatCycle >= 0.2 && beatCycle < 0.35) {
                    //       iconSize = 16 + sin((beatCycle - 0.2) * 40) * 3;
                    //     }

                    //     return Icon(
                    //       Icons.favorite,
                    //       color: colorScheme.secondary.withOpacity(0.8),
                    //       size: iconSize,
                    //     );
                    //   },
                    // ),
                    Text(
                      '11.01.2026 - наша свадьба',
                      style: TextStyle(
                        color: colorScheme.primary, // #4C6444
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeddingDayCell(BuildContext context, int day) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              final time = animationController.value;
              final beatCycle = time % 0.8;

              double pulse = 1.0;
              double opacity = 0.35;

              // Двойной пульс с изменением прозрачности
              if (beatCycle < 0.15) {
                pulse = 1.0 + sin(beatCycle * 40) * 0.1; // Меньшая пульсация
                opacity =
                    0.25 +
                    sin(beatCycle * 40) *
                        0.15; // Легкое увеличение прозрачности
              } else if (beatCycle >= 0.2 && beatCycle < 0.35) {
                pulse = 1.0 + sin((beatCycle - 0.2) * 40) * 0.08;
              }

              return Transform.translate(
                offset: const Offset(-4, -2),
                child: Transform.scale(
                  scale: pulse,
                  child: Icon(
                    Icons.favorite,
                    color: colorScheme.secondary.withOpacity(opacity),
                    size: 38,
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: colorScheme.primary.withOpacity(0.85),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gnocchi',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegularDayCell(BuildContext context, int day) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: day >= 1 && day <= 31
            ? colorScheme.primary.withOpacity(0.05) // #4C6444
            : Colors.transparent,
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
            color: colorScheme.primary.withOpacity(0.6), // #4C6444
            fontSize: 15,
            fontWeight: FontWeight.w400,
            fontFamily: 'Gnocchi',
          ),
        ),
      ),
    );
  }
}
