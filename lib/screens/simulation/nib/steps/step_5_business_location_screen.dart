import 'package:flutter/material.dart';

class Step5BusinessLocationScreen
    extends StatefulWidget {

  final String? initialSameAddress;

  final String? initialLocationDetermined;

  final String? initialBuildingConstruction;

  final Function({
    required String sameAddress,
    required String locationDetermined,
    required String buildingConstruction,
  }) onChanged;

  const Step5BusinessLocationScreen({
    super.key,
    required this.onChanged,
    this.initialSameAddress,
    this.initialLocationDetermined,
    this.initialBuildingConstruction,
  });

  @override
  State<Step5BusinessLocationScreen>
      createState() =>
          _Step5BusinessLocationScreenState();
}

class _Step5BusinessLocationScreenState
    extends State<
        Step5BusinessLocationScreen> {

  String? sameAddress;

  String? locationDetermined;

  String? buildingConstruction;

  @override
  void initState() {

    super.initState();

    sameAddress =
        widget.initialSameAddress;

    locationDetermined =
        widget.initialLocationDetermined;

    buildingConstruction =
        widget.initialBuildingConstruction;
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // ALAMAT USAHA
          const Text(
            'Apakah alamat usaha sama dengan alamat domisili?',
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
                    sameAddress ==
                        'Ya',

                onTap: () {

                  setState(() {

                    sameAddress =
                        'Ya';
                  });

                  updateParent();
                },
              ),

              buildChoiceChip(
                label: 'Tidak',

                selected:
                    sameAddress ==
                        'Tidak',

                onTap: () {

                  setState(() {

                    sameAddress =
                        'Tidak';
                  });

                  updateParent();
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // LOKASI USAHA
          const Text(
            'Apakah lokasi usaha sudah ditentukan?',
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
                    locationDetermined ==
                        'Sudah',

                onTap: () {

                  setState(() {

                    locationDetermined =
                        'Sudah';
                  });

                  updateParent();
                },
              ),

              buildChoiceChip(
                label: 'Belum',

                selected:
                    locationDetermined ==
                        'Belum',

                onTap: () {

                  setState(() {

                    locationDetermined =
                        'Belum';
                  });

                  updateParent();
                },
              ),
            ],
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

            child: Row(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                ),

                const SizedBox(width: 12),

                Expanded(

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        'Informasi Penting',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        'Pada OSS, pengguna akan diminta mengisi data lokasi usaha berikut:',
                        style: TextStyle(
                          color:
                              Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                          '• Provinsi'),
                      const Text(
                          '• Kabupaten/Kota'),
                      const Text(
                          '• Kecamatan'),
                      const Text(
                          '• Desa/Kelurahan'),
                      const Text(
                          '• Kode Pos'),
                      const Text(
                          '• Alamat Lengkap'),

                      const SizedBox(
                        height: 12,
                      ),

                      Container(

                        padding:
                            const EdgeInsets.all(
                          10,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white70,

                          borderRadius:
                              BorderRadius.circular(
                            10,
                          ),
                        ),

                        child: const Row(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Icon(
                              Icons
                                  .shield_outlined,
                              size: 18,
                              color:
                                  Colors.blue,
                            ),

                            SizedBox(
                              width: 8,
                            ),

                            Expanded(

                              child: Text(
                                'Data lokasi tidak ditampilkan dalam simulasi untuk menjaga privasi pengguna.',
                                style:
                                    TextStyle(
                                  fontSize:
                                      13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // PEMBANGUNAN GEDUNG
          const Text(
            'Apakah akan melakukan pembangunan gedung?',
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
                    buildingConstruction ==
                        'Ya',

                onTap: () {

                  setState(() {

                    buildingConstruction =
                        'Ya';
                  });

                  updateParent();
                },
              ),

              buildChoiceChip(
                label: 'Tidak',

                selected:
                    buildingConstruction ==
                        'Tidak',

                onTap: () {

                  setState(() {

                    buildingConstruction =
                        'Tidak';
                  });

                  updateParent();
                },
              ),
            ],
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

      onSelected: (_) {
        onTap();
      },
    );
  }

  void updateParent() {

    widget.onChanged(

      sameAddress:
          sameAddress ?? '',

      locationDetermined:
          locationDetermined ?? '',

      buildingConstruction:
          buildingConstruction ?? '',
    );
  }
}