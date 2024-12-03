import 'package:achiever/domain/core/api_response.dart';

abstract interface class IUserRepository {
  Future<ApiResponse> create();

  ApiResponse<Stream> watch();
}
