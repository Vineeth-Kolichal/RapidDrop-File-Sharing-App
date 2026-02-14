import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final String name;
  final String? path;
  final Uint8List? bytes;

  const FileEntity({required this.name, this.path, this.bytes});

  @override
  List<Object?> get props => [name, path, bytes];
}
