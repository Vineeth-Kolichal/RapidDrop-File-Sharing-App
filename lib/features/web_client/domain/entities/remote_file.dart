class RemoteFile {
  final String name;
  final int size;
  final String mimeType;
  final DateTime addedAt;

  final bool isUploaded;

  RemoteFile({
    required this.name,
    required this.size,
    required this.mimeType,
    required this.addedAt,
    this.isUploaded = false,
  });
}
