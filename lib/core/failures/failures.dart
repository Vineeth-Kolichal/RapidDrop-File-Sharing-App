import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  factory Failure.apiRequestFailure(String error) = ApiRequestFailure;
  factory Failure.serverFailure(String error) = ServerFailure;
  factory Failure.networkFailure(String error) = NetworkFailure;
  factory Failure.fileFailure(String error) = FileFailure;
}
