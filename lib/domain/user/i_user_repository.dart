import 'package:achiever/domain/core/api_response.dart';
import 'package:achiever/domain/user/entities/user.dart';

abstract interface class IUserRepository {
  Future<ApiResponse> create();

  ApiResponse<Stream<User>> watch();
}
