import 'package:flutter/material.dart';

class NibRewardScreen
    extends StatelessWidget {

  const NibRewardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(24),

          child: Column(

            children: [

              const SizedBox(height: 30),

              const Icon(
                Icons.celebration,
                size: 80,
                color: Colors.orange,
              ),

              const SizedBox(height: 20),

              const Text(

                'Selamat!',

                style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                'Anda berhasil menyelesaikan simulasi pembuatan NIB.',

                textAlign:
                    TextAlign.center,
              ),

              const SizedBox(height: 30),

              // BADGE

              Container(

                padding:
                    const EdgeInsets.all(
                  18,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.amber.shade50,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: const Column(

                  children: [

                    Icon(
                      Icons.workspace_premium,
                      size: 60,
                      color:
                          Colors.amber,
                    ),

                    SizedBox(height: 10),

                    Text(
                      'First NIB',

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Menyelesaikan simulasi pembuatan NIB pertama',
                      textAlign:
                          TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

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
                    20,
                  ),
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Image.asset(
                      'assets/images/icon_xp.png',
                      width: 32,
                    ),

                    const SizedBox(
                        width: 10),

                    const Text(
                      '+150 XP',

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(

                width: double.infinity,

                height: 55,

                child: ElevatedButton(

                  onPressed: () {

                    Navigator.popUntil(
                      context,
                      (route) =>
                          route.isFirst,
                    );
                  },

                  child: const Text(
                    'Simpan',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}