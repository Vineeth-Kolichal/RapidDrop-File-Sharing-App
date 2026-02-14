import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../entities/connection_info.dart';
import '../repositories/web_client_repository.dart';

@lazySingleton
@injectable
class ValidatePinUseCase implements UseCase<ConnectionInfo, ValidatePinParams> {
  final WebClientRepository repository;

  ValidatePinUseCase(this.repository);

  @override
  Future<Either<Failure, ConnectionInfo>> call(ValidatePinParams params) async {
    return await repository.validatePin(params.pin);
  }
}

class ValidatePinParams extends Equatable {
  final String pin;

  const ValidatePinParams({required this.pin});

  @override
  List<Object?> get props => [pin];
}
