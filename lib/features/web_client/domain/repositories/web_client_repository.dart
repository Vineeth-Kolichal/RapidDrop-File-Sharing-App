import 'package:dartz/dartz.dart';
import 'package:file_sharing/core/failures/failures.dart';
import '../entities/connection_info.dart';
import '../entities/remote_file.dart';

abstract class WebClientRepository {
  Future<Either<Failure, ConnectionInfo>> connectToServer(String ip, int port);
  Future<Either<Failure, ConnectionInfo>> validatePin(String pin);
  Future<Either<Failure, List<RemoteFile>>> getFileList();
  Future<Either<Failure, Unit>> downloadFile(String filename, String savePath);
  Future<Either<Failure, Unit>> uploadFile(String filePath);
  Future<Either<Failure, Unit>> disconnect();
}
