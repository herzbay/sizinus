import 'package:flutter/material.dart';

import '../../../widgets/custom_topbar.dart';
import '../../../widgets/nib_progress_stepper.dart';

import '../../../models/simulation/simulation_data.dart';

import 'steps/step_1_business_category_screen.dart';
import 'steps/step_2_kbli_screen.dart';
import 'steps/step_3_risk_validation_screen.dart';
import 'steps/step_4_business_license_screen.dart';
import 'steps/step_5_business_location_screen.dart';
import 'steps/step_6_product_service_screen.dart';
import 'steps/step_7_draft_nib_screen.dart';

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

  // TITLE
  String getStepTitle() {

    switch (currentStep) {

      case 1:
        return 'Tambah Bidang Usaha';

      case 2:
        return 'Pengembangan KBLI';

      case 3:
        return 'Validasi Risiko';

      case 4:
        return 'Perizinan Usaha';

      case 5:
        return 'Lokasi Usaha';

      case 6:
        return 'Produk / Jasa';

      case 7:
        return 'Draft NIB';

      case 8:
        return 'Pernyataan';

      case 9:
        return 'NIB Terbit';

      default:
        return 'Simulasi NIB';
    }
  }

  // SUBTITLE
  String getStepSubtitle() {

    switch (currentStep) {

      case 1:
        return 'Pilih kategori usaha yang paling sesuai dengan bisnis Anda.';

      case 2:
        return 'Lengkapi informasi KBLI sesuai bidang usaha yang dipilih.';

      case 3:
        return 'Masukkan data usaha untuk menentukan tingkat risiko usaha.';

      case 4:
        return 'Lengkapi informasi perizinan usaha.';

      case 5:
        return 'Lengkapi lokasi usaha.';

      case 6:
        return 'Tambahkan produk atau jasa yang ditawarkan.';

      case 7:
        return 'Periksa draft NIB yang akan diterbitkan.';

      case 8:
        return 'Baca dan setujui pernyataan.';

      case 9:
        return 'Selamat, simulasi NIB berhasil diselesaikan.';

      default:
        return '';
    }
  }

  Widget buildCurrentStep() {

    switch (currentStep) {

      case 1:
        return Step1BusinessCategoryScreen(
          onSelected: (value) {

            simulationData
                .businessCategory = value;
          },
        );

      case 2:
        return Step2KbliScreen(

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
        );

      case 3:
        return Step3RiskValidationScreen(

          onChanged: ({
            required landArea,
            required landUnit,
            required capital,
            required businessScale,
            required riskLevel,
          }) {

            simulationData.landArea =
                landArea;

            simulationData.landUnit =
                landUnit;

            simulationData.capital =
                capital;

            simulationData.businessScale =
                businessScale;

            simulationData.riskLevel =
                riskLevel;
          },
        );

      case 4:
        return Step4BusinessLicenseScreen(

          simulationData:
              simulationData,

          onChanged: ({
            required businessRunning,
            required hasNpwp,
            required businessName,
            required businessDescription,
            required employeeCount,
          }) {

            simulationData
                    .businessRunning =
                businessRunning;

            simulationData
                    .hasNpwp =
                hasNpwp;

            simulationData
                    .businessName =
                businessName;

            simulationData
                    .businessDescription =
                businessDescription;

            simulationData
                    .employeeCount =
                employeeCount;
          },
        );  

      case 5:

        return Step5BusinessLocationScreen(

          onChanged: ({
            required sameAddress,
            required locationDetermined,
            required buildingConstruction,
          }) {

            simulationData.sameAddress =
                sameAddress;

            simulationData.locationDetermined =
                locationDetermined;

            simulationData.buildingConstruction =
                buildingConstruction;
          },
        );  

      case 6:
      return Step6ProductServiceScreen(

        onChanged: ({
          required productName,
          required productionCapacity,
          required capacityUnit,
          required hasSni,
          required halalProcess,
          required hasHalalCertificate,
        }) {

          simulationData.productName =
              productName;

          simulationData
                  .productionCapacity =
              productionCapacity;

          simulationData.capacityUnit =
              capacityUnit;

          simulationData.hasSni =
              hasSni;

          simulationData.halalProcess =
              halalProcess;

          simulationData
                  .hasHalalCertificate =
              hasHalalCertificate;
        },
      );

      case 7:
      return Step7DraftNibScreen(
        simulationData:
            simulationData,
      );  

      default:
        return const Center(
          child: Text(
            'Step selanjutnya sedang dikembangkan',
          ),
        );
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

              NibProgressStepper(
                currentStep: currentStep,
                unlockedStep: unlockedStep,
              ),

              const SizedBox(height: 24),

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

              Expanded(
                child:
                    buildCurrentStep(),
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

                      // STEP 1
                      if (currentStep == 1) {

                        if (simulationData.businessCategory ==
                            null) {

                          ScaffoldMessenger.of(context)
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

                        if (simulationData.businessType ==
                                null ||
                            simulationData.businessType!
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih jenis usaha',
                              ),
                            ),
                          );

                          return;
                        }

                        if (simulationData.kbli ==
                                null ||
                            simulationData.kbli!.isEmpty) {

                          ScaffoldMessenger.of(context)
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
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih ruang lingkup usaha',
                              ),
                            ),
                          );

                          return;
                        }

                        setState(() {

                          currentStep = 3;
                          unlockedStep = 3;
                        });

                        return;
                      }

                      // STEP 3
                      if (currentStep == 3) {

                        if (simulationData.riskLevel ==
                            null) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Lakukan validasi risiko terlebih dahulu',
                              ),
                            ),
                          );

                          return;
                        }

                        setState(() {

                          currentStep = 4;
                          unlockedStep = 4;
                        });

                        return;
                      }

                      // STEP 4
                      if (currentStep == 4) {

                        if (simulationData
                                .businessRunning ==
                            null ||
                            simulationData
                                .businessRunning!
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih status usaha',
                              ),
                            ),
                          );

                          return;
                        }

                        if (simulationData.hasNpwp ==
                                null ||
                            simulationData.hasNpwp!
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih status NPWP',
                              ),
                            ),
                          );

                          return;
                        }

                        if (simulationData
                                .businessName ==
                            null ||
                            simulationData
                                .businessName!
                                .trim()
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Nama usaha wajib diisi',
                              ),
                            ),
                          );

                          return;
                        }

                        setState(() {

                          currentStep = 5;
                          unlockedStep = 5;
                        });

                        return;
                      }

                      // STEP 5
                      if (currentStep == 5) {

                        if (simulationData
                                .sameAddress ==
                            null ||
                            simulationData
                                .sameAddress!
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih alamat usaha',
                              ),
                            ),
                          );

                          return;
                        }

                        if (simulationData
                                .locationDetermined ==
                            null ||
                            simulationData
                                .locationDetermined!
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih status lokasi usaha',
                              ),
                            ),
                          );

                          return;
                        }

                        if (simulationData
                                .buildingConstruction ==
                            null ||
                            simulationData
                                .buildingConstruction!
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih pembangunan gedung',
                              ),
                            ),
                          );

                          return;
                        }

                       setState(() {

                        currentStep = 6;

                        unlockedStep = 6;
                      });

                      return;
                      }

                      // STEP 6
                      if (currentStep == 6) {

                        if (simulationData.productName ==
                                null ||
                            simulationData.productName!
                                .trim()
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Nama produk/jasa wajib diisi',
                              ),
                            ),
                          );

                          return;
                        }

                        if (simulationData.capacityUnit ==
                                null ||
                            simulationData.capacityUnit!
                                .isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                'Pilih satuan kapasitas',
                              ),
                            ),
                          );

                          return;
                        }

                        setState(() {

                          currentStep = 7;

                          unlockedStep = 7;
                        });

                        return;
                      }

                      // STEP 7
                      if (currentStep == 7) {

                        setState(() {

                          currentStep = 8;

                          unlockedStep = 8;
                        });

                        return;
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

                      currentStep == 9
                          ? 'Selesai'
                          : 'Lanjut',

                      style: const TextStyle(
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