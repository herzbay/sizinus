import 'package:flutter/material.dart';

import '../../../../models/simulation/simulation_data.dart';

class Step7DraftNibScreen extends StatelessWidget {
  final SimulationData simulationData;

  const Step7DraftNibScreen({
    super.key,
    required this.simulationData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // DRAFT NIB
          Container(
            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.05,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              children: [
                // HEADER
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2D9CDB),
                        Color(0xFF27AE60),
                      ],
                    ),

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),

                  child: const Column(
                    children: [
                      Icon(
                        Icons.badge_outlined,
                        color: Colors.white,
                        size: 46,
                      ),

                      SizedBox(height: 10),

                      Text(
                        'DRAFT NIB',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Nomor Induk Berusaha',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      buildRow(
                        'Nama Usaha',
                        simulationData.businessName ??
                            '-',
                      ),

                      buildRow(
                        'Kategori Usaha',
                        simulationData
                                .businessCategory ??
                            '-',
                      ),

                      buildRow(
                        'KBLI',
                        simulationData.kbli ??
                            '-',
                      ),

                      buildRow(
                        'Produk / Jasa',
                        simulationData.productName ??
                            '-',
                      ),

                      buildRow(
                        'Kapasitas',
                        '${simulationData.productionCapacity ?? '-'} '
                            '${simulationData.capacityUnit ?? ''}',
                      ),

                      const SizedBox(height: 20),

                      Container(

                        width: double.infinity,

                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(

                          color: Colors.orange.shade50,

                          borderRadius:
                              BorderRadius.circular(12),

                          border: Border.all(
                            color: Colors.orange.shade200,
                          ),
                        ),

                        child: const Row(

                          children: [

                            Icon(
                              Icons.pending_actions,
                              color: Colors.orange,
                            ),

                            SizedBox(width: 10),

                            Expanded(

                              child: Text(

                                'Draft NIB siap diterbitkan. Pastikan seluruh data usaha sudah sesuai.',

                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // HASIL VALIDASI
                      Container(
                        padding:
                            const EdgeInsets.all(
                          16,
                        ),

                        decoration: BoxDecoration(
                          color:
                              Colors.green.shade50,

                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),

                          border: Border.all(
                            color: Colors
                                .green.shade200,
                          ),
                        ),

                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons
                                      .verified_outlined,
                                  color: Colors.green,
                                ),

                                const SizedBox(
                                  width: 8,
                                ),

                                const Text(
                                  'Hasil Validasi Risiko',
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            buildValidationRow(
                              'Skala Usaha',
                              simulationData
                                      .businessScale ??
                                  '-',
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            buildValidationRow(
                              'Tingkat Risiko',
                              simulationData
                                      .riskLevel ??
                                  '-',
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

          const SizedBox(height: 18),

          Container(

            padding: const EdgeInsets.all(
              14,
            ),

            decoration: BoxDecoration(

              color: Colors.blue.shade50,

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),

            child: Column(

              children: [

                Row(
                  children: [

                    const Icon(
                      Icons.school_outlined,
                      color: Colors.blue,
                    ),

                    const SizedBox(width: 8),

                    const Text(
                      'Ringkasan Simulasi',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  'Anda telah menyelesaikan seluruh tahapan simulasi pembuatan NIB berdasarkan alur OSS Indonesia.',

                  style: TextStyle(
                    color:
                        Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // INFORMASI OSS
          Container(
            width: double.infinity,

            padding: const EdgeInsets.all(
              18,
            ),

            decoration: BoxDecoration(
              color: Colors.blue.shade50,

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
                        'Informasi OSS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        'Pada OSS sebenarnya Anda perlu:',
                        style: TextStyle(
                          color:
                              Colors.grey.shade800,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        '1. Membuka menu Kelola NIB',
                      ),

                      const Text(
                        '2. Memilih bidang usaha yang telah dibuat',
                      ),

                      const Text(
                        '3. Klik Kelola',
                      ),

                      const Text(
                        '4. Klik Proses Penerbitan NIB',
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Container(
                        padding:
                            const EdgeInsets.all(
                          10,
                        ),

                        decoration: BoxDecoration(
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
                              Icons.school_outlined,
                              size: 18,
                              color: Colors.blue,
                            ),

                            SizedBox(width: 8),

                            Expanded(
                              child: Text(
                                'Dalam simulasi ini langkah tersebut disederhanakan agar fokus pada proses pembelajaran.',
                                style: TextStyle(
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
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget buildRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 120,

            child: Text(
              title,

              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),
          ),

          const Text(': '),

          Expanded(
            child: Text(
              value,

              style: const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildValidationRow(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(title),

        Text(
          value,

          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }
}