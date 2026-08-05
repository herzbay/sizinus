import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/leaderboard/leaderboard_user.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<List<LeaderboardUser>> leaderboardStream() {
    return _firestore
        .collection('simulations')
        .snapshots()
        .asyncMap((simulationSnapshot) async {
      final userSnapshot =
          await _firestore
              .collection('users')
              .get();

      final Map<String, Map<String, dynamic>>
          users = {
        for (final doc in userSnapshot.docs)
          doc.id: doc.data(),
      };

      final List<LeaderboardUser> result = [];

      for (final simulationDoc
          in simulationSnapshot.docs) {
        final uid = simulationDoc.id;

        final userData = users[uid];

        // Abaikan jika data user tidak ada.
        if (userData == null) {
          continue;
        }

        final simulationData =
            simulationDoc.data();

        result.add(
          LeaderboardUser.fromData(
            uid: uid,
            userData: userData,
            simulationData: simulationData,
          ),
        );
      }

      result.sort(
        (a, b) =>
            b.totalXp.compareTo(a.totalXp),
      );

      return result;
    });
  }
}