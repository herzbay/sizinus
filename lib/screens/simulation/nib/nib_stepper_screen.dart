import 'package:flutter/material.dart';

import '../../../widgets/custom_topbar.dart';

import 'steps/step_1_business_category_screen.dart';

class NibStepperScreen
    extends StatefulWidget {

  const NibStepperScreen({
    super.key,
  });

  @override
  State<NibStepperScreen>
      createState() =>
          _NibStepperScreenState();
}

class _NibStepperScreenState
    extends State<NibStepperScreen> {

  int currentStep = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: const CustomTopBar(
        showBackButton: true,
      ),

      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(18),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Tambah Bidang Usaha',

                style: TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Pilih kategori usaha yang paling sesuai dengan bisnis Anda.',
              ),

              const SizedBox(height: 20),

              Container(

                padding:
                    const EdgeInsets.all(
                  14,
                ),

                decoration: BoxDecoration(
                  color:
                      Colors.blue.shade50,

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.flag,
                      color:
                          Color(0xFF2D9CDB),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      'Langkah $currentStep dari 9',
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Expanded(
                child:
                    Step1BusinessCategoryScreen(),
              ),

              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 6,
                ),

                child: SizedBox(
                  width:
                      double.infinity,

                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {

                      // nanti ke step 2
                    },

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF2D9CDB,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          14,
                        ),
                      ),
                    ),

                    child: const Text(
                      'Lanjut',

                      style: TextStyle(
                        color:
                            Colors.white,

                        fontWeight:
                            FontWeight.bold,

                        fontSize: 16,
                      ),
                    ),
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