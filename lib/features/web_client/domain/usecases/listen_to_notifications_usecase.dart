import 'package:injectable/injectable.dart';
import '../repositories/web_client_repository.dart';

@lazySingleton
class ListenToNotificationsUseCase {
  final WebClientRepository repository;

  ListenToNotificationsUseCase(this.repository);

  Stream<void> call() {
    return repository.notifications;
  }
}
