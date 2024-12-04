import 'dart:developer';

import 'package:achiever/domain/core/api_failure.dart';
import 'package:achiever/domain/core/api_response.dart';
import 'package:achiever/domain/user/i_user_repository.dart';
import 'package:achiever/infrastructure/core/firestore_collections.dart';
import 'package:achiever/infrastructure/user/models/user_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:achiever/domain/user/entities/user.dart' as my;

@Singleton(as: IUserRepository)
class UserRepoImpl implements IUserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String get _uid {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated');
    }

    return user.uid;
  }

  @override
  Future<ApiResponse> create() async {
    try {
      final userDocRef =
          _firestore.collection(FirestoreCollections.users).doc(_uid);

      final user = await userDocRef.get();

      if (user.exists) {
        return const Left(
          ApiFailure(
            message: 'User already exists',
          ),
        );
      }

      final String? email = _firebaseAuth.currentUser?.email;

      if (email == null) {
        return const Left(
          ApiFailure(
            message: 'User email is not found',
          ),
        );
      }

      final userDto = UserDto(
        id: _uid,
        email: email,
        createdAt: DateTime.now(),
      );

      final userJson = userDto.toJson();

      await userDocRef.set(userJson);

      return const Right(null);
    } catch (e) {
      log(
        'Failed to create user, error: $e',
        name: 'UserRepoImpl.create',
      );

      return const Left(
        ApiFailure(
          message: 'Failed to create user',
        ),
      );
    }
  }

  @override
  ApiResponse<Stream<my.User>> watch() {
    try {
      final userDocRef =
          _firestore.collection(FirestoreCollections.users).doc(_uid);

      final userStream = userDocRef.snapshots().map((snapshot) {
        final userDto = UserDto.fromJson(snapshot.data()!);

        return userDto.toEntity();
      });

      return Right(userStream);
    } catch (e) {
      return const Left(
        ApiFailure(
          message: 'Failed to watch user',
        ),
      );
    }
  }
}
