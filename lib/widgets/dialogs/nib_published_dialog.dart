import 'package:flutter/material.dart';

class NibPublishedDialog extends StatelessWidget {

  final VoidCallback onContinue;

  const NibPublishedDialog({
    super.key,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),

      content: Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          Container(

            padding: const EdgeInsets.all(
              14,
            ),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              border: Border.all(
                color: Colors.blue.shade100,
                width: 1.5,
              ),

              boxShadow: [

                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.04,
                  ),
                  blurRadius: 8,
                  offset: const Offset(
                    0,
                    3,
                  ),
                ),
              ],
            ),

            child: Image.asset(
              'assets/images/icon_nib.png',
              height: 90,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'NIB Berhasil Diterbitkan',

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Seluruh data simulasi telah berhasil diproses dan disimpan.',

            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          SizedBox(

            width: double.infinity,

            child: ElevatedButton(

              onPressed: onContinue,

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF2D9CDB,
                ),
              ),

              child: const Text(
                'Lanjut',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}