// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:wedding_invitation/music_player.dart';
import 'package:wedding_invitation/widgets/calendar.dart' as calendar_widget;
import 'package:wedding_invitation/widgets/location.dart';
import 'package:wedding_invitation/widgets/main_header.dart';
import 'package:wedding_invitation/widgets/schedule.dart' hide ScheduleItem;
import 'package:wedding_invitation/widgets/table_arrangement.dart';
import 'types.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          seedColor: const Color(0xFF91B287),
          primary: const Color(0xFF4C6444),
          onPrimary: Colors.white,
          secondary: const Color(0xFF765B50),
          onSecondary: Colors.white,
          tertiary: const Color(0xFFBA9B8E),
          surface: const Color(0xFFF8F4F0),
          background: const Color(0xFFF5F0EB),
          error: const Color(0xFFD32F2F),
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
    this.color = const Color(0xFF4C6444),
  });

  @override
  void paint(Canvas canvas, Size size) {
    const startY = 70.0;
    const fontSize = 16.0;

    final text =
        'save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date ✦ save the date';

    final textStyle = TextStyle(
      fontFamily: 'Gnocchi',
      color: color.withOpacity(0.2),
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      letterSpacing: 10,
    );

    for (int i = 0; i < text.length; i++) {
      final letter = text[i];
      final textSpan = TextSpan(text: letter, style: textStyle);

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final baseX = i * (fontSize * 0.8);
      final baseY = startY;

      final letterPhase = phase + i * 0.25;
      final mainWave = sin(letterPhase) * 8;
      final secondaryWave = sin(letterPhase * 1.7 + 0.5) * 4;
      final rippleWave = sin(letterPhase * 2.3 + 1.2) * 2;
      final verticalOffset = mainWave + secondaryWave + rippleWave;
      final x = baseX - phase * 15;
      final y = baseY + verticalOffset;

      final scale = 1.0 + sin(letterPhase * 0.8) * 0.05;

      canvas.save();
      canvas.translate(x, y);
      canvas.scale(scale);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();

      if (x + fontSize < 0) {
        final newX = size.width + (x % size.width);
        canvas.save();
        canvas.translate(newX, y);
        canvas.scale(scale);
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      }
    }

    for (int i = 0; i < text.length; i++) {
      final letter = text[i];
      final textSpan = TextSpan(
        text: letter,
        style: textStyle.copyWith(color: color.withOpacity(0.1)),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final baseX = i * (fontSize * 0.8) + fontSize * 0.4;
      final baseY = startY + 50;

      final letterPhase = phase + i * 0.3 + 1.0;
      final mainWave = sin(letterPhase * 0.9) * 6;
      final secondaryWave = sin(letterPhase * 1.4 + 0.8) * 3;
      final verticalOffset = mainWave + secondaryWave;

      final x = baseX - phase * 12;
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
  // final MusicPlayer _musicPlayer = MusicPlayer();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    // Запуск музыки с учетом платформы
    // _startMusicBasedOnPlatform();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // _musicPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/flowers1.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.4),
                  ],
                  stops: [0.0, 0.3, 0.6, 1.0],
                ),
              ),
            ),
          ),
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
                    color: Color(0xFF4C6444),
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AnimatedHeaderWidget(),
                _buildCalendarHeart(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width < 360
                        ? 20
                        : 16,
                  ),
                  child: ScheduleWidget(
                    style: ScheduleStyle.elegant,
                    customTitle: 'Расписание свадебного дня',
                  ),
                ),
                LocationWidget(style: LocationStyle.elegant),
                TableArrangementWidget(),
                _buildFooter(),
              ],
            ),
          ),

          // // Кнопка управления музыкой (видна только если музыка доступна)
          // if (_musicPlayer.canAutoPlay)
          //   Positioned(top: 160, right: 20, child: _buildMusicControlButton()),
        ],
      ),
    );
  }

  Widget _buildCalendarHeart() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width < 360 ? 20 : 14,
          ),
          child: calendar_widget.CalendarWidget(
            animationController: _animationController,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 50),
      child: Text(
        'С любовью,\nРоман и Рузанна',
        style: TextStyle(
          color: const Color(0xFF4C6444),
          fontSize: 18,
          height: 1.4,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Future<void> _startMusicBasedOnPlatform() async {
  //   // Для web - не запускаем автоматически
  //   if (kIsWeb) {
  //     print('🌐 Web версия - автозапуск музыки отключен');
  //     return;
  //   }

  //   // Для Android и iOS - запускаем автоматически
  //   print('📱 Мобильная версия - запускаем музыку автоматически');

  //   // Небольшая задержка для инициализации
  //   await Future.delayed(const Duration(milliseconds: 500));

  //   try {
  //     await _musicPlayer.initialize();
  //     await _musicPlayer.playWithDelay();
  //   } catch (e) {
  //     print('⚠️ Не удалось запустить музыку: $e');
  //   }
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // Управление музыкой при сворачивании/разворачивании приложения
  //   if (state == AppLifecycleState.paused) {
  //     // При сворачивании приложения
  //     if (_musicPlayer.isPlaying && !kIsWeb) {
  //       _musicPlayer.pause();
  //     }
  //   } else if (state == AppLifecycleState.resumed) {
  //     // При разворачивании приложения
  //     if (!_musicPlayer.isPlaying && !kIsWeb) {
  //       _musicPlayer.play();
  //     }
  //   }
  // }

  // Widget _buildMusicControlButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       if (_musicPlayer.isPlaying) {
  //         _musicPlayer.pause();
  //       } else {
  //         _musicPlayer.play();
  //       }
  //       setState(() {});
  //     },
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 300),
  //       padding: const EdgeInsets.all(12),
  //       decoration: BoxDecoration(
  //         color: Colors.white.withOpacity(_musicPlayer.isPlaying ? 0.95 : 0.85),
  //         borderRadius: BorderRadius.circular(30),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.15),
  //             blurRadius: 10,
  //             offset: const Offset(0, 4),
  //           ),
  //         ],
  //         border: Border.all(
  //           color: const Color(0xFF4C6444).withOpacity(0.3),
  //           width: 1,
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             _musicPlayer.isPlaying ? Icons.music_note : Icons.music_off,
  //             color: const Color(0xFF4C6444),
  //             size: 22,
  //           ),
  //           if (_musicPlayer.isPlaying) ...[
  //             const SizedBox(width: 8),
  //             Text(
  //               'Музыка',
  //               style: TextStyle(
  //                 color: const Color(0xFF4C6444),
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ],
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
