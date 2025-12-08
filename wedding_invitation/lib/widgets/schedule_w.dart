import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  final ScheduleStyle style;
  final bool showTitle;
  final String? customTitle;
  final List<ScheduleItem> scheduleItems;

  const ScheduleWidget({
    super.key,
    this.style = ScheduleStyle.elegant,
    this.showTitle = true,
    this.customTitle,
    this.scheduleItems = _defaultScheduleItems,
  });

  static const List<ScheduleItem> _defaultScheduleItems = [
    ScheduleItem(time: '15:00', title: 'Сбор гостей', icon: Icons.group),
    ScheduleItem(
      time: '15:30',
      title: 'Торжественная церемония',
      icon: Icons.favorite_border,
    ),
    ScheduleItem(
      time: '16:00',
      title: 'Начало банкета',
      icon: Icons.celebration,
    ),
    ScheduleItem(
      time: '21:00',
      title: 'Свадебный торт',
      icon: Icons.cake,
      // isHighlighted: true,
    ),
    ScheduleItem(
      time: '22:00',
      title: 'Завершение праздника',
      icon: Icons.nightlife,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case ScheduleStyle.elegant:
        return _buildElegantStyle(context);
      case ScheduleStyle.modern:
        return _buildModernStyle(context);
      case ScheduleStyle.minimal:
        return _buildMinimalStyle(context);
      case ScheduleStyle.timeline:
        return _buildTimelineStyle(context);
    }
  }

  // Стиль 1: Элегантный (по умолчанию)
  Widget _buildElegantStyle(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showTitle) ...[
              // Декоративный разделитель
              Container(
                width: 80,
                height: 2,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.primary,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Заголовок
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: Theme.of(context).colorScheme.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    customTitle ?? 'План дня',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Добро пожаловать на нашу свадьбу!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Карточка с расписанием
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < scheduleItems.length; i++) ...[
                    _buildScheduleItem(context, scheduleItems[i]),
                    if (i < scheduleItems.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 1,
                          width: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),

            // Декоративный элемент внизу
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    size: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.4),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Ждём каждого из вас!',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.star_border,
                    size: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Стиль 2: Современный с градиентами
  Widget _buildModernStyle(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withOpacity(0.95),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showTitle)
              ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ).createShader(bounds);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.schedule_rounded, size: 28, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      customTitle ?? 'Время событий',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

            if (showTitle) const SizedBox(height: 20),

            ...scheduleItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: item.isHighlighted
                            ? Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1)
                            : Theme.of(
                                context,
                              ).colorScheme.surface.withOpacity(0.7),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Иконка
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: item.isHighlighted
                                    ? [
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context).colorScheme.secondary,
                                      ]
                                    : [
                                        Theme.of(
                                          context,
                                        ).colorScheme.surfaceVariant,
                                        Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant
                                            .withOpacity(0.8),
                                      ],
                              ),
                            ),
                            child: Icon(
                              item.icon,
                              size: 20,
                              color: item.isHighlighted
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Время
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item.time,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Описание
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                                if (item.description != null)
                                  Text(
                                    item.description!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withOpacity(0.6),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Стиль 3: Минималистичный
  Widget _buildMinimalStyle(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showTitle)
              Text(
                customTitle ?? 'Расписание',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

            if (showTitle) const SizedBox(height: 16),

            ...scheduleItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.time,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.5),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          if (item.description != null)
                            Text(
                              item.description!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                        ],
                      ),
                    ),

                    Icon(
                      item.icon,
                      size: 20,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.7),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Стиль 4: Таймлайн
  Widget _buildTimelineStyle(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showTitle)
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Text(
                      customTitle ?? 'Таймлайн событий',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

            Stack(
              children: [
                // Вертикальная линия таймлайна
                Positioned(
                  left: 40,
                  top: 30,
                  bottom: 30,
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.6),
                          Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),

                // Элементы таймлайна
                Column(
                  children: [
                    for (int i = 0; i < scheduleItems.length; i++)
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Точка на линии
                            Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: scheduleItems[i].isHighlighted
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.surface,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: scheduleItems[i].isHighlighted
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.primary.withOpacity(0.3)
                                        : Colors.transparent,
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                scheduleItems[i].icon,
                                size: 15,
                                color: scheduleItems[i].isHighlighted
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),

                            // Время
                            SizedBox(
                              width: 60,
                              child: Text(
                                scheduleItems[i].time,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // Описание
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: scheduleItems[i].isHighlighted
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.05)
                                      : Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant
                                            .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline.withOpacity(0.1),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      scheduleItems[i].title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            scheduleItems[i].isHighlighted
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                    ),
                                    if (scheduleItems[i].description != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          scheduleItems[i].description!,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Метод для создания элемента расписания (используется в элегантном стиле)
  Widget _buildScheduleItem(BuildContext context, ScheduleItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: item.isHighlighted
            ? Theme.of(context).colorScheme.primary.withOpacity(0.05)
            : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Иконка
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.isHighlighted
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              item.icon,
              size: 20,
              color: item.isHighlighted
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(width: 16),

          // Контент
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.time,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (item.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      item.description!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Модель для элемента расписания
class ScheduleItem {
  final String time;
  final String title;
  final String? description;
  final IconData icon;
  final bool isHighlighted;

  const ScheduleItem({
    required this.time,
    required this.title,
    this.description,
    required this.icon,
    this.isHighlighted = false,
  });
}

// Стили виджета
enum ScheduleStyle {
  elegant, // Элегантный (по умолчанию)
  modern, // Современный с градиентами
  minimal, // Минималистичный
  timeline, // Таймлайн
}
