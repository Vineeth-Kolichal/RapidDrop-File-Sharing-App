import 'package:dio/dio.dart';
import 'package:file_sharing/core/api_endpoints/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import '../../config/flavor_config.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dioInstance => Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
}
