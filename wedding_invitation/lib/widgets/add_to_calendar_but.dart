import 'package:flutter/material.dart';

class AddToCalendarButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddToCalendarButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          // Декоративная линия
          Container(
            height: 1,
            width: 150,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            margin: const EdgeInsets.only(bottom: 20),
          ),

          // Кнопка
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.calendar_today, size: 18),
            label: const Text(
              'Добавить в календарь',
              style: TextStyle(fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Подсказка
          Text(
            'Сохраните дату свадьбы',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
