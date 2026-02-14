import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/remote_file.dart';

part 'remote_file_model.g.dart';

@JsonSerializable()
class RemoteFileModel extends RemoteFile {
  RemoteFileModel({
    required super.name,
    required super.size,
    required super.mimeType,
    required super.addedAt,
    super.isUploaded,
  });

  factory RemoteFileModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteFileModelToJson(this);
}
