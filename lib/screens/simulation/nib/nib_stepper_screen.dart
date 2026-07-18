import 'package:flutter/material.dart';

import '../../../widgets/custom_topbar.dart';
import '../../../widgets/nib_progress_stepper.dart';
import '../../../widgets/dialogs/nib_published_dialog.dart';
import '../../../widgets/dialogs/simulation_saved_dialog.dart';
import '../../../models/simulation/simulation_data.dart';
import '../../../services/simulation/local_simulation_storage.dart';
import '../../../models/history/history_item.dart';

import 'steps/step_1_business_category_screen.dart';
import 'steps/step_2_kbli_screen.dart';
import 'steps/step_3_risk_validation_screen.dart';
import 'steps/step_4_business_license_screen.dart';
import 'steps/step_5_business_location_screen.dart';
import 'steps/step_6_product_service_screen.dart';
import 'steps/step_7_draft_nib_screen.dart';
import 'nib_reward_screen.dart';
import '../../../data/reward/badge_repository.dart';
import '../../../routes/app_routes.dart';

class NibStepperScreen extends StatefulWidget {
  const NibStepperScreen({
    super.key,
  });

  @override
  State<NibStepperScreen> createState() =>
      _NibStepperScreenState();
}

class _NibStepperScreenState extends State<NibStepperScreen> {
  final LocalSimulationStorage storage =
      LocalSimulationStorage();

  SimulationData simulationData =
      SimulationData();

  bool isLoading = true;

  int currentStep = 1;
  int unlockedStep = 1;

  @override
  void initState() {
    super.initState();
    _loadSimulation();
  }

  Future<void> _loadSimulation() async {
    final data = await storage.load();

    if (!mounted) return;

    if (data != null) {
      simulationData = data;
      currentStep = data.currentStep;
      unlockedStep = data.unlockedStep;
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveSimulation() async {
    simulationData.currentStep = currentStep;
    simulationData.unlockedStep = unlockedStep;

    await storage.save(simulationData);
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

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
      default:
        return '';
    }
  }

  Widget buildCurrentStep() {
    switch (currentStep) {
      case 1:
        return Step1BusinessCategoryScreen(
          selectedCategory: simulationData.businessCategory,
          onSelected: (value) async {
            final oldCategory = simulationData.businessCategory;

            simulationData.businessCategory = value;

            // Jika kategori berubah, KBLI dan ruang lingkup lama tidak valid lagi.
            if (oldCategory != value) {
              simulationData.businessType = null;
              simulationData.kbli = null;
              simulationData.businessScope = null;
            }

            await _saveSimulation();
            setState(() {});
          },
        );

      case 2:
        return Step2KbliScreen(
          category: simulationData.businessCategory ?? '',
          initialBusinessType: simulationData.businessType,
          initialKbli: simulationData.kbli,
          initialScope: simulationData.businessScope,
          onChanged: ({
            required businessType,
            required kbli,
            required businessScope,
          }) async {
            simulationData.businessType = businessType;
            simulationData.kbli = kbli;
            simulationData.businessScope = businessScope;

            await _saveSimulation();
            setState(() {});
          },
        );

      case 3:
        return Step3RiskValidationScreen(
          initialLandArea: simulationData.landArea,
          initialLandUnit: simulationData.landUnit,
          initialCapital: simulationData.capital,
          initialBusinessScale: simulationData.businessScale,
          initialRiskLevel: simulationData.riskLevel,
          onChanged: ({
            required landArea,
            required landUnit,
            required capital,
            required businessScale,
            required riskLevel,
          }) async {
            simulationData.landArea = landArea;
            simulationData.landUnit = landUnit;
            simulationData.capital = capital;
            simulationData.businessScale = businessScale;
            simulationData.riskLevel = riskLevel;

            await _saveSimulation();
            setState(() {});
          },
        );

      case 4:
        return Step4BusinessLicenseScreen(
          simulationData: simulationData,
          onChanged: ({
            required businessRunning,
            required hasNpwp,
            required businessName,
            required businessDescription,
            required employeeCount,
          }) async {
            simulationData.businessRunning = businessRunning;
            simulationData.hasNpwp = hasNpwp;
            simulationData.businessName = businessName;
            simulationData.businessDescription = businessDescription;
            simulationData.employeeCount = employeeCount;

            await _saveSimulation();
            setState(() {});
          },
        );

      case 5:
        return Step5BusinessLocationScreen(
          onChanged: ({
            required sameAddress,
            required locationDetermined,
            required buildingConstruction,
          }) async {
            simulationData.sameAddress = sameAddress;
            simulationData.locationDetermined = locationDetermined;
            simulationData.buildingConstruction = buildingConstruction;

            await _saveSimulation();
            setState(() {});
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
          }) async {
            simulationData.productName = productName;
            simulationData.productionCapacity = productionCapacity;
            simulationData.capacityUnit = capacityUnit;
            simulationData.hasSni = hasSni;
            simulationData.halalProcess = halalProcess;
            simulationData.hasHalalCertificate = hasHalalCertificate;

            await _saveSimulation();
            setState(() {});
          },
        );

      case 7:
        return Step7DraftNibScreen(
          simulationData: simulationData,
        );

      default:
        return const Center(
          child: Text(''),
        );
    }
  }

  Future<void> _handleStep7Submit() async {
    final bool firstCompletion = !simulationData.nibCompleted;

    if (firstCompletion) {
      simulationData.nibCompleted = true;
      simulationData.nibCompletedAt = DateTime.now();
      simulationData.nibCompletedCount = 1;

      simulationData.totalXp +=
          BadgeRepository.xpForSimulationNibCompletion();

      simulationData.historyItems.insert(
        0,
        HistoryItem(
          title: 'Simulasi NIB Selesai',
          description:
              'Berhasil menyelesaikan simulasi dan menerbitkan NIB.',
          points:
              BadgeRepository
                  .xpForSimulationNibCompletion(),
          createdAt: DateTime.now(),
        ),
      );

      final badges = simulationData.unlockedBadges.toSet();
      badges.add(BadgeRepository.simulationNibBadge.id);
      simulationData.unlockedBadges = badges.toList();
    }

    simulationData.currentStep = 7;
    simulationData.unlockedStep = 7;

    await _saveSimulation();

    if (!mounted) return;

    if (firstCompletion) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return NibPublishedDialog(
            onContinue: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NibRewardScreen(),
                ),
              );
            },
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (_) {
          return SimulationSavedDialog(
            onHome: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.dashboard,
                (route) => false,
              );
            },
            onReward: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NibRewardScreen(),
                ),
              );
            },
          );
        },
      );
    }
  }

  Future<void> _handleNextPressed() async {
    // STEP 1
    if (currentStep == 1) {
      if (simulationData.businessCategory == null) {
        _showSnack('Pilih kategori usaha terlebih dahulu');
        return;
      }

      setState(() {
        currentStep = 2;
        unlockedStep = unlockedStep < 2 ? 2 : unlockedStep;
      });

      await _saveSimulation();
      return;
    }

    // STEP 2
    if (currentStep == 2) {
      if (simulationData.businessType == null ||
          simulationData.businessType!.isEmpty) {
        _showSnack('Pilih jenis usaha');
        return;
      }

      if (simulationData.kbli == null ||
          simulationData.kbli!.isEmpty) {
        _showSnack('Pilih KBLI');
        return;
      }

      if (simulationData.businessScope == null ||
          simulationData.businessScope!.isEmpty) {
        _showSnack('Pilih ruang lingkup usaha');
        return;
      }

      setState(() {
        currentStep = 3;
        unlockedStep = unlockedStep < 3 ? 3 : unlockedStep;
      });

      await _saveSimulation();
      return;
    }

    // STEP 3
    if (currentStep == 3) {
      if (simulationData.riskLevel == null) {
        _showSnack('Lakukan validasi risiko terlebih dahulu');
        return;
      }

      setState(() {
        currentStep = 4;
        unlockedStep = unlockedStep < 4 ? 4 : unlockedStep;
      });

      await _saveSimulation();
      return;
    }

    // STEP 4
    if (currentStep == 4) {
      if (simulationData.businessRunning == null ||
          simulationData.businessRunning!.isEmpty) {
        _showSnack('Pilih status usaha');
        return;
      }

      if (simulationData.hasNpwp == null ||
          simulationData.hasNpwp!.isEmpty) {
        _showSnack('Pilih status NPWP');
        return;
      }

      if (simulationData.businessName == null ||
          simulationData.businessName!.trim().isEmpty) {
        _showSnack('Nama usaha wajib diisi');
        return;
      }

      setState(() {
        currentStep = 5;
        unlockedStep = unlockedStep < 5 ? 5 : unlockedStep;
      });

      await _saveSimulation();
      return;
    }

    // STEP 5
    if (currentStep == 5) {
      if (simulationData.sameAddress == null ||
          simulationData.sameAddress!.isEmpty) {
        _showSnack('Pilih alamat usaha');
        return;
      }

      if (simulationData.locationDetermined == null ||
          simulationData.locationDetermined!.isEmpty) {
        _showSnack('Pilih status lokasi usaha');
        return;
      }

      if (simulationData.buildingConstruction == null ||
          simulationData.buildingConstruction!.isEmpty) {
        _showSnack('Pilih pembangunan gedung');
        return;
      }

      setState(() {
        currentStep = 6;
        unlockedStep = unlockedStep < 6 ? 6 : unlockedStep;
      });

      await _saveSimulation();
      return;
    }

    // STEP 6
    if (currentStep == 6) {
      if (simulationData.productName == null ||
          simulationData.productName!.trim().isEmpty) {
        _showSnack('Nama produk/jasa wajib diisi');
        return;
      }

      if (simulationData.capacityUnit == null ||
          simulationData.capacityUnit!.isEmpty) {
        _showSnack('Pilih satuan kapasitas');
        return;
      }

      setState(() {
        currentStep = 7;
        unlockedStep = unlockedStep < 7 ? 7 : unlockedStep;
      });

      simulationData.nibDraftGenerated = true;
      await _saveSimulation();
      return;
    }

    // STEP 7
    if (currentStep == 7) {
      await _handleStep7Submit();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomTopBar(
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NibProgressStepper(
                currentStep: currentStep,
                unlockedStep: unlockedStep,
                onStepTap: (step) async {
                  if (step <= unlockedStep) {
                    setState(() {
                      currentStep = step;
                    });
                    await _saveSimulation();
                  }
                },
              ),
              if (currentStep != 7) ...[
                const SizedBox(height: 24),
                Text(
                  getStepTitle(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  getStepSubtitle(),
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 20),
              ] else ...[
                const SizedBox(height: 12),
              ],
              Expanded(
                child: buildCurrentStep(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _handleNextPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentStep == 7
                          ? Colors.green
                          : const Color(0xFF2D9CDB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      currentStep == 7
                          ? (simulationData.nibCompleted
                              ? 'Simpan'
                              : 'Simpan & Terbitkan')
                          : 'Lanjut',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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