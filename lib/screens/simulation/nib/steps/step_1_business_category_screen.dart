import 'package:flutter/material.dart';

class Step1BusinessCategoryScreen
    extends StatefulWidget {

  const Step1BusinessCategoryScreen({
    super.key,
  });

  @override
  State<Step1BusinessCategoryScreen>
      createState() =>
          _Step1BusinessCategoryScreenState();
}

class _Step1BusinessCategoryScreenState
    extends State<
        Step1BusinessCategoryScreen> {

  String? selectedCategory;

  final List<Map<String, String>>
      categories = [

    {
      'title': 'Kuliner',
      'icon':
          'assets/images/icon_kuliner.png',
    },

    {
      'title': 'Perdagangan',
      'icon':
          'assets/images/icon_perdagangan.png',
    },

    {
      'title': 'Jasa',
      'icon':
          'assets/images/icon_jasa.png',
    },

    {
      'title': 'Teknologi',
      'icon':
          'assets/images/icon_teknologi.png',
    },

    {
      'title': 'Manufaktur',
      'icon':
          'assets/images/icon_manufaktur.png',
    },

    {
      'title': 'Pertanian',
      'icon':
          'assets/images/icon_pertanian.png',
    },

    {
      'title': 'Kesehatan',
      'icon':
          'assets/images/icon_kesehatan.png',
    },

    {
      'title': 'Pendidikan',
      'icon':
          'assets/images/icon_pendidikan.png',
    },

    {
      'title': 'Pariwisata',
      'icon':
          'assets/images/icon_pariwisata.png',
    },

    {
      'title': 'Usaha Lainnya',
      'icon':
          'assets/images/icon_lainnya.png',
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Expanded(
          child: GridView.builder(

            itemCount:
                categories.length,

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1,
            ),

            itemBuilder:
                (context, index) {

              final item =
                  categories[index];

              final isSelected =
                  selectedCategory ==
                      item['title'];

              return GestureDetector(

                onTap: () {

                  setState(() {

                    selectedCategory =
                        item['title'];
                  });
                },

                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),

                    border: Border.all(
                      color: isSelected
                          ? const Color(
                              0xFF2D9CDB,
                            )
                          : Colors.grey
                              .shade300,

                      width:
                          isSelected
                              ? 2
                              : 1,
                    ),
                  ),

                  child: Column(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    children: [

                      Image.asset(
                        item['icon']!,
                        width: 70,
                        height: 70,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        item['title']!,
                        textAlign:
                            TextAlign.center,

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}