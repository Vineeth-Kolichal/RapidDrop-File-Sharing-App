import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../repositories/local_server_repository.dart';

@lazySingleton
@injectable
class AddFileUseCase implements UseCase<Unit, AddFileParams> {
  final LocalServerRepository repository;

  AddFileUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddFileParams params) async {
    return await repository.addFileToShare(params.filePath);
  }
}

class AddFileParams extends Equatable {
  final String filePath;

  const AddFileParams({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}
