import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../../domain/entities/server_info.dart';
import '../../domain/entities/shared_file.dart';
import '../../domain/repositories/local_server_repository.dart';
import '../datasources/shelf_server_datasource.dart';

@LazySingleton(as: LocalServerRepository)
@injectable
class LocalServerRepositoryImpl implements LocalServerRepository {
  final ShelfServerDataSource dataSource;

  LocalServerRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, ServerInfo>> startServer() async {
    try {
      final result = await dataSource.startServer();
      final serverInfo = ServerInfo(
        isRunning: result['isRunning'] as bool,
        ipAddress: result['ipAddress'] as String?,
        port: result['port'] as int,
        pin: result['pin'] as String? ?? '',
        sharedFiles: (result['sharedFiles'] as List)
            .map((file) => file as SharedFile)
            .toList(),
      );
      return Right(serverInfo);
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> stopServer() async {
    try {
      await dataSource.stopServer();
      return const Right(unit);
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServerInfo>> getServerInfo() async {
    try {
      final result = dataSource.getServerInfo();
      final serverInfo = ServerInfo(
        isRunning: result['isRunning'] as bool,
        ipAddress: result['ipAddress'] as String?,
        port: result['port'] as int,
        pin: result['pin'] as String? ?? '',
        sharedFiles: (result['sharedFiles'] as List)
            .map((file) => file as SharedFile)
            .toList(),
      );
      return Right(serverInfo);
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addFileToShare(String filePath) async {
    try {
      await dataSource.addFile(filePath);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fileFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFile(String filename) async {
    try {
      await dataSource.removeFile(filename);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fileFailure(e.toString()));
    }
  }

  @override
  Stream<List<SharedFile>> get filesStream {
    return dataSource.filesStream.map((files) {
      return files.map((file) => file as SharedFile).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> broadcastThemeChange(bool isDarkMode) async {
    try {
      dataSource.broadcastThemeChange(isDarkMode);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }
}
