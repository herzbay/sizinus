import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/custom_topbar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // APPBAR
      appBar: const CustomTopBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            24,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // FILTER CHIP
            SizedBox(
              height: 42,

              child: ListView(
                scrollDirection: Axis.horizontal,

                children: [

                  filterChip(
                    title: 'Semua',
                    active: true,
                  ),

                  filterChip(
                    title: 'Diproses',
                    active: false,
                  ),

                  filterChip(
                    title: 'Selesai',
                    active: false,
                  ),

                  filterChip(
                    title: 'Revisi',
                    active: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // STATISTIC CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1877B9),
                    Color(0xFF008C55),
                  ],
                ),

                borderRadius: BorderRadius.circular(24),
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,

                children: [

                  statisticItem(
                    title: '12',
                    subtitle: 'Selesai',
                  ),

                  statisticItem(
                    title: '3',
                    subtitle: 'Diproses',
                  ),

                  statisticItem(
                    title: '1',
                    subtitle: 'Revisi',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Aktivitas Terbaru',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // HISTORY LIST
            historyCard(
              businessName: 'Kopi Nusantara',
              permitType: 'NIB Usaha Mikro',
              date: '12 Mei 2026',
              status: 'Selesai',
              statusColor: Colors.green,
              progress: 1.0,
              xp: '+120 XP',
            ),

            historyCard(
              businessName: 'Warung Makan Barokah',
              permitType: 'Izin UMKM Kuliner',
              date: '10 Mei 2026',
              status: 'Diproses',
              statusColor: Colors.orange,
              progress: 0.7,
              xp: '+80 XP',
            ),

            historyCard(
              businessName: 'Toko Elektronik Jaya',
              permitType: 'Izin Perdagangan',
              date: '08 Mei 2026',
              status: 'Revisi',
              statusColor: Colors.red,
              progress: 0.4,
              xp: '+40 XP',
            ),

            historyCard(
              businessName: 'Laundry Bersih',
              permitType: 'NIB Jasa',
              date: '06 Mei 2026',
              status: 'Selesai',
              statusColor: Colors.green,
              progress: 1.0,
              xp: '+100 XP',
            ),

            const SizedBox(height: 120),
          ],
        ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }

  // FILTER CHIP
  Widget filterChip({
    required String title,
    required bool active,
  }) {

    return Container(
      margin: const EdgeInsets.only(right: 12),

      child: Chip(
        backgroundColor: active
            ? const Color(0xFF0F6DA1)
            : Colors.white,

        side: BorderSide.none,

        label: Text(
          title,
          style: TextStyle(
            color: active
                ? Colors.white
                : Colors.black87,

            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // STATISTIC ITEM
  Widget statisticItem({
    required String title,
    required String subtitle,
  }) {

    return Column(
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  // HISTORY CARD
  Widget historyCard({
    required String businessName,
    required String permitType,
    required String date,
    required String status,
    required Color statusColor,
    required double progress,
    required String xp,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: Icon(
                  Icons.description,
                  color: statusColor,
                  size: 32,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      businessName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      permitType,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),

                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text(
                date,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),

              Text(
                xp,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor:
                  AlwaysStoppedAnimation(statusColor),
            ),
          ),
        ],
      ),
    );
  }
}