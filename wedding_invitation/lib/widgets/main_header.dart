import 'package:flutter/material.dart';

class AnimatedHeaderWidget extends StatefulWidget {
  const AnimatedHeaderWidget({super.key});

  @override
  State<AnimatedHeaderWidget> createState() => _AnimatedHeaderWidgetState();
}

class _AnimatedHeaderWidgetState extends State<AnimatedHeaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4C6444).withOpacity(0.08), 
                  const Color(0xFF91B287).withOpacity(0.12),
                  const Color(0xFF765B50).withOpacity(0.08), 
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Роман & Рузанна',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF4C6444),
                      fontWeight: FontWeight.w300,
                      fontSize: 44,
                      letterSpacing: 2.5,
                      fontFamily: 'Gnocchi',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Создаём нашу историю любви',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF4C6444).withOpacity(0.7),
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          ScaleTransition(scale: _scaleAnimation, child: _buildPhoto(context)),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPhoto(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(140),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C6444).withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF4C6444).withOpacity(0.15),
          width: 3,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/rr.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF4C6444), const Color(0xFF765B50)],
                ),
              ),
              child: Center(
                child: Icon(Icons.favorite, size: 80, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
