import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class CalendarService {
  static Future<void> addToDeviceCalendar(BuildContext context) async {
    // Создаем дату свадьбы
    final weddingDate = DateTime(2026, 1, 10, 15, 0); // 10 января 2026, 15:00
    final endDate = weddingDate.add(const Duration(hours: 8)); // 8 часов празднования

    // Создаем событие для календаря
    final Event event = Event(
      title: 'Свадьба Романа и Рузанны',
      description: 'Свадебная церемония и празднование. Ресторан «Метрополь Холл». ',
      location: 'Ресторан «Метрополь Холл», Видное',
      startDate: weddingDate,
      endDate: endDate,
      allDay: false,
      iosParams: const IOSParams(
        reminder: Duration(days: 7), // Напоминание за неделю
        url: 'wedding://invitation', // Кастомная схема URL
      ),
      androidParams: const AndroidParams(
        emailInvites: [], // Можно добавить emails для приглашений
      ),
    );

    try {
      // Добавляем событие в календарь устройства
      await Add2Calendar.addEvent2Cal(event);
      
      // Показываем успешное сообщение
      _showSuccessMessage(context);
    } catch (e) {
      // Если возникла ошибка, показываем инструкцию
      _showErrorInstructions(context, e.toString());
    }
  }

  static void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Свадьба добавлена в календарь! Напоминание установлено за неделю.',
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static void _showErrorInstructions(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.amber),
              SizedBox(width: 10),
              Text('Не удалось добавить в календарь'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ошибка: $error'),
              const SizedBox(height: 15),
              const Text('Пожалуйста, добавьте событие вручную:'),
              const SizedBox(height: 10),
              _buildManualStep(1, 'Откройте приложение "Календарь"'),
              _buildManualStep(2, 'Нажмите "+" для нового события'),
              _buildManualStep(3, 'Заполните информацию:'),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• 10 января 2026, 15:00'),
                    Text('• Свадьба Романа и Рузанны'),
                    Text('• Ресторан «Метрополь Холл»'),
                    Text('• Установите напоминание за неделю'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildManualStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  // Опционально: предварительный диалог подтверждения
  static Future<void> showConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Добавить в календарь'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Добавить свадьбу в календарь устройства?'),
              SizedBox(height: 10),
              Text('📅 10 января 2026'),
              Text('⏰ 15:00'),
              Text('💍 Свадьба Романа и Рузанны'),
              Text('📍 Ресторан «Метрополь Холл»'),
              SizedBox(height: 10),
              Text('Будет установлено напоминание за неделю до события.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await addToDeviceCalendar(context);
    }
  }
}