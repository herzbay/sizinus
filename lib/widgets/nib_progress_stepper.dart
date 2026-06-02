import 'package:flutter/material.dart';

class NibProgressStepper extends StatelessWidget {

  final int currentStep;
  final int unlockedStep;

  const NibProgressStepper({
    super.key,
    required this.currentStep,
    required this.unlockedStep,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Row(
            children: [

              for (int i = 1; i <= 9; i++) ...[

                _buildStep(i),

                if (i != 9)
                  Container(
                    width: 30,
                    height: 3,

                    color: i < currentStep
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
              ],

              const SizedBox(width: 8),

              Container(
                width: 40,
                height: 40,

                decoration: BoxDecoration(
                  color: currentStep == 9
                      ? Colors.amber
                      : Colors.grey.shade300,

                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Langkah $currentStep dari 9',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildStep(int step) {

    bool completed = step < currentStep;

    bool active = step == currentStep;

    bool locked = step > unlockedStep;

    if (locked) {
      return Container(
        width: 40,
        height: 40,

        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),

        child: const Icon(
          Icons.lock,
          size: 18,
          color: Colors.grey,
        ),
      );
    }

    if (completed) {
      return Container(
        width: 40,
        height: 40,

        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),

        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    }

    if (active) {
      return Container(
        width: 44,
        height: 44,

        decoration: const BoxDecoration(
          color: Color(0xFF2D9CDB),
          shape: BoxShape.circle,
        ),

        child: Center(
          child: Text(
            '$step',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 40,
      height: 40,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),

      child: Center(
        child: Text(
          '$step',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}