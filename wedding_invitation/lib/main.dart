import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wedding_invitation/utils/calendar_u.dart';
import 'package:wedding_invitation/widgets/add_to_calendar_but.dart'
    as calendar_button;
import 'package:wedding_invitation/widgets/calendar_w.dart' as calendar_widget;
import 'package:wedding_invitation/widgets/schedule_w.dart';
import 'types.dart';

void main() {
  runApp(const WeddingApp());
}

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Свадьба Романа и Рузанны',
      theme: ThemeData(
        fontFamily: 'Gnocchi',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8F4F8),
          primary: const Color(0xFF2C3E50),
          secondary: const Color(0xFFC19A6B),
        ),
        useMaterial3: true,
      ),
      home: const WeddingInvitation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SaveDateWavePainter extends CustomPainter {
  final double phase;
  final Color color;

  SaveDateWavePainter({
    required this.phase,
    this.color = const Color(0xFF2C3E50),
  });

  @override
  void paint(Canvas canvas, Size size) {
    const startY = 120.0;
    const fontSize = 16.0;

    final text =
        'save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date';

    // Используем шрифт Gnocchi
    final textStyle = TextStyle(
      fontFamily: 'Gnocchi',
      color: color.withOpacity(0.25),
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      letterSpacing: 10,
    );

    // Разбиваем текст на отдельные буквы для анимации
    for (int i = 0; i < text.length; i++) {
      final letter = text[i];
      final textSpan = TextSpan(text: letter, style: textStyle);

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Вычисляем базовую позицию буквы
      final baseX = i * (fontSize * 0.8);
      final baseY = startY;

      // Создаем волнообразное движение для каждой буквы
      final letterPhase = phase + i * 0.25; // Меньший шаг для плавности

      // Основная волна с УВЕЛИЧЕННОЙ амплитудой
      final mainWave = sin(letterPhase) * 8;

      // Вторичная волна для более интересного движения
      final secondaryWave = sin(letterPhase * 1.7 + 0.5) * 4;

      // Третичная волна для мелкой ряби
      final rippleWave = sin(letterPhase * 2.3 + 1.2) * 2;

      // Вертикальное смещение (вверх-вниз)
      final verticalOffset = mainWave + secondaryWave + rippleWave;

      // Горизонтальное движение - очень медленное
      final x = baseX - phase * 15;
      final y = baseY + verticalOffset;

      // Добавляем легкое масштабирование для эффекта "дыхания"
      final scale = 1.0 + sin(letterPhase * 0.8) * 0.05;

      canvas.save();
      canvas.translate(x, y);
      canvas.scale(scale); // Применяем масштабирование
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();

      // Если текст ушел за левый край, начинаем его снова справа
      if (x + fontSize < 0) {
        final newX = size.width + (x % size.width);
        canvas.save();
        canvas.translate(newX, y);
        canvas.scale(scale);
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      }
    }

    // Добавляем вторую линию ниже для большей плотности
    for (int i = 0; i < text.length; i++) {
      final letter = text[i];
      final textSpan = TextSpan(
        text: letter,
        style: textStyle.copyWith(color: color.withOpacity(0.15)),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Вторая линия ниже первой
      final baseX = i * (fontSize * 0.8) + fontSize * 0.4;
      final baseY = startY + 50;

      final letterPhase = phase + i * 0.3 + 1.0; // Сдвиг фазы

      // Волна для второй линии
      final mainWave = sin(letterPhase * 0.9) * 6;
      final secondaryWave = sin(letterPhase * 1.4 + 0.8) * 3;
      final verticalOffset = mainWave + secondaryWave;

      final x = baseX - phase * 12; // Другая скорость
      final y = baseY + verticalOffset;

      canvas.save();
      canvas.translate(x, y);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();

      if (x + fontSize < 0) {
        final newX = size.width + (x % size.width);
        canvas.save();
        canvas.translate(newX, y);
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant SaveDateWavePainter oldDelegate) {
    return oldDelegate.phase != phase;
  }
}

class WeddingInvitation extends StatefulWidget {
  const WeddingInvitation({super.key});

  @override
  State<WeddingInvitation> createState() => _WeddingInvitationState();
}

class _WeddingInvitationState extends State<WeddingInvitation>
    with SingleTickerProviderStateMixin {
  final List<ScheduleItem> _scheduleItems = [
    ScheduleItem(time: '15:00', event: 'Сбор гостей', isLiked: false),
    ScheduleItem(
      time: '16:00',
      event: 'Церемония бракосочетания',
      isLiked: false,
    ),
    ScheduleItem(time: '17:00', event: 'Фуршет и фотосессия', isLiked: false),
    ScheduleItem(time: '18:30', event: 'Праздничный ужин', isLiked: false),
    ScheduleItem(time: '20:00', event: 'Первый танец молодых', isLiked: false),
    ScheduleItem(time: '21:00', event: 'Торт и поздравления', isLiked: false),
    ScheduleItem(time: '22:00', event: 'Танцы до утра', isLiked: false),
  ];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F4F8), Color(0xFFB8D8E8)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 150,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SaveDateWavePainter(
                      phase: _animationController.value * 2 * pi,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            // Основной контент
            ListView(
              children: [
                _buildHeader(),
                _buildMainCard(),
                _buildDetails(),
                _buildFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: Column(
        children: [
          Text(
            'Приглашение на свадьбу',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w300,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 1,
            width: 80,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Роман & Рузанна',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w400,
              fontSize: 42,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(
              'assets/frame.png',
              height: 180,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Роман и Рузанна',
                      style: TextStyle(fontSize: 18, color: Color(0xFF2C3E50)),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          _buildCalendarHeart(),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ScheduleWidget()],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String time, String event, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Время
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          // Линия и точка (упрощенно)
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 1,
                  height: 24,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Описание
          Expanded(
            child: Text(
              event,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoPlaceholder(String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_camera,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              size: 40,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeart() {
    return Column(
      children: [
        calendar_widget.CalendarWidget(
          animationController: _animationController,
        ),
        // calendar_button.AddToCalendarButton(
        //   onPressed: () {
        //     CalendarService.showConfirmationDialog(context);
        //   },
        // ),
      ],
    );
  }

  Widget _buildScheduleItem(ScheduleItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                item.time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),
              ),
            ),
            Expanded(
              child: Text(
                item.event,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _scheduleItems[index] = item.copyWith(isLiked: !item.isLiked);
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Icon(
                  item.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: item.isLiked
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem(
            Icons.location_on,
            'Место',
            'Ресторан «Метрополь Холл»\nВидное',
          ),
          const SizedBox(height: 25),
          _buildDetailItem(
            Icons.phone,
            'Контакты',
            '+7 XXX XXX-XX-XX\nroma_ruzanna@wedding.ru',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.secondary, size: 24),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 60, left: 20, right: 20),
      child: Column(
        children: [
          Text(
            'С любовью,\nРоман и Рузанна',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              fontSize: 14,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    final likedEvents = _scheduleItems.where((item) => item.isLiked).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Спасибо за подтверждение!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                likedEvents.isEmpty
                    ? Text(
                        'Ждем вас на нашей свадьбе!',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Мы заметили, что вы особенно ждете:',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...likedEvents
                              .map(
                                (event) => Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${event.time} - ${event.event}',
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Закрыть',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ScheduleItem {
  final String time;
  final String event;
  final bool isLiked;

  ScheduleItem({
    required this.time,
    required this.event,
    required this.isLiked,
  });

  ScheduleItem copyWith({String? time, String? event, bool? isLiked}) {
    return ScheduleItem(
      time: time ?? this.time,
      event: event ?? this.event,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
