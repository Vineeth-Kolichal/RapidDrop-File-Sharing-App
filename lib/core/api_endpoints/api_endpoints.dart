class ApiEndpoints {
  /// change the [baseUrl] value as per your api
  static String baseUrl = "";

  // File-sharing endpoints (relative paths for local server)
  static const String files = "/api/files";
  static const String upload = "/upload";
  static String download(String filename) => "/download/$filename";
}
