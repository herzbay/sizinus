import 'package:flutter/material.dart';

import '../../../../core/theme/input_style.dart';

class Step6ProductServiceScreen
    extends StatefulWidget {

  final String? initialProductName;

  final int? initialProductionCapacity;

  final String? initialCapacityUnit;

  final String? initialHasSni;

  final String? initialHalalProcess;

  final String? initialHasHalalCertificate;

  final Function({
    required String productName,
    required int productionCapacity,
    required String capacityUnit,
    required String hasSni,
    required String halalProcess,
    required String hasHalalCertificate,
  }) onChanged;

  const Step6ProductServiceScreen({
    super.key,
    required this.onChanged,

    this.initialProductName,
    this.initialProductionCapacity,
    this.initialCapacityUnit,
    this.initialHasSni,
    this.initialHalalProcess,
    this.initialHasHalalCertificate,
  });

  @override
  State<Step6ProductServiceScreen>
      createState() =>
          _Step6ProductServiceScreenState();
}

class _Step6ProductServiceScreenState
    extends State<
        Step6ProductServiceScreen> {

  late TextEditingController
      productController;

  late TextEditingController
      capacityController;

  String? selectedUnit;

  String? hasSni;

  String? halalProcess;

  String? hasHalalCertificate;

  final List<String> units = [

    'Pcs',

    'Unit',

    'Kg',

    'Liter',

    'Paket',

    'Orang',

    'Layanan',
  ];

  @override
  void initState() {

    super.initState();

    productController =
        TextEditingController(
      text:
          widget.initialProductName ??
              '',
    );

    capacityController =
        TextEditingController(
      text: widget
                  .initialProductionCapacity !=
              null
          ? widget
              .initialProductionCapacity
              .toString()
          : '',
    );

    selectedUnit =
        widget.initialCapacityUnit;

    hasSni =
        widget.initialHasSni;

    halalProcess =
        widget.initialHalalProcess;

    hasHalalCertificate =
        widget.initialHasHalalCertificate;
  }

  @override
  void dispose() {

    productController.dispose();

    capacityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // PRODUK/JASA
          const Text(
            'Nama Produk/Jasa',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(

            controller:
                productController,

            decoration:
                AppInputStyle.decoration(
              hint:
                  'Contoh: Nasi Goreng',
              icon:
                  Icons.inventory_2_outlined,
            ),

            onChanged: (_) =>
                updateParent(),
          ),

          const SizedBox(height: 20),

          // KAPASITAS
          const Text(
            'Kapasitas per Tahun',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(

            controller:
                capacityController,

            keyboardType:
                TextInputType.number,

            decoration:
                AppInputStyle.decoration(
              hint:
                  'Contoh: 1000',
              icon:
                  Icons
                      .production_quantity_limits,
            ),

            onChanged: (_) =>
                updateParent(),
          ),

          const SizedBox(height: 20),

          // SATUAN
          const Text(
            'Satuan Kapasitas',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(

            initialValue:
                selectedUnit,

            decoration:
                AppInputStyle.decoration(
              hint:
                  'Pilih satuan',
            ),

            items:
                units.map((item) {

              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),

            onChanged: (value) {

              setState(() {

                selectedUnit =
                    value;
              });

              updateParent();
            },
          ),

          const SizedBox(height: 24),

          buildQuestion(

            title:
                'Apakah sudah memiliki SNI?',

            value:
                hasSni,

            onSelected:
                (value) {

              setState(() {

                hasSni =
                    value;
              });

              updateParent();
            },
          ),

          const SizedBox(height: 24),

          buildQuestion(

            title:
                'Apakah bahan atau proses produksi halal?',

            value:
                halalProcess,

            onSelected:
                (value) {

              setState(() {

                halalProcess =
                    value;
              });

              updateParent();
            },
          ),

          const SizedBox(height: 24),

          buildQuestion(

            title:
                'Apakah sudah memiliki sertifikat halal?',

            value:
                hasHalalCertificate,

            onSelected:
                (value) {

              setState(() {

                hasHalalCertificate =
                    value;
              });

              updateParent();
            },
          ),

          const SizedBox(height: 24),

          // INFO OSS
          Container(

            padding:
                const EdgeInsets.all(
              18,
            ),

            decoration: BoxDecoration(

              color:
                  Colors.blue.shade50,

              borderRadius:
                  BorderRadius.circular(
                16,
              ),

              border: Border.all(
                color:
                    Colors.blue.shade200,
              ),
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Row(

                  children: [

                    Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),

                    SizedBox(width: 10),

                    Text(

                      'Informasi Penting',

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Text(

                  'Pada OSS sebenarnya Anda dapat menambahkan lebih dari satu produk atau jasa.',

                  style: TextStyle(
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 12),

                Container(

                  padding:
                      EdgeInsets.all(10),

                  decoration: BoxDecoration(

                    color:
                        Colors.white70,

                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),

                  child: Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Icon(
                        Icons.lightbulb_outline,
                        size: 18,
                        color: Colors.blue,
                      ),

                      SizedBox(width: 8),

                      Expanded(

                        child: Text(

                          'Dalam simulasi ini cukup tambahkan satu produk atau jasa utama untuk mempermudah proses pembelajaran.',

                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget buildQuestion({
    required String title,
    required String? value,
    required Function(String)
        onSelected,
  }) {

    return buildQuestionCard(

      title: title,

      child: Wrap(

        spacing: 12,

        children: [

          buildChoiceChip(

            label: 'Ya',

            selected:
                value == 'Ya',

            onTap: () {

              onSelected(
                'Ya',
              );
            },
          ),

          buildChoiceChip(

            label: 'Tidak',

            selected:
                value == 'Tidak',

            onTap: () {

              onSelected(
                'Tidak',
              );
            },
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
        label == 'Tidak';

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

      productName:
          productController.text,

      productionCapacity:
          int.tryParse(
                capacityController
                    .text,
              ) ??
              0,

      capacityUnit:
          selectedUnit ?? '',

      hasSni:
          hasSni ?? '',

      halalProcess:
          halalProcess ?? '',

      hasHalalCertificate:
          hasHalalCertificate ??
              '',
    );
  }
}