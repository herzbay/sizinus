import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Step3RiskValidationScreen
    extends StatefulWidget {

  final Function({
    required double landArea,
    required String landUnit,
    required double capital,
    required String businessScale,
    required String riskLevel,
  }) onChanged;

  const Step3RiskValidationScreen({
    super.key,
    required this.onChanged,
  });

  @override
  State<Step3RiskValidationScreen>
      createState() =>
          _Step3RiskValidationScreenState();
}

class _Step3RiskValidationScreenState
    extends State<
        Step3RiskValidationScreen> {

  final currencyFormatter =
      NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );        

  final TextEditingController
      landAreaController =
          TextEditingController();

  final TextEditingController
      capitalController =
          TextEditingController();

  String? selectedUnit;

  String? businessScale;

  String? riskLevel;

  final List<String> units = [
    'm²',
    'ha',
  ];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // LUAS LAHAN
          const Text(
            'Luas Lahan',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller:
                landAreaController,

            keyboardType:
                TextInputType.number,

            decoration:
                InputDecoration(
              hintText:
                  'Contoh: 500',

              filled: true,
              fillColor: Colors.white,

              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // SATUAN
          const Text(
            'Satuan',
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
                InputDecoration(
              filled: true,
              fillColor: Colors.white,

              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
            ),

            items: units.map((e) {

              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );

            }).toList(),

            onChanged: (value) {

              setState(() {

                selectedUnit =
                    value;
              });
            },
          ),

          const SizedBox(height: 18),

          // MODAL USAHA
          const Text(
            'Modal Usaha (Rp)',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: capitalController,

            keyboardType:
                TextInputType.number,

            inputFormatters: [
              FilteringTextInputFormatter
                  .digitsOnly,
            ],

            decoration: InputDecoration(
              hintText: 'Rp 25.000.000',

              filled: true,
              fillColor: Colors.white,

              prefixIcon: const Icon(
                Icons.payments_outlined,
              ),

              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
            ),

            onChanged: (value) {

              if (value.isEmpty) return;

              final number =
                  int.parse(
                value.replaceAll('.', ''),
              );

              final formatted =
                  NumberFormat.decimalPattern(
                'id_ID',
              ).format(number);

              capitalController.value =
                  TextEditingValue(
                text: formatted,

                selection:
                    TextSelection.collapsed(
                  offset:
                      formatted.length,
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,

            child: ElevatedButton(

              onPressed:
                  validateRisk,

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.orange,
              ),

              child: const Text(
                'Validasi Risiko',
                style: TextStyle(
                  color:
                      Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          if (businessScale != null &&
              riskLevel != null)

            Container(

              padding:
                  const EdgeInsets.all(
                18,
              ),

              decoration:
                  BoxDecoration(
                color:
                    Colors.green.shade50,

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),

                border: Border.all(
                  color: Colors.green,
                ),
              ),

              child: Column(

                children: [

                  resultItem(
                    'Skala Usaha',
                    businessScale!,
                  ),

                  const Divider(),

                  resultItem(
                    'Tingkat Risiko',
                    riskLevel!,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget resultItem(
    String title,
    String value,
  ) {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [

        Text(title),

        Text(
          value,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void validateRisk() {

    if (landAreaController.text
        .isEmpty) {
      return;
    }

    if (selectedUnit == null) {
      return;
    }

    if (capitalController.text
        .isEmpty) {
      return;
    }

    final double landArea =
        double.parse(
      landAreaController.text,
    );

    final double capital =
        double.parse(
      capitalController.text
          .replaceAll('.', ''),
    );

    // SKALA USAHA
    if (capital <=
        1000000000) {

      businessScale =
          'Mikro';

    } else if (capital <=
        5000000000) {

      businessScale =
          'Kecil';

    } else {

      businessScale =
          'Menengah';
    }

    // RISIKO
    if (landArea < 1000 &&
        capital <
            1000000000) {

      riskLevel =
          'Rendah';

    } else {

      riskLevel =
          'Sedang';
    }

    widget.onChanged(
      landArea: landArea,
      landUnit:
          selectedUnit!,
      capital: capital,
      businessScale:
          businessScale!,
      riskLevel:
          riskLevel!,
    );

    setState(() {});
  }
}