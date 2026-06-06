import 'package:flutter/material.dart';

import '../../../../models/simulation/simulation_data.dart';
import '../../../../core/theme/input_style.dart';

class Step4BusinessLicenseScreen
    extends StatefulWidget {

  final SimulationData simulationData;

  final Function({
    required String businessRunning,
    required String hasNpwp,
    required String businessName,
    required String businessDescription,
    required int employeeCount,
  }) onChanged;

  const Step4BusinessLicenseScreen({
    super.key,
    required this.simulationData,
    required this.onChanged,
  });

  @override
  State<Step4BusinessLicenseScreen>
      createState() =>
          _Step4BusinessLicenseScreenState();
}

class _Step4BusinessLicenseScreenState
    extends State<
        Step4BusinessLicenseScreen> {

  String? businessRunning;

  String? hasNpwp;

  final TextEditingController
      businessNameController =
          TextEditingController();

  final TextEditingController
      descriptionController =
          TextEditingController();

  final TextEditingController
      employeeController =
          TextEditingController();

  @override
  void initState() {

    super.initState();

    businessRunning =
        widget.simulationData
            .businessRunning;

    hasNpwp =
        widget.simulationData
            .hasNpwp;

    businessNameController.text =
        widget.simulationData
                .businessName ??
            '';

    descriptionController.text =
        widget.simulationData
                .businessDescription ??
            '';

    employeeController.text =
        widget.simulationData
                .employeeCount
                ?.toString() ??
            '';
  }

  @override
  void dispose() {

    businessNameController.dispose();

    descriptionController.dispose();

    employeeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // USAHA SUDAH BERJALAN
          buildQuestionCard(

            title:
                'Apakah usaha ini sudah berjalan?',

            child: Wrap(

              spacing: 12,

              children: [

                buildChoiceChip(
                  label: 'Sudah',
                  selected:
                      businessRunning ==
                          'Sudah',
                  onTap: () {

                    setState(() {

                      businessRunning =
                          'Sudah';
                    });

                    updateParent();
                  },
                ),

                buildChoiceChip(
                  label: 'Belum',
                  selected:
                      businessRunning ==
                          'Belum',
                  onTap: () {

                    setState(() {

                      businessRunning =
                          'Belum';
                    });

                    updateParent();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // NPWP
          buildQuestionCard(

            title:
                'Apakah usaha memiliki NPWP tersendiri?',

            child: Wrap(

              spacing: 12,

              children: [

                buildChoiceChip(
                  label: 'Ya',
                  selected:
                      hasNpwp == 'Ya',
                  onTap: () {

                    setState(() {

                      hasNpwp = 'Ya';
                    });

                    updateParent();
                  },
                ),

                buildChoiceChip(
                  label: 'Tidak',
                  selected:
                      hasNpwp == 'Tidak',
                  onTap: () {

                    setState(() {

                      hasNpwp = 'Tidak';
                    });

                    updateParent();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // NAMA USAHA
          const Text(
            'Nama Usaha',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(

            controller:
                businessNameController,

            decoration:
                AppInputStyle.decoration(

              hint:
                  'Masukkan nama usaha',

              icon:
                  Icons.storefront_outlined,
            ),

            onChanged: (_) {

              updateParent();
            },
          ),

          const SizedBox(height: 20),

          // DESKRIPSI
          const Text(
            'Deskripsi Usaha',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(

            controller:
                descriptionController,

            minLines: 1,

            maxLines: 5,

            maxLength: 150,

            decoration:
                AppInputStyle.decoration(

              hint:
                  'Jelaskan usaha Anda',

              icon:
                  Icons.description_outlined,
            ),

            onChanged: (_) {

              updateParent();
            },
          ),

          const SizedBox(height: 20),

          // JUMLAH TENAGA KERJA
          const Text(
            'Jumlah Tenaga Kerja Indonesia',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(

            controller:
                employeeController,

            keyboardType:
                TextInputType.number,

            decoration:
                AppInputStyle.decoration(

              hint:
                  'Contoh: 5',

              icon:
                  Icons.people_outline,
            ),

            onChanged: (_) {

              updateParent();
            },
          ),

          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget buildChoiceChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {

    final bool isNegative =
        label == 'Tidak' ||
        label == 'Belum';

    final Color activeColor =
        isNegative
            ? Colors.red
            : const Color(
                0xFF2D9CDB,
              );

    return ChoiceChip(

      label: Text(label),

      selected: selected,

      selectedColor:
          activeColor.withValues(
        alpha: 0.12,
      ),

      backgroundColor:
          Colors.grey.shade100,

      side: BorderSide(

        color: selected
            ? activeColor
            : Colors.grey.shade300,

        width: selected ? 2 : 1,
      ),

      labelStyle: TextStyle(

        color: selected
            ? activeColor
            : Colors.black87,

        fontWeight:
            FontWeight.w600,
      ),

      onSelected: (_) {
        onTap();
      },
    );
  }

  Widget buildQuestionCard({
    required String title,
    required Widget child,
  }) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          16,
        ),

        border: Border.all(
          color:
              Colors.blue.shade100,
        ),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          child,
        ],
      ),
    );
  }  

  void updateParent() {

    widget.onChanged(

      businessRunning:
          businessRunning ?? '',

      hasNpwp:
          hasNpwp ?? '',

      businessName:
          businessNameController
              .text,

      businessDescription:
          descriptionController
              .text,

      employeeCount:
          int.tryParse(
                employeeController
                    .text,
              ) ??
              0,
    );
  }
}