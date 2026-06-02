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
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // CARD HASIL VALIDASI
          Container(

            padding:
                const EdgeInsets.all(18),

            decoration: BoxDecoration(

              gradient:
                  const LinearGradient(
                colors: [
                  Color(0xFF2D9CDB),
                  Color(0xFF27AE60),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Column(

              children: [

                buildInfoRow(
                  'Skala Usaha',
                  widget.simulationData
                          .businessScale ??
                      '-',
                ),

                const Padding(
                  padding:
                      EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Divider(
                    color:
                        Colors.white30,
                  ),
                ),

                buildInfoRow(
                  'Tingkat Risiko',
                  widget.simulationData
                          .riskLevel ??
                      '-',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // USAHA BERJALAN
          const Text(
            'Apakah usaha ini sudah berjalan?',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
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

          const SizedBox(height: 24),

          // NPWP
          const Text(
            'Apakah usaha memiliki NPWP tersendiri?',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 12,

            children: [

              buildChoiceChip(
                label: 'Ya',
                selected:
                    hasNpwp ==
                        'Ya',

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
                    hasNpwp ==
                        'Tidak',

                onTap: () {

                  setState(() {

                    hasNpwp =
                        'Tidak';
                  });

                  updateParent();
                },
              ),
            ],
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

            onChanged: (_) =>
                updateParent(),
          ),

          const SizedBox(height: 20),

          // DESKRIPSI
          const Text(
            'Deskripsi Usaha',
            style: TextStyle(
              fontWeight: FontWeight.bold,
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

            onChanged: (_) =>
                updateParent(),
          ),

          const SizedBox(height: 20),

          // TENAGA KERJA
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

            onChanged: (_) =>
                updateParent(),
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

    return ChoiceChip(

      label: Text(label),

      selected: selected,

      selectedColor:
          const Color(
        0xFF2D9CDB,
      ),

      backgroundColor:
          Colors.grey.shade100,

      side: BorderSide(
        color: selected
            ? const Color(
                0xFF2D9CDB,
              )
            : Colors.grey.shade300,
      ),

      labelStyle: TextStyle(
        color: selected
            ? Colors.white
            : Colors.black87,

        fontWeight:
            FontWeight.w600,
      ),

      onSelected: (_) => onTap(),
    );
  }

  Widget buildInfoRow(
    String title,
    String value,
  ) {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [

        Text(
          title,

          style: const TextStyle(
            color: Colors.white,
          ),
        ),

        Text(
          value,

          style: const TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
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