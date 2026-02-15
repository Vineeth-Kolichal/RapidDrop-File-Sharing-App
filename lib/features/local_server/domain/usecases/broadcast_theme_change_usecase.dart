import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../repositories/local_server_repository.dart';

@lazySingleton
class BroadcastThemeChangeUseCase
    implements UseCase<Unit, BroadcastThemeChangeParams> {
  final LocalServerRepository repository;

  BroadcastThemeChangeUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(BroadcastThemeChangeParams params) async {
    return await repository.broadcastThemeChange(params.isDarkMode);
  }
}

class BroadcastThemeChangeParams {
  final bool isDarkMode;

  BroadcastThemeChangeParams({required this.isDarkMode});
}
