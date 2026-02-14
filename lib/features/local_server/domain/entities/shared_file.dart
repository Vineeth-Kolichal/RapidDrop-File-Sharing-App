class SharedFile {
  final String name;
  final String path;
  final int size;
  final String mimeType;
  final DateTime addedAt;

  SharedFile({
    required this.name,
    required this.path,
    required this.size,
    required this.mimeType,
    required this.addedAt,
  });
}
