import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../error/failures.dart';

class SafeApiCall {
  static Future<Either<Failure, T>> call<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        return Left(NetworkFailure('Connection Timeout'));
      } else if (e.response != null) {
        return Left(ServerFailure('Server Error: ${e.response?.statusCode} ${e.response?.statusMessage}'));
      } else {
        return Left(NetworkFailure('Network Error: ${e.message}'));
      }
    } catch (e) {
      return Left(UnknownFailure('Unknown Error Occurred'));
    }
  }
}