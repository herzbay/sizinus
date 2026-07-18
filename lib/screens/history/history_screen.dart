import 'package:flutter/material.dart';

import '../../models/history/history_item.dart';
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

  void _onBottomNavTap(int index) {
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

      case 3:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.leaderboard,
        );
        break;

      case 4:
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
        currentIndex: 4,
        onTap: _onBottomNavTap,
      ),

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : history.isEmpty

              ? _buildEmptyState()

    : SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            // TERBARU
            const Text(
              'Terbaru',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _buildLatestCard(
              history.first,
            ),

            const SizedBox(height: 24),

            // RIWAYAT LAINNYA
            ..._buildGroupedHistory(),
          ],
        ),
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

  List<Widget> _buildGroupedHistory() {

  final List<Widget> widgets = [];

  final now = DateTime.now();

  final remaining =
      history.skip(1).toList();

  final today = <HistoryItem>[];
  final yesterday = <HistoryItem>[];
  final older = <HistoryItem>[];

  for (final item in remaining) {

    final difference =
        now.difference(
      item.createdAt,
    );

    if (difference.inDays == 0) {

      today.add(item);

    } else if (
        difference.inDays == 1) {

      yesterday.add(item);

    } else {

      older.add(item);
    }
  }

  if (today.isNotEmpty) {

    widgets.add(
      _buildSectionTitle(
        'Hari Ini',
      ),
    );

    widgets.add(
      const SizedBox(height: 12),
    );

    widgets.addAll(
      today.map(
        _buildHistoryCard,
      ),
    );
  }

  if (yesterday.isNotEmpty) {

    widgets.add(
      const SizedBox(height: 10),
    );

    widgets.add(
      _buildSectionTitle(
        'Kemarin',
      ),
    );

    widgets.add(
      const SizedBox(height: 12),
    );

    widgets.addAll(
      yesterday.map(
        _buildHistoryCard,
      ),
    );
  }

  if (older.isNotEmpty) {

    widgets.add(
      const SizedBox(height: 10),
    );

    widgets.add(
      _buildSectionTitle(
        'Lainnya',
      ),
    );

    widgets.add(
      const SizedBox(height: 12),
    );

    widgets.addAll(
      older.map(
        _buildHistoryCard,
      ),
    );
  }

  return widgets;
}

  Widget _buildSectionTitle(
    String title,
  ) {

    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLatestCard(
    HistoryItem item,
  ) {

    return Container(

      width: double.infinity,

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color:
            Colors.blue.shade50,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border: Border.all(
          color:
              Colors.blue.shade200,
        ),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(

                padding:
                    const EdgeInsets.all(
                  10,
                ),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child: const Icon(
                  Icons.bolt,
                  color:
                      Color(
                    0xFF2D9CDB,
                  ),
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              Expanded(
                child: Text(
                  item.title,
                  style:
                      const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            item.description,
          ),

          const SizedBox(
            height: 14,
          ),

          Text(
            '+${item.points} Poin',
            style: const TextStyle(
              color: Colors.green,
              fontWeight:
                  FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
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