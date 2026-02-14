// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteFileModel _$RemoteFileModelFromJson(Map<String, dynamic> json) =>
    RemoteFileModel(
      name: json['name'] as String,
      size: (json['size'] as num).toInt(),
      mimeType: json['mimeType'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
      isUploaded: json['isUploaded'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteFileModelToJson(RemoteFileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'mimeType': instance.mimeType,
      'addedAt': instance.addedAt.toIso8601String(),
      'isUploaded': instance.isUploaded,
    };
