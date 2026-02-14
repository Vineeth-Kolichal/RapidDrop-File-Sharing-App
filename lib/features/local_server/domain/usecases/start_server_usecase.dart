import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../entities/server_info.dart';
import '../repositories/local_server_repository.dart';

@lazySingleton
@injectable
class StartServerUseCase implements UseCase<ServerInfo, NoParams> {
  final LocalServerRepository repository;

  StartServerUseCase(this.repository);

  @override
  Future<Either<Failure, ServerInfo>> call(NoParams params) async {
    return await repository.startServer();
  }
}
