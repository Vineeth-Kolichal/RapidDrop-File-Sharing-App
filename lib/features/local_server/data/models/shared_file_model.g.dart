// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedFileModel _$SharedFileModelFromJson(Map<String, dynamic> json) =>
    SharedFileModel(
      name: json['name'] as String,
      path: json['path'] as String,
      size: (json['size'] as num).toInt(),
      mimeType: json['mimeType'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
      isUploaded: json['isUploaded'] as bool? ?? false,
      ownerId: json['ownerId'] as String?,
    );

Map<String, dynamic> _$SharedFileModelToJson(SharedFileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'size': instance.size,
      'mimeType': instance.mimeType,
      'addedAt': instance.addedAt.toIso8601String(),
      'isUploaded': instance.isUploaded,
      'ownerId': instance.ownerId,
    };
