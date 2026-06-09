import 'package:flutter/material.dart';

import '../../models/history/history_item.dart';

import '../../models/simulation/simulation_data.dart';

import '../../routes/app_routes.dart';

import '../../services/simulation/local_simulation_storage.dart';

import '../../widgets/custom_bottom_navbar.dart';

import '../../widgets/custom_topbar.dart';

class HistoryScreen extends StatefulWidget {

const HistoryScreen({

super.key,

});

@override

State<HistoryScreen> createState() =>

_HistoryScreenState();

}

class _HistoryScreenState

extends State<HistoryScreen> {

final storage =

LocalSimulationStorage();

bool isLoading = true;

List<HistoryItem> history = [];

@override

void initState() {

super.initState();

loadHistory();

}

Future<void> loadHistory() async {

final data =

    await storage.load();



final items =

    data?.historyItems ?? [];



items.sort(

  (a, b) =>

      b.createdAt.compareTo(

    a.createdAt,

  ),

);



setState(() {



  history = items;

  isLoading = false;

});

}

void onBottomTap(

int index,

) {

switch (index) {



  case 0:

    Navigator.pushReplacementNamed(

      context,

      AppRoutes.dashboard,

    );

    break;



  case 1:

    Navigator.pushReplacementNamed(

      context,

      AppRoutes.mission,

    );

    break;



  case 2:

    Navigator.pushReplacementNamed(

      context,

      AppRoutes.reward,

    );

    break;



  case 4:

    Navigator.pushReplacementNamed(

      context,

      AppRoutes.settings,

    );

    break;

}

}

@override

Widget build(

BuildContext context,

) {

return Scaffold(



  appBar:

      const CustomTopBar(),



  bottomNavigationBar:

      CustomBottomNavbar(

    currentIndex: 3,

    onTap: onBottomTap,

  ),



  body: isLoading



      ? const Center(

          child:

              CircularProgressIndicator(),

        )



      : history.isEmpty



          ? _buildEmptyState()



          : ListView.builder(



              padding:

                  const EdgeInsets.all(

                18,

              ),



              itemCount:

                  history.length,



              itemBuilder:

                  (context, index) {



                final item =

                    history[index];



                return _buildHistoryCard(

                  item,

                );

              },

            ),

);

}

Widget _buildEmptyState() {

return Center(



  child: Padding(



    padding:

        const EdgeInsets.all(

      24,

    ),



    child: Column(



      mainAxisAlignment:

          MainAxisAlignment.center,



      children: [



        Icon(

          Icons.history,

          size: 90,

          color:

              Colors.grey.shade400,

        ),



        const SizedBox(

          height: 16,

        ),



        const Text(



          'Belum Ada Riwayat',



          style: TextStyle(

            fontSize: 20,

            fontWeight:

                FontWeight.bold,

          ),

        ),



        const SizedBox(

          height: 8,

        ),



        Text(



          'Riwayat aktivitas akan muncul setelah Anda menyelesaikan simulasi, panduan, atau mendapatkan poin.',



          textAlign:

              TextAlign.center,



          style: TextStyle(

            color:

                Colors.grey.shade600,

          ),

        ),

      ],

    ),

  ),

);

}

Widget _buildHistoryCard(

HistoryItem item,

) {

return Container(



  margin:

      const EdgeInsets.only(

    bottom: 14,

  ),



  padding:

      const EdgeInsets.all(

    16,

  ),



  decoration:

      BoxDecoration(



    color: Colors.white,



    borderRadius:

        BorderRadius.circular(

      18,

    ),



    border: Border.all(

      color:

          Colors.green.shade200,

    ),



    boxShadow: [



      BoxShadow(

        color:

            Colors.black.withValues(

          alpha: 0.04,

        ),



        blurRadius: 8,



        offset:

            const Offset(

          0,

          3,

        ),

      ),

    ],

  ),



  child: Row(



    crossAxisAlignment:

        CrossAxisAlignment.start,



    children: [



      Container(



        width: 52,

        height: 52,



        decoration:

            BoxDecoration(



          color:

              Colors.green.shade50,



          borderRadius:

              BorderRadius.circular(

            14,

          ),

        ),



        child: const Icon(

          Icons.stars,

          color:

              Colors.green,

        ),

      ),



      const SizedBox(

        width: 14,

      ),



      Expanded(



        child: Column(



          crossAxisAlignment:

              CrossAxisAlignment.start,



          children: [



            Text(



              item.title,



              style:

                  const TextStyle(

                fontWeight:

                    FontWeight.bold,

                fontSize: 16,

              ),

            ),



            const SizedBox(

              height: 4,

            ),



            Text(

              item.description,

            ),



            const SizedBox(

              height: 10,

            ),



            Text(



              '+${item.points} Poin',



              style: const TextStyle(

                color:

                    Colors.green,

                fontWeight:

                    FontWeight.bold,

              ),

            ),

          ],

        ),

      ),

    ],

  ),

);

}

}