import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../repositories/web_client_repository.dart';
import '../entities/file_entity.dart';

@lazySingleton
@injectable
class UploadFileUseCase implements UseCase<Unit, UploadFileParams> {
  final WebClientRepository repository;

  UploadFileUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UploadFileParams params) async {
    return await repository.uploadFile(params.file);
  }
}

class UploadFileParams extends Equatable {
  final FileEntity file;

  const UploadFileParams({required this.file});

  @override
  List<Object?> get props => [file];
}
