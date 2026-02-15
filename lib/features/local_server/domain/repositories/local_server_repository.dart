import 'package:dartz/dartz.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../entities/server_info.dart';
import '../entities/shared_file.dart';

abstract class LocalServerRepository {
  Future<Either<Failure, ServerInfo>> startServer();
  Future<Either<Failure, Unit>> stopServer();
  Future<Either<Failure, ServerInfo>> getServerInfo();
  Future<Either<Failure, Unit>> addFileToShare(String filePath);
  Future<Either<Failure, Unit>> removeFile(String filename);
  Stream<List<SharedFile>> get filesStream;
  Future<Either<Failure, Unit>> broadcastThemeChange(bool isDarkMode);
}
