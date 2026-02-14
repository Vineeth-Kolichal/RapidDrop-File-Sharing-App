class SharedFile {
  final String name;
  final String path;
  final int size;
  final String mimeType;
  final DateTime addedAt;

  final bool isUploaded; // true if uploaded from web, false if shared from app

  SharedFile({
    required this.name,
    required this.path,
    required this.size,
    required this.mimeType,
    required this.addedAt,
    this.isUploaded = false,
  });
}
