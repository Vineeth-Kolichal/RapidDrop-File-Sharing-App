import 'package:injectable/injectable.dart';

import '../repositories/web_client_repository.dart';

@lazySingleton
class ListenToConnectionStatusUseCase {
  final WebClientRepository repository;

  ListenToConnectionStatusUseCase(this.repository);

  Stream<bool> call() {
    return repository.connectionStatus;
  }
}
