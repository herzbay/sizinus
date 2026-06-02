import 'package:flutter/material.dart';

import '../../../../core/theme/input_style.dart';

class Step6ProductServiceScreen
    extends StatefulWidget {

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
  });

  @override
  State<Step6ProductServiceScreen>
      createState() =>
          _Step6ProductServiceScreenState();
}

class _Step6ProductServiceScreenState
    extends State<
        Step6ProductServiceScreen> {

  final productController =
      TextEditingController();

  final capacityController =
      TextEditingController();

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
              hint: 'Contoh: 1000',
              icon:
                  Icons.production_quantity_limits,
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
            value: hasSni,

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

            child: const Row(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                ),

                SizedBox(width: 12),

                Expanded(

                  child: Text(

                    'Pada aplikasi OSS Indonesia sebenarnya Anda dapat menambahkan lebih dari satu produk atau jasa.\n\n'
                    'Dalam simulasi ini cukup ditambahkan satu produk/jasa utama untuk mempermudah proses pembelajaran.',

                    style: TextStyle(
                      height: 1.5,
                    ),
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

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(
          title,

          style: const TextStyle(
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
                  value ==
                      'Tidak',

              onTap: () {

                onSelected(
                  'Tidak',
                );
              },
            ),
          ],
        ),
      ],
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

      onSelected: (_) =>
          onTap(),
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