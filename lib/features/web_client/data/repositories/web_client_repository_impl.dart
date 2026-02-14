import 'package:universal_html/html.dart' as html;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../../domain/entities/connection_info.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/entities/remote_file.dart';
import '../../domain/repositories/web_client_repository.dart';
import '../datasources/remote_server_datasource.dart';

@LazySingleton(as: WebClientRepository)
@injectable
class WebClientRepositoryImpl implements WebClientRepository {
  final RemoteServerDataSource dataSource;

  WebClientRepositoryImpl(this.dataSource);

  @override
  Stream<void> get notifications => dataSource.notifications;

  @override
  Future<Either<Failure, ConnectionInfo>> connectToServer(
    String ip,
    int port,
  ) async {
    try {
      dataSource.setBaseUrl(ip, port);
      await dataSource.testConnection();

      final connectionInfo = ConnectionInfo(
        isConnected: true,
        serverIp: ip,
        port: port,
      );

      return Right(connectionInfo);
    } catch (e) {
      return Left(Failure.networkFailure('Failed to connect: $e'));
    }
  }

  @override
  Future<Either<Failure, ConnectionInfo>> validatePin(String pin) async {
    try {
      await dataSource.validatePin(pin);

      final connectionInfo = ConnectionInfo(
        isConnected: true,
        serverIp: html.window.location.hostname ?? 'localhost',
        port: int.tryParse(html.window.location.port) ?? 8080,
      );

      return Right(connectionInfo);
    } catch (e) {
      return Left(Failure.networkFailure('Invalid PIN: $e'));
    }
  }

  @override
  Future<Either<Failure, List<RemoteFile>>> getFileList() async {
    try {
      final files = await dataSource.getFileList();
      return Right(files);
    } catch (e) {
      return Left(Failure.networkFailure('Failed to fetch file list: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> downloadFile(
    String filename,
    String savePath,
  ) async {
    try {
      await dataSource.downloadFile(filename, savePath);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fileFailure('Failed to download file: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadFile(FileEntity file) async {
    try {
      await dataSource.uploadFile(file);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fileFailure('Failed to upload file: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFile(String filename) async {
    try {
      await dataSource.deleteFile(filename);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fileFailure('Failed to delete file: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> disconnect() async {
    try {
      dataSource.disconnect();
      return const Right(unit);
    } catch (e) {
      return Left(Failure.networkFailure('Failed to disconnect: $e'));
    }
  }
}
