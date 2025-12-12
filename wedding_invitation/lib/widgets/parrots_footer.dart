import 'package:flutter/material.dart';

class ParrotsFooterWidget extends StatelessWidget {
  const ParrotsFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            margin: const EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF91B287).withOpacity(0.5),
                  const Color(0xFF765B50).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
