import 'package:flutter/material.dart';

import '../../../widgets/custom_topbar.dart';
import '../../../widgets/nib_progress_stepper.dart';

import '../../../models/simulation/simulation_data.dart';

import 'steps/step_1_business_category_screen.dart';

class NibStepperScreen
    extends StatefulWidget {

  const NibStepperScreen({
    super.key,
  });

  @override
  State<NibStepperScreen>
      createState() =>
          _NibStepperScreenState();
}

class _NibStepperScreenState
    extends State<NibStepperScreen> {

  final SimulationData
      simulationData =
          SimulationData();

  int currentStep = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: const CustomTopBar(
        showBackButton: true,
      ),

      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(18),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // STEPPER
              NibProgressStepper(
                currentStep: currentStep,
                unlockedStep: 1,
              ),

              const SizedBox(height: 24),

              const Text(
                'Tambah Bidang Usaha',

                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Pilih kategori usaha yang paling sesuai dengan bisnis Anda.',

                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color:
                      Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child:
                    Step1BusinessCategoryScreen(

                  onSelected: (value) {

                    simulationData
                        .businessCategory =
                        value;
                  },
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 6,
                ),

                child: SizedBox(
                  width:
                      double.infinity,

                  height: 55,

                  child: ElevatedButton(

                    onPressed: () {

                      if (simulationData
                              .businessCategory ==
                          null) {

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(

                          const SnackBar(
                            content: Text(
                              'Pilih kategori usaha terlebih dahulu',
                            ),
                          ),
                        );

                        return;
                      }

                      debugPrint(
                        simulationData
                            .businessCategory,
                      );

                      // STEP 2 KBLI
                    },

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF2D9CDB,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          14,
                        ),
                      ),
                    ),

                    child: const Text(
                      'Lanjut',

                      style: TextStyle(
                        color:
                            Colors.white,

                        fontWeight:
                            FontWeight.bold,

                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}