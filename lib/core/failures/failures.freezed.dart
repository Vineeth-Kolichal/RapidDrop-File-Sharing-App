// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 String get error;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'Failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ApiRequestFailure value)?  apiRequestFailure,TResult Function( ServerFailure value)?  serverFailure,TResult Function( NetworkFailure value)?  networkFailure,TResult Function( FileFailure value)?  fileFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ApiRequestFailure() when apiRequestFailure != null:
return apiRequestFailure(_that);case ServerFailure() when serverFailure != null:
return serverFailure(_that);case NetworkFailure() when networkFailure != null:
return networkFailure(_that);case FileFailure() when fileFailure != null:
return fileFailure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ApiRequestFailure value)  apiRequestFailure,required TResult Function( ServerFailure value)  serverFailure,required TResult Function( NetworkFailure value)  networkFailure,required TResult Function( FileFailure value)  fileFailure,}){
final _that = this;
switch (_that) {
case ApiRequestFailure():
return apiRequestFailure(_that);case ServerFailure():
return serverFailure(_that);case NetworkFailure():
return networkFailure(_that);case FileFailure():
return fileFailure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ApiRequestFailure value)?  apiRequestFailure,TResult? Function( ServerFailure value)?  serverFailure,TResult? Function( NetworkFailure value)?  networkFailure,TResult? Function( FileFailure value)?  fileFailure,}){
final _that = this;
switch (_that) {
case ApiRequestFailure() when apiRequestFailure != null:
return apiRequestFailure(_that);case ServerFailure() when serverFailure != null:
return serverFailure(_that);case NetworkFailure() when networkFailure != null:
return networkFailure(_that);case FileFailure() when fileFailure != null:
return fileFailure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String error)?  apiRequestFailure,TResult Function( String error)?  serverFailure,TResult Function( String error)?  networkFailure,TResult Function( String error)?  fileFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ApiRequestFailure() when apiRequestFailure != null:
return apiRequestFailure(_that.error);case ServerFailure() when serverFailure != null:
return serverFailure(_that.error);case NetworkFailure() when networkFailure != null:
return networkFailure(_that.error);case FileFailure() when fileFailure != null:
return fileFailure(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String error)  apiRequestFailure,required TResult Function( String error)  serverFailure,required TResult Function( String error)  networkFailure,required TResult Function( String error)  fileFailure,}) {final _that = this;
switch (_that) {
case ApiRequestFailure():
return apiRequestFailure(_that.error);case ServerFailure():
return serverFailure(_that.error);case NetworkFailure():
return networkFailure(_that.error);case FileFailure():
return fileFailure(_that.error);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String error)?  apiRequestFailure,TResult? Function( String error)?  serverFailure,TResult? Function( String error)?  networkFailure,TResult? Function( String error)?  fileFailure,}) {final _that = this;
switch (_that) {
case ApiRequestFailure() when apiRequestFailure != null:
return apiRequestFailure(_that.error);case ServerFailure() when serverFailure != null:
return serverFailure(_that.error);case NetworkFailure() when networkFailure != null:
return networkFailure(_that.error);case FileFailure() when fileFailure != null:
return fileFailure(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ApiRequestFailure implements Failure {
   ApiRequestFailure(this.error);
  

@override final  String error;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiRequestFailureCopyWith<ApiRequestFailure> get copyWith => _$ApiRequestFailureCopyWithImpl<ApiRequestFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiRequestFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'Failure.apiRequestFailure(error: $error)';
}


}

/// @nodoc
abstract mixin class $ApiRequestFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ApiRequestFailureCopyWith(ApiRequestFailure value, $Res Function(ApiRequestFailure) _then) = _$ApiRequestFailureCopyWithImpl;
@override @useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ApiRequestFailureCopyWithImpl<$Res>
    implements $ApiRequestFailureCopyWith<$Res> {
  _$ApiRequestFailureCopyWithImpl(this._self, this._then);

  final ApiRequestFailure _self;
  final $Res Function(ApiRequestFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ApiRequestFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ServerFailure implements Failure {
   ServerFailure(this.error);
  

@override final  String error;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'Failure.serverFailure(error: $error)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@override @useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ServerFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NetworkFailure implements Failure {
   NetworkFailure(this.error);
  

@override final  String error;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'Failure.networkFailure(error: $error)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@override @useResult
$Res call({
 String error
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(NetworkFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FileFailure implements Failure {
   FileFailure(this.error);
  

@override final  String error;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileFailureCopyWith<FileFailure> get copyWith => _$FileFailureCopyWithImpl<FileFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'Failure.fileFailure(error: $error)';
}


}

/// @nodoc
abstract mixin class $FileFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $FileFailureCopyWith(FileFailure value, $Res Function(FileFailure) _then) = _$FileFailureCopyWithImpl;
@override @useResult
$Res call({
 String error
});




}
/// @nodoc
class _$FileFailureCopyWithImpl<$Res>
    implements $FileFailureCopyWith<$Res> {
  _$FileFailureCopyWithImpl(this._self, this._then);

  final FileFailure _self;
  final $Res Function(FileFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(FileFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
