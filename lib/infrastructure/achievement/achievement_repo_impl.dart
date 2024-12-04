import 'dart:developer';

import 'package:achiever/domain/achievement/entities/achievement.dart';
import 'package:achiever/domain/achievement/i_achievement_repository.dart';
import 'package:achiever/domain/core/api_failure.dart';
import 'package:achiever/domain/core/api_response.dart';
import 'package:achiever/infrastructure/achievement/models/achievement_dto.dart';
import 'package:achiever/infrastructure/core/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IAchievementRepository)
class AchievementRepoImpl implements IAchievementRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<ApiResponse> save(Achievement achievement) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        return const Left(
          ApiFailure(
            message: 'User is not authenticated',
          ),
        );
      }

      final achievementRef = _firestore
          .collection(FirestoreCollections.users)
          .doc(user.uid)
          .collection(FirestoreCollections.achievements)
          .doc();

      final achievementDto = AchievementDto.fromEntity(achievement);

      await achievementRef.set(
        achievementDto.toJson(),
      );

      return const Right(unit);
    } catch (e, st) {
      log(
        'Failed to create achievement',
        error: e,
        stackTrace: st,
      );

      return const Left(
        ApiFailure(
          message: 'Failed to create achievement',
        ),
      );
    }
  }

  @override
  ApiResponse<Stream<List<Achievement>>> watchAll() {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        return const Left(
          ApiFailure(
            message: 'User is not authenticated',
          ),
        );
      }

      final achievementsRef = _firestore
          .collection(FirestoreCollections.users)
          .doc(user.uid)
          .collection(FirestoreCollections.achievements)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map(
              (doc) {
                final achievementDto = AchievementDto.fromJson(doc.data());

                return achievementDto.toEntity();
              },
            ).toList(),
          );

      return Right(achievementsRef);
    } catch (e, st) {
      log(
        'Failed to watch achievements',
        error: e,
        stackTrace: st,
      );

      return const Left(
        ApiFailure(
          message: 'Failed to watch achievements',
        ),
      );
    }
  }

  @override
  Future<ApiResponse> delete(String achievementId) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        return const Left(
          ApiFailure(
            message: 'User is not authenticated',
          ),
        );
      }

      final achievementRef = _firestore
          .collection(FirestoreCollections.users)
          .doc(user.uid)
          .collection(FirestoreCollections.achievements)
          .doc(achievementId);

      await achievementRef.delete();

      return const Right(unit);
    } catch (e, st) {
      log(
        'Failed to delete achievement',
        error: e,
        stackTrace: st,
      );

      return const Left(
        ApiFailure(
          message: 'Failed to delete achievement',
        ),
      );
    }
  }

  @override
  Future<ApiResponse> update(Achievement achievement) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        return const Left(
          ApiFailure(
            message: 'User is not authenticated',
          ),
        );
      }

      final achievementRef = _firestore
          .collection(FirestoreCollections.users)
          .doc(user.uid)
          .collection(FirestoreCollections.achievements)
          .doc(achievement.id);

      final achievementDto = AchievementDto.fromEntity(achievement);

      await achievementRef.update(
        achievementDto.toJson(),
      );

      return const Right(unit);
    } catch (e, st) {
      log(
        'Failed to update achievement',
        error: e,
        stackTrace: st,
      );

      return const Left(
        ApiFailure(message: 'Failed to update achievement'),
      );
    }
  }
}
