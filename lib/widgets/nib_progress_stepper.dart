import 'package:flutter/material.dart';

class NibProgressStepper extends StatelessWidget {

  final int currentStep;
  final int unlockedStep;
  final Function(int step) onStepTap;

  const NibProgressStepper({
    super.key,
    required this.currentStep,
    required this.unlockedStep,
    required this.onStepTap,
  });

  static const int totalStep = 7;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(
          'Langkah $currentStep dari $totalStep',

          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [

              for (int i = 1;
                  i <= totalStep;
                  i++) ...[

                _buildStep(i),

                if (i != totalStep)
                  Container(
                    width: 30,
                    height: 3,

                    color:
                        i < currentStep
                            ? Colors.green
                            : Colors.grey.shade300,
                  ),
              ],

              const SizedBox(width: 8),

              Container(

                width: 42,
                height: 42,

                decoration:
                    BoxDecoration(

                  color:
                      unlockedStep ==
                              totalStep
                          ? Colors.amber
                          : Colors.grey.shade300,

                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep(int step) {

    final bool completed =
        step < currentStep;

    final bool active =
        step == currentStep;

    final bool locked =
        step > unlockedStep;

    return GestureDetector(

      onTap: locked
          ? null
          : () {
              onStepTap(step);
            },

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 200,
        ),

        width: active ? 46 : 40,
        height: active ? 46 : 40,

        decoration: BoxDecoration(

          color: locked
              ? Colors.grey.shade300
              : completed
                  ? Colors.green
                  : active
                      ? const Color(
                          0xFF2D9CDB,
                        )
                      : Colors.white,

          shape: BoxShape.circle,

          border:
              active || completed || locked
                  ? null
                  : Border.all(
                      color: Colors.grey.shade400,
                    ),
        ),

        child: Center(

          child: locked

              ? const Icon(
                  Icons.lock,
                  size: 18,
                  color: Colors.grey,
                )

              : completed

                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                    )

                  : Text(

                      '$step',

                      style: TextStyle(
                        color: active
                            ? Colors.white
                            : Colors.black,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
        ),
      ),
    );
  }
}