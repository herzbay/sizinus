import 'package:flutter/material.dart';

class SimulationSavedDialog
    extends StatelessWidget {

  final VoidCallback onHome;

  final VoidCallback onReward;

  const SimulationSavedDialog({
    super.key,
    required this.onHome,
    required this.onReward,
  });

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      content: Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          Container(

            padding:
                const EdgeInsets.all(
              14,
            ),

            child: Image.asset(
              'assets/images/icon_save.png',
              height: 120,
            ),
          ),

          const SizedBox(height: 12),

          const Text(

            'Data Berhasil Disimpan',

            textAlign:
                TextAlign.center,

            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Container(

            padding:
                const EdgeInsets.all(
              12,
            ),

            decoration: BoxDecoration(

              color:
                  Colors.blue.shade50,

              borderRadius:
                  BorderRadius.circular(
                12,
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

                SizedBox(width: 8),

                Expanded(

                  child: Text(

                    'Untuk mendapatkan poin dan lencana kembali, lakukan Ulangi Simulasi dari halaman hadiah.',

                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(

            width: double.infinity,

            child: ElevatedButton(

              onPressed: onHome,

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    const Color(
                  0xFF2D9CDB,
                ),

                minimumSize:
                    const Size(
                  double.infinity,
                  48,
                ),
              ),

              child: const Text(
                'Kembali ke Beranda',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(

            width: double.infinity,

            child: OutlinedButton(

              onPressed: onReward,

              child: const Text(
                'Lihat Hadiah',
              ),
            ),
          ),
        ],
      ),
    );
  }
}