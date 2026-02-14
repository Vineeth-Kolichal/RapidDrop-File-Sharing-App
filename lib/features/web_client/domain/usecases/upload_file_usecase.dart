import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../repositories/web_client_repository.dart';

@lazySingleton
@injectable
class UploadFileUseCase implements UseCase<Unit, UploadFileParams> {
  final WebClientRepository repository;

  UploadFileUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UploadFileParams params) async {
    return await repository.uploadFile(params.filePath);
  }
}

class UploadFileParams extends Equatable {
  final String filePath;

  const UploadFileParams({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}
