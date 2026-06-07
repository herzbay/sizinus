import 'package:flutter/material.dart';

import '../../../models/reward/badge.dart';

class BadgeRepository {
  // XP rewards
  static const int simulationNibXp = 200;
  static const int guideNibXp = 50;
  static const int guideOtherXp = 50;
  static const int recommendationUnlockedXp = 100;

  // Main badges
  static const RewardBadge simulationNibBadge = RewardBadge(
    id: 'badge_simulation_nib',
    title: 'Pendekar Simulasi',
    description: 'Berhasil menyelesaikan simulasi pembuatan NIB.',
    imageAsset: 'assets/images/badge_simulation_nib.png',
    color: Color(0xFF2D9CDB),
  );

  static const RewardBadge guideNibBadge = RewardBadge(
    id: 'badge_guide_nib',
    title: 'Dasar Usaha',
    description: 'Mempelajari panduan Nomor Induk Berusaha.',
    imageAsset: 'assets/images/badge_guide_nib.png',
    color: Colors.green,
  );

  static const RewardBadge guideHalalBadge = RewardBadge(
    id: 'badge_guide_halal',
    title: 'Pengusaha Halal',
    description: 'Mempelajari panduan sertifikasi halal.',
    imageAsset: 'assets/images/badge_guide_halal.png',
    color: Colors.green,
  );

  static const RewardBadge guidePirtBadge = RewardBadge(
    id: 'badge_guide_pirt',
    title: 'Pengolah Terbaik',
    description: 'Mempelajari panduan PIRT.',
    imageAsset: 'assets/images/badge_guide_pirt.png',
    color: Colors.green,
  );

  static const RewardBadge guideSniBadge = RewardBadge(
    id: 'badge_guide_sni',
    title: 'Standar Nasional',
    description: 'Mempelajari panduan SNI.',
    imageAsset: 'assets/images/badge_guide_sni.png',
    color: Colors.green,
  );

  static const RewardBadge guideStandarBadge = RewardBadge(
    id: 'badge_guide_standar',
    title: 'Terbukti Aman',
    description: 'Mempelajari panduan sertifikat standar.',
    imageAsset: 'assets/images/badge_guide_standar.png',
    color: Colors.green,
  );

  static const RewardBadge guideMerekBadge = RewardBadge(
    id: 'badge_guide_merek',
    title: 'Jaga Merek',
    description: 'Mempelajari panduan hak merek.',
    imageAsset: 'assets/images/badge_guide_merek.png',
    color: Colors.green,
  );

  static const RewardBadge guidePbgBadge = RewardBadge(
    id: 'badge_guide_pbg',
    title: 'Bos',
    description: 'Mempelajari panduan PBG.',
    imageAsset: 'assets/images/badge_guide_pbg.png',
    color: Colors.green,
  );

  static const RewardBadge guideNpwpBadge = RewardBadge(
    id: 'badge_guide_npwp',
    title: 'Pengusaha Teladan',
    description: 'Mempelajari panduan NPWP usaha.',
    imageAsset: 'assets/images/badge_guide_npwp.png',
    color: Colors.green,
  );

  static const List<RewardBadge> allBadges = [
    simulationNibBadge,
    guideNibBadge,
    guideHalalBadge,
    guidePirtBadge,
    guideSniBadge,
    guideStandarBadge,
    guideMerekBadge,
    guidePbgBadge,
    guideNpwpBadge,
  ];

  static RewardBadge? getBadgeById(String id) {
    for (final badge in allBadges) {
      if (badge.id == id) {
        return badge;
      }
    }
    return null;
  }

  static RewardBadge badgeForGuideId(String guideId) {
    switch (guideId) {
      case 'nib':
        return guideNibBadge;
      case 'halal':
        return guideHalalBadge;
      case 'pirt':
        return guidePirtBadge;
      case 'sni':
        return guideSniBadge;
      case 'standar':
        return guideStandarBadge;
      case 'merek':
        return guideMerekBadge;
      case 'pbg':
        return guidePbgBadge;
      case 'npwp':
        return guideNpwpBadge;
      default:
        return guideNibBadge;
    }
  }

  static String badgeIdForGuideId(String guideId) {
    switch (guideId) {
      case 'nib':
        return guideNibBadge.id;
      case 'halal':
        return guideHalalBadge.id;
      case 'pirt':
        return guidePirtBadge.id;
      case 'sni':
        return guideSniBadge.id;
      case 'standar':
        return guideStandarBadge.id;
      case 'merek':
        return guideMerekBadge.id;
      case 'pbg':
        return guidePbgBadge.id;
      case 'npwp':
        return guideNpwpBadge.id;
      default:
        return guideNibBadge.id;
    }
  }

  static int xpForGuideId(String guideId) {
    // Semua panduan diberi XP yang sama sesuai rencana saat ini.
    return guideOtherXp;
  }

  static int xpForSimulationNibCompletion() {
    return simulationNibXp;
  }

  static int xpForRecommendationUnlocked() {
    return recommendationUnlockedXp;
  }
}