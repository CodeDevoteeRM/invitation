import 'dart:math';

import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  final AnimationController animationController;
  
  const CalendarWidget({
    super.key,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Январь 2026',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 15),

        Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // Дни недели
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'].map((day) {
                  return Text(
                    day,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 15),

              // Сетка дней
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemCount: 35,
                itemBuilder: (context, index) {
                  final dayNumber = index - 2;

                  if (dayNumber < 1 || dayNumber > 31) {
                    return const SizedBox.shrink();
                  }

                  final isWeddingDay = dayNumber == 10;

                  return isWeddingDay
                      ? _buildWeddingDayCell(context, dayNumber)
                      : _buildRegularDayCell(context, dayNumber);
                },
              ),

              const SizedBox(height: 20),

              // Подпись
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      final beatCycle = animationController.value % 0.8;
                      double iconSize = 16;

                      if (beatCycle < 0.15) {
                        iconSize = 16 + sin(beatCycle * 40) * 4;
                      } else if (beatCycle >= 0.2 && beatCycle < 0.35) {
                        iconSize = 16 + sin((beatCycle - 0.2) * 40) * 3;
                      }

                      return Icon(
                        Icons.favorite,
                        color: Theme.of(context).colorScheme.secondary,
                        size: iconSize,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '10 января - наша свадьба',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Ячейка для даты свадьбы
  Widget _buildWeddingDayCell(BuildContext context, int day) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Большое сердечко (выходит за границы ячейки)
          Positioned(
            left: -10,
            top: -8,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                final time = animationController.value;
                final beatCycle = time % 0.8;

                double pulse = 1.0;

                if (beatCycle < 0.15) {
                  pulse = 1.0 + sin(beatCycle * 40) * 0.15;
                } else if (beatCycle >= 0.2 && beatCycle < 0.35) {
                  pulse = 1.0 + sin((beatCycle - 0.2) * 40) * 0.12;
                }

                return Transform.scale(
                  scale: pulse,
                  child: Opacity(
                    opacity: 0.25,
                    child: Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 52,
                    ),
                  ),
                );
              },
            ),
          ),

          // Число (правее, в центре ячейки)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.8),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Обычная ячейка
  Widget _buildRegularDayCell(BuildContext context, int day) {
    return Container(
      width: 32,
      height: 32,
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}