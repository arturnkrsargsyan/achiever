import 'package:achiever/domain/core/api_failure.dart';
import 'package:fpdart/fpdart.dart';

// This type represents the result of an API response, which can either be an 'ApiFailure' or a successful result of type 'T'.
typedef ApiResponse<T> = Either<ApiFailure, T>;
