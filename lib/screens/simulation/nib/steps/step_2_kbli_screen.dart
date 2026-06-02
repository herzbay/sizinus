import 'package:flutter/material.dart';

import '../../../../data/kbli_data.dart';

class Step2KbliScreen extends StatefulWidget {
  final String category;

  final Function({
    required String businessType,
    required String kbli,
    required String businessScope,
  }) onChanged;

  const Step2KbliScreen({
    super.key,
    required this.category,
    required this.onChanged,
  });

  @override
  State<Step2KbliScreen> createState() =>
      _Step2KbliScreenState();
}

class _Step2KbliScreenState
    extends State<Step2KbliScreen> {

  String? selectedBusinessType;

  String? selectedKbli;

  String? selectedDescription;

  String? selectedScope;

  final List<String> businessTypes = [
    'Utama',
  ];

  final List<String> businessScopes = [
    'Seluruh',
    'Produksi',
    'Distribusi',
    'Penjualan',
  ];

  @override
  Widget build(BuildContext context) {

    final kbliList =
        KbliData.data[
            widget.category] ??
        [];

    return SingleChildScrollView(

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // JENIS USAHA
          const Text(
            'Jenis Usaha',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue:
                selectedBusinessType,

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

            items:
                businessTypes.map((e) {

              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),

            onChanged: (value) {

              setState(() {

                selectedBusinessType =
                    value;
              });

              _updateParent();
            },
          ),

          const SizedBox(height: 20),

          // KBLI
          const Text(
            'Bidang Usaha (KBLI)',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue:
                selectedKbli,

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

            items:
                kbliList.map((item) {

              return DropdownMenuItem<
                  String>(
                value:
                    item['code'],

                child: Text(
                  item['code']!,
                  overflow:
                      TextOverflow
                          .ellipsis,
                ),
              );
            }).toList(),

            onChanged: (value) {

              setState(() {

                selectedKbli =
                    value;

                selectedDescription =
                    kbliList.firstWhere(
                  (item) =>
                      item['code'] ==
                      value,
                )['description'];
              });

              _updateParent();
            },
          ),

          // DESKRIPSI KBLI
          if (selectedDescription != null)
            Container(

              margin:
                  const EdgeInsets.only(
                top: 14,
              ),

              padding:
                  const EdgeInsets.all(
                16,
              ),

              decoration:
                  BoxDecoration(
                color:
                    Colors.blue.shade50,

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),

                border: Border.all(
                  color: Colors
                      .blue.shade200,
                ),
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child: Text(
                      selectedDescription!,
                      style:
                          const TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 20),

          // RUANG LINGKUP
          const Text(
            'Ruang Lingkup Usaha',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue:
                selectedScope,

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

            items:
                businessScopes.map(
              (scope) {

                return DropdownMenuItem(
                  value: scope,
                  child: Text(scope),
                );
              },
            ).toList(),

            onChanged: (value) {

              setState(() {

                selectedScope =
                    value;
              });

              _updateParent();
            },
          ),
        ],
      ),
    );
  }

  void _updateParent() {

    widget.onChanged(
      businessType:
          selectedBusinessType ?? '',

      kbli:
          selectedKbli ?? '',

      businessScope:
          selectedScope ?? '',
    );
  }
}