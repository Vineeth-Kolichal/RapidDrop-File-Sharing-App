import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/shared_file.dart';

part 'shared_file_model.g.dart';

@JsonSerializable()
class SharedFileModel extends SharedFile {
  SharedFileModel({
    required super.name,
    required super.path,
    required super.size,
    required super.mimeType,
    required super.addedAt,
    super.isUploaded,
  });

  factory SharedFileModel.fromJson(Map<String, dynamic> json) =>
      _$SharedFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$SharedFileModelToJson(this);

  factory SharedFileModel.fromEntity(SharedFile entity) {
    return SharedFileModel(
      name: entity.name,
      path: entity.path,
      size: entity.size,
      mimeType: entity.mimeType,
      addedAt: entity.addedAt,
      isUploaded: entity.isUploaded,
    );
  }
}
