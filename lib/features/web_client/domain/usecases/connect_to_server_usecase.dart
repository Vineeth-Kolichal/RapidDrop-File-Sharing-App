import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../entities/connection_info.dart';
import '../repositories/web_client_repository.dart';

@lazySingleton
@injectable
class ConnectToServerUseCase implements UseCase<ConnectionInfo, ConnectParams> {
  final WebClientRepository repository;

  ConnectToServerUseCase(this.repository);

  @override
  Future<Either<Failure, ConnectionInfo>> call(ConnectParams params) async {
    return await repository.connectToServer(params.ip, params.port);
  }
}

class ConnectParams extends Equatable {
  final String ip;
  final int port;

  const ConnectParams({required this.ip, required this.port});

  @override
  List<Object?> get props => [ip, port];
}
