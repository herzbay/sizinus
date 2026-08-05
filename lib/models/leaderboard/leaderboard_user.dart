class LeaderboardUser {
  final String uid;

  final String fullName;

  final String email;

  final int totalXp;

  final int badgeCount;

  const LeaderboardUser({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.totalXp,
    required this.badgeCount,
  });

  /// Level dihitung otomatis dari XP.
  int get level => (totalXp ~/ 50) + 1;

  factory LeaderboardUser.fromData({
    required String uid,
    required Map<String, dynamic> userData,
    required Map<String, dynamic> simulationData,
  }) {
    return LeaderboardUser(
      uid: uid,
      fullName:
          userData['fullName']?.toString() ?? '-',
      email:
          userData['email']?.toString() ?? '',
      totalXp:
          (simulationData['totalXp'] ?? 0) as int,
      badgeCount:
          (simulationData['unlockedBadges']
                      as List?)
                  ?.length ??
              0,
    );
  }
}