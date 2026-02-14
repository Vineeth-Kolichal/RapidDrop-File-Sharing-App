import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../repositories/local_server_repository.dart';

@lazySingleton
@injectable
class StopServerUseCase implements UseCase<Unit, NoParams> {
  final LocalServerRepository repository;

  StopServerUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.stopServer();
  }
}
