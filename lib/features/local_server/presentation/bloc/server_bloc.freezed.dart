// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServerEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerEvent()';
}


}

/// @nodoc
class $ServerEventCopyWith<$Res>  {
$ServerEventCopyWith(ServerEvent _, $Res Function(ServerEvent) __);
}


/// Adds pattern-matching-related methods to [ServerEvent].
extension ServerEventPatterns on ServerEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StartServer value)?  startServer,TResult Function( StopServer value)?  stopServer,TResult Function( AddFile value)?  addFile,TResult Function( RemoveFile value)?  removeFile,TResult Function( GetServerInfo value)?  getServerInfo,TResult Function( SharedFilesUpdated value)?  sharedFilesUpdated,TResult Function( ThemeChanged value)?  themeChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StartServer() when startServer != null:
return startServer(_that);case StopServer() when stopServer != null:
return stopServer(_that);case AddFile() when addFile != null:
return addFile(_that);case RemoveFile() when removeFile != null:
return removeFile(_that);case GetServerInfo() when getServerInfo != null:
return getServerInfo(_that);case SharedFilesUpdated() when sharedFilesUpdated != null:
return sharedFilesUpdated(_that);case ThemeChanged() when themeChanged != null:
return themeChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StartServer value)  startServer,required TResult Function( StopServer value)  stopServer,required TResult Function( AddFile value)  addFile,required TResult Function( RemoveFile value)  removeFile,required TResult Function( GetServerInfo value)  getServerInfo,required TResult Function( SharedFilesUpdated value)  sharedFilesUpdated,required TResult Function( ThemeChanged value)  themeChanged,}){
final _that = this;
switch (_that) {
case StartServer():
return startServer(_that);case StopServer():
return stopServer(_that);case AddFile():
return addFile(_that);case RemoveFile():
return removeFile(_that);case GetServerInfo():
return getServerInfo(_that);case SharedFilesUpdated():
return sharedFilesUpdated(_that);case ThemeChanged():
return themeChanged(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StartServer value)?  startServer,TResult? Function( StopServer value)?  stopServer,TResult? Function( AddFile value)?  addFile,TResult? Function( RemoveFile value)?  removeFile,TResult? Function( GetServerInfo value)?  getServerInfo,TResult? Function( SharedFilesUpdated value)?  sharedFilesUpdated,TResult? Function( ThemeChanged value)?  themeChanged,}){
final _that = this;
switch (_that) {
case StartServer() when startServer != null:
return startServer(_that);case StopServer() when stopServer != null:
return stopServer(_that);case AddFile() when addFile != null:
return addFile(_that);case RemoveFile() when removeFile != null:
return removeFile(_that);case GetServerInfo() when getServerInfo != null:
return getServerInfo(_that);case SharedFilesUpdated() when sharedFilesUpdated != null:
return sharedFilesUpdated(_that);case ThemeChanged() when themeChanged != null:
return themeChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  startServer,TResult Function()?  stopServer,TResult Function( String filePath)?  addFile,TResult Function( String filename)?  removeFile,TResult Function()?  getServerInfo,TResult Function( List<SharedFile> files)?  sharedFilesUpdated,TResult Function( bool isDark)?  themeChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StartServer() when startServer != null:
return startServer();case StopServer() when stopServer != null:
return stopServer();case AddFile() when addFile != null:
return addFile(_that.filePath);case RemoveFile() when removeFile != null:
return removeFile(_that.filename);case GetServerInfo() when getServerInfo != null:
return getServerInfo();case SharedFilesUpdated() when sharedFilesUpdated != null:
return sharedFilesUpdated(_that.files);case ThemeChanged() when themeChanged != null:
return themeChanged(_that.isDark);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  startServer,required TResult Function()  stopServer,required TResult Function( String filePath)  addFile,required TResult Function( String filename)  removeFile,required TResult Function()  getServerInfo,required TResult Function( List<SharedFile> files)  sharedFilesUpdated,required TResult Function( bool isDark)  themeChanged,}) {final _that = this;
switch (_that) {
case StartServer():
return startServer();case StopServer():
return stopServer();case AddFile():
return addFile(_that.filePath);case RemoveFile():
return removeFile(_that.filename);case GetServerInfo():
return getServerInfo();case SharedFilesUpdated():
return sharedFilesUpdated(_that.files);case ThemeChanged():
return themeChanged(_that.isDark);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  startServer,TResult? Function()?  stopServer,TResult? Function( String filePath)?  addFile,TResult? Function( String filename)?  removeFile,TResult? Function()?  getServerInfo,TResult? Function( List<SharedFile> files)?  sharedFilesUpdated,TResult? Function( bool isDark)?  themeChanged,}) {final _that = this;
switch (_that) {
case StartServer() when startServer != null:
return startServer();case StopServer() when stopServer != null:
return stopServer();case AddFile() when addFile != null:
return addFile(_that.filePath);case RemoveFile() when removeFile != null:
return removeFile(_that.filename);case GetServerInfo() when getServerInfo != null:
return getServerInfo();case SharedFilesUpdated() when sharedFilesUpdated != null:
return sharedFilesUpdated(_that.files);case ThemeChanged() when themeChanged != null:
return themeChanged(_that.isDark);case _:
  return null;

}
}

}

/// @nodoc


class StartServer implements ServerEvent {
  const StartServer();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartServer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerEvent.startServer()';
}


}




/// @nodoc


class StopServer implements ServerEvent {
  const StopServer();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StopServer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerEvent.stopServer()';
}


}




/// @nodoc


class AddFile implements ServerEvent {
  const AddFile(this.filePath);
  

 final  String filePath;

/// Create a copy of ServerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddFileCopyWith<AddFile> get copyWith => _$AddFileCopyWithImpl<AddFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddFile&&(identical(other.filePath, filePath) || other.filePath == filePath));
}


@override
int get hashCode => Object.hash(runtimeType,filePath);

@override
String toString() {
  return 'ServerEvent.addFile(filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class $AddFileCopyWith<$Res> implements $ServerEventCopyWith<$Res> {
  factory $AddFileCopyWith(AddFile value, $Res Function(AddFile) _then) = _$AddFileCopyWithImpl;
@useResult
$Res call({
 String filePath
});




}
/// @nodoc
class _$AddFileCopyWithImpl<$Res>
    implements $AddFileCopyWith<$Res> {
  _$AddFileCopyWithImpl(this._self, this._then);

  final AddFile _self;
  final $Res Function(AddFile) _then;

/// Create a copy of ServerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filePath = null,}) {
  return _then(AddFile(
null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RemoveFile implements ServerEvent {
  const RemoveFile(this.filename);
  

 final  String filename;

/// Create a copy of ServerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveFileCopyWith<RemoveFile> get copyWith => _$RemoveFileCopyWithImpl<RemoveFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveFile&&(identical(other.filename, filename) || other.filename == filename));
}


@override
int get hashCode => Object.hash(runtimeType,filename);

@override
String toString() {
  return 'ServerEvent.removeFile(filename: $filename)';
}


}

/// @nodoc
abstract mixin class $RemoveFileCopyWith<$Res> implements $ServerEventCopyWith<$Res> {
  factory $RemoveFileCopyWith(RemoveFile value, $Res Function(RemoveFile) _then) = _$RemoveFileCopyWithImpl;
@useResult
$Res call({
 String filename
});




}
/// @nodoc
class _$RemoveFileCopyWithImpl<$Res>
    implements $RemoveFileCopyWith<$Res> {
  _$RemoveFileCopyWithImpl(this._self, this._then);

  final RemoveFile _self;
  final $Res Function(RemoveFile) _then;

/// Create a copy of ServerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filename = null,}) {
  return _then(RemoveFile(
null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GetServerInfo implements ServerEvent {
  const GetServerInfo();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetServerInfo);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerEvent.getServerInfo()';
}


}




/// @nodoc


class SharedFilesUpdated implements ServerEvent {
  const SharedFilesUpdated(final  List<SharedFile> files): _files = files;
  

 final  List<SharedFile> _files;
 List<SharedFile> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}


/// Create a copy of ServerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedFilesUpdatedCopyWith<SharedFilesUpdated> get copyWith => _$SharedFilesUpdatedCopyWithImpl<SharedFilesUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedFilesUpdated&&const DeepCollectionEquality().equals(other._files, _files));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_files));

@override
String toString() {
  return 'ServerEvent.sharedFilesUpdated(files: $files)';
}


}

/// @nodoc
abstract mixin class $SharedFilesUpdatedCopyWith<$Res> implements $ServerEventCopyWith<$Res> {
  factory $SharedFilesUpdatedCopyWith(SharedFilesUpdated value, $Res Function(SharedFilesUpdated) _then) = _$SharedFilesUpdatedCopyWithImpl;
@useResult
$Res call({
 List<SharedFile> files
});




}
/// @nodoc
class _$SharedFilesUpdatedCopyWithImpl<$Res>
    implements $SharedFilesUpdatedCopyWith<$Res> {
  _$SharedFilesUpdatedCopyWithImpl(this._self, this._then);

  final SharedFilesUpdated _self;
  final $Res Function(SharedFilesUpdated) _then;

/// Create a copy of ServerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? files = null,}) {
  return _then(SharedFilesUpdated(
null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<SharedFile>,
  ));
}


}

/// @nodoc


class ThemeChanged implements ServerEvent {
  const ThemeChanged(this.isDark);
  

 final  bool isDark;

/// Create a copy of ServerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeChangedCopyWith<ThemeChanged> get copyWith => _$ThemeChangedCopyWithImpl<ThemeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeChanged&&(identical(other.isDark, isDark) || other.isDark == isDark));
}


@override
int get hashCode => Object.hash(runtimeType,isDark);

@override
String toString() {
  return 'ServerEvent.themeChanged(isDark: $isDark)';
}


}

/// @nodoc
abstract mixin class $ThemeChangedCopyWith<$Res> implements $ServerEventCopyWith<$Res> {
  factory $ThemeChangedCopyWith(ThemeChanged value, $Res Function(ThemeChanged) _then) = _$ThemeChangedCopyWithImpl;
@useResult
$Res call({
 bool isDark
});




}
/// @nodoc
class _$ThemeChangedCopyWithImpl<$Res>
    implements $ThemeChangedCopyWith<$Res> {
  _$ThemeChangedCopyWithImpl(this._self, this._then);

  final ThemeChanged _self;
  final $Res Function(ThemeChanged) _then;

/// Create a copy of ServerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isDark = null,}) {
  return _then(ThemeChanged(
null == isDark ? _self.isDark : isDark // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ServerState {

 bool get isLoading; String? get error; ServerInfo? get serverInfo;
/// Create a copy of ServerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerStateCopyWith<ServerState> get copyWith => _$ServerStateCopyWithImpl<ServerState>(this as ServerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.serverInfo, serverInfo) || other.serverInfo == serverInfo));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,serverInfo);

@override
String toString() {
  return 'ServerState(isLoading: $isLoading, error: $error, serverInfo: $serverInfo)';
}


}

/// @nodoc
abstract mixin class $ServerStateCopyWith<$Res>  {
  factory $ServerStateCopyWith(ServerState value, $Res Function(ServerState) _then) = _$ServerStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? error, ServerInfo? serverInfo
});




}
/// @nodoc
class _$ServerStateCopyWithImpl<$Res>
    implements $ServerStateCopyWith<$Res> {
  _$ServerStateCopyWithImpl(this._self, this._then);

  final ServerState _self;
  final $Res Function(ServerState) _then;

/// Create a copy of ServerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = freezed,Object? serverInfo = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,serverInfo: freezed == serverInfo ? _self.serverInfo : serverInfo // ignore: cast_nullable_to_non_nullable
as ServerInfo?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerState].
extension ServerStatePatterns on ServerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerState value)  $default,){
final _that = this;
switch (_that) {
case _ServerState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerState value)?  $default,){
final _that = this;
switch (_that) {
case _ServerState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  ServerInfo? serverInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerState() when $default != null:
return $default(_that.isLoading,_that.error,_that.serverInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  ServerInfo? serverInfo)  $default,) {final _that = this;
switch (_that) {
case _ServerState():
return $default(_that.isLoading,_that.error,_that.serverInfo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String? error,  ServerInfo? serverInfo)?  $default,) {final _that = this;
switch (_that) {
case _ServerState() when $default != null:
return $default(_that.isLoading,_that.error,_that.serverInfo);case _:
  return null;

}
}

}

/// @nodoc


class _ServerState implements ServerState {
  const _ServerState({required this.isLoading, this.error, this.serverInfo});
  

@override final  bool isLoading;
@override final  String? error;
@override final  ServerInfo? serverInfo;

/// Create a copy of ServerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerStateCopyWith<_ServerState> get copyWith => __$ServerStateCopyWithImpl<_ServerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.serverInfo, serverInfo) || other.serverInfo == serverInfo));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,serverInfo);

@override
String toString() {
  return 'ServerState(isLoading: $isLoading, error: $error, serverInfo: $serverInfo)';
}


}

/// @nodoc
abstract mixin class _$ServerStateCopyWith<$Res> implements $ServerStateCopyWith<$Res> {
  factory _$ServerStateCopyWith(_ServerState value, $Res Function(_ServerState) _then) = __$ServerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? error, ServerInfo? serverInfo
});




}
/// @nodoc
class __$ServerStateCopyWithImpl<$Res>
    implements _$ServerStateCopyWith<$Res> {
  __$ServerStateCopyWithImpl(this._self, this._then);

  final _ServerState _self;
  final $Res Function(_ServerState) _then;

/// Create a copy of ServerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = freezed,Object? serverInfo = freezed,}) {
  return _then(_ServerState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,serverInfo: freezed == serverInfo ? _self.serverInfo : serverInfo // ignore: cast_nullable_to_non_nullable
as ServerInfo?,
  ));
}


}

// dart format on
