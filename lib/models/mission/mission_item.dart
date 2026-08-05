import 'mission_status.dart';

class MissionItem {
  final String id;

  final String title;

  final String description;

  final int rewardPoint;

  final MissionStatus status;

  const MissionItem({
    required this.id,
    required this.title,
    required this.description,
    required this.rewardPoint,
    required this.status,
  });

  bool get isIncomplete =>
      status == MissionStatus.incomplete;

  bool get isClaimable =>
      status == MissionStatus.claimable;

  bool get isClaimed =>
      status == MissionStatus.claimed;
}