import 'package:flutter/material.dart';

import '../../data/reward/badge_repository.dart';
import '../../models/guide/guide_item.dart';
import '../../models/simulation/simulation_data.dart';
import '../../routes/app_routes.dart';
import '../../services/simulation/local_simulation_storage.dart';
import '../../widgets/custom_topbar.dart';
import '../../models/history/history_item.dart';

class BusinessGuideDetailScreen extends StatefulWidget {
  final GuideItem guideItem;

  const BusinessGuideDetailScreen({
    super.key,
    required this.guideItem,
  });

  @override
  State<BusinessGuideDetailScreen> createState() =>
      _BusinessGuideDetailScreenState();
}

class _BusinessGuideDetailScreenState
    extends State<BusinessGuideDetailScreen> {
  final LocalSimulationStorage storage =
      LocalSimulationStorage();

  SimulationData? simulationData;
  bool isLoading = true;
  bool isSaving = false;

  late List<bool> checkedSections;
  bool guideCompleted = false;

  @override
  void initState() {
    super.initState();

    checkedSections = List.generate(
      widget.guideItem.sections.length,
      (_) => false,
    );

    _loadData();
  }

  Future<void> _loadData() async {
    final data = await storage.load();

    if (!mounted) return;

    simulationData = data;

    guideCompleted = data?.completedGuideIds.contains(
          widget.guideItem.id,
        ) ??
        false;

    if (guideCompleted) {
      checkedSections = List.generate(
        widget.guideItem.sections.length,
        (_) => true,
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  bool get _canSave {
    return checkedSections.every((item) => item);
  }

  Future<void> _saveGuide() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    final currentData = simulationData ?? SimulationData();

    final badgeId =
        BadgeRepository.badgeIdForGuideId(
      widget.guideItem.id,
    );

    final earnedBadge =
        BadgeRepository.badgeForGuideId(
      widget.guideItem.id,
    );

    final earnedXp =
        BadgeRepository.xpForGuideId(
      widget.guideItem.id,
    );

    if (!currentData.completedGuideIds
        .contains(widget.guideItem.id)) {
      final updatedGuideIds =
          List<String>.from(
        currentData.completedGuideIds,
      )..add(widget.guideItem.id);

      final updatedBadges =
          List<String>.from(
        currentData.unlockedBadges,
      );

      if (!updatedBadges.contains(badgeId)) {
        updatedBadges.add(badgeId);
      }

      currentData.completedGuideIds =
          updatedGuideIds;

      currentData.unlockedBadges =
          updatedBadges;

      currentData.totalXp += earnedXp;

      // HISTORY
      currentData.historyItems.insert(
        0,
        HistoryItem(
          title:
              '${widget.guideItem.title} Diselesaikan',

          description:
              'Panduan berhasil dipelajari dan disimpan.',

          points: earnedXp,

          createdAt:
              DateTime.now(),
        ),
      );
    }

    simulationData = currentData;

    await storage.save(currentData);

    if (!mounted) return;

    setState(() {
      guideCompleted = true;
      checkedSections = List.generate(
        widget.guideItem.sections.length,
        (_) => true,
      );
      isSaving = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
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
                  12,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                  border: Border.all(
                    color:
                        Colors.blue.shade200,
                  ),
                ),
                child: Image.asset(
                  'assets/images/icon_save.png',
                  height: 84,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Panduan Berhasil Disimpan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Anda mendapatkan +$earnedXp XP dan lencana baru.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                  border: Border.all(
                    color:
                        Colors.green.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      earnedBadge.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      earnedBadge.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashboard,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2D9CDB),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Kembali ke Beranda',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _goHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.dashboard,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomTopBar(showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHero(),
              const SizedBox(height: 16),
              _buildOverview(),
              const SizedBox(height: 16),
              ...widget.guideItem.sections.asMap().entries.map(
                    (entry) => Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: _buildSection(
                        entry.value,
                        entry.key,
                      ),
                    ),
                  ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            18,
            12,
            18,
            18,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: guideCompleted
                  ? _goHome
                  : (_canSave && !isSaving
                      ? _saveGuide
                      : null),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF2D9CDB),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
              ),
              child: Text(
                guideCompleted
                    ? 'Kembali ke Beranda'
                    : 'Simpan',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    final bool completed = guideCompleted;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.blue.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.guideItem.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: completed
                      ? Colors.green.shade50
                      : Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  completed ? 'Selesai' : 'Terbuka',
                  style: TextStyle(
                    color: completed
                        ? Colors.green
                        : Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.guideItem.subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child: Icon(
                  widget.guideItem.icon,
                  color: Colors.blue,
                  size: 26,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: widget.guideItem.highlights
                .map(
                  (text) => Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                        border: Border.all(
                          color:
                              Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          color:
                              Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOverview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.green.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Penjelasan Singkat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.guideItem.overview,
            style: TextStyle(
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(GuideSection section, int index) {
    final bool checked = checkedSections[index];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.green.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: checked,
                activeColor: Colors.green,
                checkColor: Colors.white,
                side: BorderSide(
                  color: Colors.grey.shade400,
                  width: 1.5,
                ),
                onChanged: guideCompleted
                    ? null
                    : (value) {
                        setState(() {
                          checkedSections[index] =
                              value ?? false;
                        });
                      },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 11,
                  ),
                  child: Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (section.body.isNotEmpty) ...[
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(
                left: 4,
              ),
              child: Text(
                section.body,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  height: 1.5,
                ),
              ),
            ),
          ],
          if (section.bullets.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...section.bullets.map(
              (bullet) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text('•  '),
                    Expanded(
                      child: Text(
                        bullet,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}