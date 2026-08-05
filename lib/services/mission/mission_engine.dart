import '../../models/mission/mission_item.dart';
import '../../models/mission/mission_status.dart';
import '../../models/simulation/simulation_data.dart';

class MissionEngine {
  static const int rewardPoint = 50;

  static List<MissionItem> generate(
    SimulationData data,
  ) {
    MissionStatus statusOf({
      required bool completed,
      required String missionId,
    }) {
      if (!completed) {
        return MissionStatus.incomplete;
      }

      final claimed =
          data.claimedMissionIds.contains(
        missionId,
      );

      if (claimed) {
        return MissionStatus.claimed;
      }

      return MissionStatus.claimable;
    }

    final items = <MissionItem>[
      MissionItem(
        id: 'mission_nib',
        title: 'Selesaikan Simulasi NIB',
        description:
            'Pelajari proses penerbitan NIB.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId: 'mission_nib',
          completed: data.nibCompleted,
        ),
      ),

      MissionItem(
        id: 'mission_recommendation',
        title: 'Buka Rekomendasi Perizinan',
        description:
            'Lihat hasil rekomendasi izin usaha.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId:
              'mission_recommendation',
          completed:
              data.recommendationRewardClaimed,
        ),
      ),

      MissionItem(
        id: 'mission_badge1',
        title: 'Dapatkan Badge Pertama',
        description:
            'Buka satu badge apa pun.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId: 'mission_badge1',
          completed:
              data.unlockedBadges.isNotEmpty,
        ),
      ),

      MissionItem(
        id: 'mission_guide_nib',
        title: 'Selesaikan Panduan NIB',
        description:
            'Baca dan selesaikan panduan NIB.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId: 'mission_guide_nib',
          completed:
              data.completedGuideIds
                  .contains('guide_nib'),
        ),
      ),

      MissionItem(
        id: 'mission_guide_halal',
        title:
            'Selesaikan Panduan Halal',
        description:
            'Baca dan selesaikan panduan Halal.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId:
              'mission_guide_halal',
          completed:
              data.completedGuideIds
                  .contains('guide_halal'),
        ),
      ),

      MissionItem(
        id: 'mission_guide_pirt',
        title: 'Selesaikan Panduan PIRT',
        description:
            'Baca dan selesaikan panduan PIRT.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId: 'mission_guide_pirt',
          completed:
              data.completedGuideIds
                  .contains('guide_pirt'),
        ),
      ),

      MissionItem(
        id: 'mission_badge3',
        title: 'Kumpulkan 3 Badge',
        description:
            'Miliki minimal 3 badge.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId: 'mission_badge3',
          completed:
              data.unlockedBadges.length >= 3,
        ),
      ),

      MissionItem(
        id: 'mission_badge5',
        title: 'Kumpulkan 5 Badge',
        description:
            'Miliki minimal 5 badge.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId: 'mission_badge5',
          completed:
              data.unlockedBadges.length >= 5,
        ),
      ),

      MissionItem(
        id: 'mission_300_point',
        title: 'Dapatkan 300 Poin',
        description:
            'Kumpulkan total minimal 300 poin.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId: 'mission_300_point',
          completed:
              data.totalXp >= 300,
        ),
      ),

      MissionItem(
        id: 'mission_all_badge',
        title: 'Kumpulkan Semua Badge',
        description:
            'Dapatkan seluruh badge yang tersedia.',
        rewardPoint: rewardPoint,
        status: statusOf(
          missionId: 'mission_all_badge',
          completed:
              data.unlockedBadges.length >= 8,
        ),
      ),
    ];

    items.sort((a, b) {
      int weight(MissionStatus status) {
        switch (status) {
          case MissionStatus.claimable:
            return 0;

          case MissionStatus.incomplete:
            return 1;

          case MissionStatus.claimed:
            return 2;
        }
      }

      final compare =
          weight(a.status).compareTo(
        weight(b.status),
      );

      if (compare != 0) {
        return compare;
      }

      return a.title.compareTo(b.title);
    });

    return items;
  }
}