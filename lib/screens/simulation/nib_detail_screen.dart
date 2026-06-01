import 'package:flutter/material.dart';

import '../../widgets/custom_topbar.dart';

class NibDetailScreen
    extends StatelessWidget {

  const NibDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: const CustomTopBar(),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'Nomor Induk Berusaha',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Pelajari seluruh proses pembuatan NIB berdasarkan alur OSS melalui simulasi interaktif.',
            ),

            const SizedBox(height: 24),

            infoCard(
              'Durasi',
              '15 - 20 Menit',
            ),

            infoCard(
              'Jumlah Langkah',
              '9 Step',
            ),

            infoCard(
              'Reward',
              '+150 XP',
            ),

            infoCard(
              'Badge',
              'First NIB',
            ),

            const Spacer(),

            SizedBox(

              width: double.infinity,

              height: 55,

              child: ElevatedButton(

                onPressed: () {

                  // nanti step 1
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFF2D9CDB,
                  ),
                ),

                child: const Text(
                  'Mulai Simulasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard(
    String title,
    String value,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.05,
            ),

            blurRadius: 6,
          ),
        ],
      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(title),

          Text(
            value,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}