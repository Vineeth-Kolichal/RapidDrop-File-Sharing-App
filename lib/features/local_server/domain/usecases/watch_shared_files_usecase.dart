import 'package:injectable/injectable.dart';
import '../../domain/repositories/local_server_repository.dart';
import '../../domain/entities/shared_file.dart';

@lazySingleton
class WatchSharedFilesUseCase {
  final LocalServerRepository repository;

  WatchSharedFilesUseCase(this.repository);

  Stream<List<SharedFile>> call() {
    return repository.filesStream;
  }
}
