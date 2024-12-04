import 'package:achiever/domain/achievement/entities/achievement.dart';
import 'package:achiever/domain/core/api_response.dart';

abstract interface class IAchievementRepository {
  Future<ApiResponse> save(Achievement achievement);

  Future<ApiResponse> update(Achievement achievement);

  Future<ApiResponse> delete(String achievementId);

  ApiResponse<Stream<List<Achievement>>> watchAll();
}
