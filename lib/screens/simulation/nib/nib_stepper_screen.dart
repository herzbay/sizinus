import 'package:flutter/material.dart';

import '../../../widgets/custom_topbar.dart';
import '../../../widgets/nib_progress_stepper.dart';

import '../../../models/simulation/simulation_data.dart';

import 'steps/step_1_business_category_screen.dart';
import 'steps/step_2_kbli_screen.dart';

class NibStepperScreen extends StatefulWidget {
  const NibStepperScreen({
    super.key,
  });

  @override
  State<NibStepperScreen> createState() =>
      _NibStepperScreenState();
}

class _NibStepperScreenState
    extends State<NibStepperScreen> {

  final SimulationData simulationData =
      SimulationData();

  int currentStep = 1;

  int unlockedStep = 1;

  String getStepTitle() {
    switch (currentStep) {

      case 1:
        return 'Tambah Bidang Usaha';

      case 2:
        return 'Pengembangan KBLI';

      default:
        return 'Simulasi NIB';
    }
  }

  String getStepSubtitle() {
    switch (currentStep) {

      case 1:
        return 'Pilih kategori usaha yang paling sesuai dengan bisnis Anda.';

      case 2:
        return 'Lengkapi informasi KBLI sesuai bidang usaha yang dipilih.';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: const CustomTopBar(
        showBackButton: true,
      ),

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // PROGRESS STEPPER
              NibProgressStepper(
                currentStep: currentStep,
                unlockedStep: unlockedStep,
              ),

              const SizedBox(height: 24),

              // TITLE
              Text(
                getStepTitle(),

                style: const TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                getStepSubtitle(),

                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color:
                      Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 20),

              // STEP CONTENT
              Expanded(

                child: currentStep == 1

                    ? Step1BusinessCategoryScreen(

                        onSelected: (value) {

                          simulationData
                              .businessCategory =
                              value;
                        },
                      )

                    : Step2KbliScreen(

                        category:
                            simulationData
                                .businessCategory!,

                        onChanged: ({
                          required businessType,
                          required kbli,
                          required businessScope,
                        }) {

                          simulationData
                              .businessType =
                              businessType;

                          simulationData
                              .kbli =
                              kbli;

                          simulationData
                              .businessScope =
                              businessScope;
                        },
                      ),
              ),

              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 6,
                ),

                child: SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(

                    onPressed: () {

                      // STEP 1
                      if (currentStep == 1) {

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

                        setState(() {

                          currentStep = 2;

                          unlockedStep = 2;
                        });

                        return;
                      }

                      // STEP 2
                      if (currentStep == 2) {

                        if (simulationData
                                .businessType ==
                            null ||
                            simulationData
                                .businessType!
                                .isEmpty) {

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih jenis usaha',
                              ),
                            ),
                          );

                          return;
                        }

                        if (simulationData
                                .kbli ==
                            null ||
                            simulationData
                                .kbli!
                                .isEmpty) {

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih KBLI',
                              ),
                            ),
                          );

                          return;
                        }

                        if (simulationData
                                .businessScope ==
                            null ||
                            simulationData
                                .businessScope!
                                .trim()
                                .isEmpty) {

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Isi ruang lingkup usaha',
                              ),
                            ),
                          );

                          return;
                        }

                        debugPrint(
                          'Kategori : ${simulationData.businessCategory}',
                        );

                        debugPrint(
                          'Jenis Usaha : ${simulationData.businessType}',
                        );

                        debugPrint(
                          'KBLI : ${simulationData.kbli}',
                        );

                        debugPrint(
                          'Lingkup : ${simulationData.businessScope}',
                        );

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(

                          const SnackBar(
                            content: Text(
                              'Step 2 berhasil disimpan',
                            ),
                          ),
                        );

                        // NEXT STEP:
                        // VALIDASI RISIKO
                      }
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
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),

                    child: Text(
                      currentStep == 2
                          ? 'Simpan & Lanjut'
                          : 'Lanjut',

                      style: const TextStyle(
                        color: Colors.white,
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