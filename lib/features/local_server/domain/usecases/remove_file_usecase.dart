import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../repositories/local_server_repository.dart';

@lazySingleton
@injectable
class RemoveFileUseCase implements UseCase<Unit, RemoveFileParams> {
  final LocalServerRepository repository;

  RemoveFileUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(RemoveFileParams params) async {
    return await repository.removeFile(params.filename);
  }
}

class RemoveFileParams extends Equatable {
  final String filename;

  const RemoveFileParams({required this.filename});

  @override
  List<Object?> get props => [filename];
}
