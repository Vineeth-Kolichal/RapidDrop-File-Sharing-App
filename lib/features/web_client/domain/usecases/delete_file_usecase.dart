import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/failures/failures.dart';
import '../repositories/web_client_repository.dart';

@lazySingleton
class DeleteFileUseCase implements UseCase<Unit, DeleteFileParams> {
  final WebClientRepository repository;

  DeleteFileUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteFileParams params) async {
    return await repository.deleteFile(params.filename);
  }
}

class DeleteFileParams {
  final String filename;

  DeleteFileParams({required this.filename});
}
