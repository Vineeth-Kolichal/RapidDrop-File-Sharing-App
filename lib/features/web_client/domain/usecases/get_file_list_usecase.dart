import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../entities/remote_file.dart';
import '../repositories/web_client_repository.dart';

@lazySingleton
@injectable
class GetFileListUseCase implements UseCase<List<RemoteFile>, NoParams> {
  final WebClientRepository repository;

  GetFileListUseCase(this.repository);

  @override
  Future<Either<Failure, List<RemoteFile>>> call(NoParams params) async {
    return await repository.getFileList();
  }
}
