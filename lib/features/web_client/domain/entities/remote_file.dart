class RemoteFile {
  final String name;
  final int size;
  final String mimeType;
  final DateTime addedAt;

  RemoteFile({
    required this.name,
    required this.size,
    required this.mimeType,
    required this.addedAt,
  });
}
