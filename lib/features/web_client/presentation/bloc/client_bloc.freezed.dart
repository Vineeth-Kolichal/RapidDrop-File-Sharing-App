// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientEvent()';
}


}

/// @nodoc
class $ClientEventCopyWith<$Res>  {
$ClientEventCopyWith(ClientEvent _, $Res Function(ClientEvent) __);
}


/// Adds pattern-matching-related methods to [ClientEvent].
extension ClientEventPatterns on ClientEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Connect value)?  connect,TResult Function( ValidatePin value)?  validatePin,TResult Function( Disconnect value)?  disconnect,TResult Function( FetchFiles value)?  fetchFiles,TResult Function( UploadFile value)?  uploadFile,TResult Function( DeleteFile value)?  deleteFile,TResult Function( StartAutoRefresh value)?  startAutoRefresh,TResult Function( StopAutoRefresh value)?  stopAutoRefresh,TResult Function( _UpdateUploadProgress value)?  updateUploadProgress,TResult Function( _NotificationReceived value)?  notificationReceived,TResult Function( _ThemeChanged value)?  themeChanged,TResult Function( _ConnectionStatusChanged value)?  connectionStatusChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Connect() when connect != null:
return connect(_that);case ValidatePin() when validatePin != null:
return validatePin(_that);case Disconnect() when disconnect != null:
return disconnect(_that);case FetchFiles() when fetchFiles != null:
return fetchFiles(_that);case UploadFile() when uploadFile != null:
return uploadFile(_that);case DeleteFile() when deleteFile != null:
return deleteFile(_that);case StartAutoRefresh() when startAutoRefresh != null:
return startAutoRefresh(_that);case StopAutoRefresh() when stopAutoRefresh != null:
return stopAutoRefresh(_that);case _UpdateUploadProgress() when updateUploadProgress != null:
return updateUploadProgress(_that);case _NotificationReceived() when notificationReceived != null:
return notificationReceived(_that);case _ThemeChanged() when themeChanged != null:
return themeChanged(_that);case _ConnectionStatusChanged() when connectionStatusChanged != null:
return connectionStatusChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Connect value)  connect,required TResult Function( ValidatePin value)  validatePin,required TResult Function( Disconnect value)  disconnect,required TResult Function( FetchFiles value)  fetchFiles,required TResult Function( UploadFile value)  uploadFile,required TResult Function( DeleteFile value)  deleteFile,required TResult Function( StartAutoRefresh value)  startAutoRefresh,required TResult Function( StopAutoRefresh value)  stopAutoRefresh,required TResult Function( _UpdateUploadProgress value)  updateUploadProgress,required TResult Function( _NotificationReceived value)  notificationReceived,required TResult Function( _ThemeChanged value)  themeChanged,required TResult Function( _ConnectionStatusChanged value)  connectionStatusChanged,}){
final _that = this;
switch (_that) {
case Connect():
return connect(_that);case ValidatePin():
return validatePin(_that);case Disconnect():
return disconnect(_that);case FetchFiles():
return fetchFiles(_that);case UploadFile():
return uploadFile(_that);case DeleteFile():
return deleteFile(_that);case StartAutoRefresh():
return startAutoRefresh(_that);case StopAutoRefresh():
return stopAutoRefresh(_that);case _UpdateUploadProgress():
return updateUploadProgress(_that);case _NotificationReceived():
return notificationReceived(_that);case _ThemeChanged():
return themeChanged(_that);case _ConnectionStatusChanged():
return connectionStatusChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Connect value)?  connect,TResult? Function( ValidatePin value)?  validatePin,TResult? Function( Disconnect value)?  disconnect,TResult? Function( FetchFiles value)?  fetchFiles,TResult? Function( UploadFile value)?  uploadFile,TResult? Function( DeleteFile value)?  deleteFile,TResult? Function( StartAutoRefresh value)?  startAutoRefresh,TResult? Function( StopAutoRefresh value)?  stopAutoRefresh,TResult? Function( _UpdateUploadProgress value)?  updateUploadProgress,TResult? Function( _NotificationReceived value)?  notificationReceived,TResult? Function( _ThemeChanged value)?  themeChanged,TResult? Function( _ConnectionStatusChanged value)?  connectionStatusChanged,}){
final _that = this;
switch (_that) {
case Connect() when connect != null:
return connect(_that);case ValidatePin() when validatePin != null:
return validatePin(_that);case Disconnect() when disconnect != null:
return disconnect(_that);case FetchFiles() when fetchFiles != null:
return fetchFiles(_that);case UploadFile() when uploadFile != null:
return uploadFile(_that);case DeleteFile() when deleteFile != null:
return deleteFile(_that);case StartAutoRefresh() when startAutoRefresh != null:
return startAutoRefresh(_that);case StopAutoRefresh() when stopAutoRefresh != null:
return stopAutoRefresh(_that);case _UpdateUploadProgress() when updateUploadProgress != null:
return updateUploadProgress(_that);case _NotificationReceived() when notificationReceived != null:
return notificationReceived(_that);case _ThemeChanged() when themeChanged != null:
return themeChanged(_that);case _ConnectionStatusChanged() when connectionStatusChanged != null:
return connectionStatusChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ip,  int port)?  connect,TResult Function( String pin)?  validatePin,TResult Function()?  disconnect,TResult Function( bool silent)?  fetchFiles,TResult Function( FileEntity file)?  uploadFile,TResult Function( String filename)?  deleteFile,TResult Function()?  startAutoRefresh,TResult Function()?  stopAutoRefresh,TResult Function( double progress)?  updateUploadProgress,TResult Function()?  notificationReceived,TResult Function( bool isDark)?  themeChanged,TResult Function( bool isConnected)?  connectionStatusChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Connect() when connect != null:
return connect(_that.ip,_that.port);case ValidatePin() when validatePin != null:
return validatePin(_that.pin);case Disconnect() when disconnect != null:
return disconnect();case FetchFiles() when fetchFiles != null:
return fetchFiles(_that.silent);case UploadFile() when uploadFile != null:
return uploadFile(_that.file);case DeleteFile() when deleteFile != null:
return deleteFile(_that.filename);case StartAutoRefresh() when startAutoRefresh != null:
return startAutoRefresh();case StopAutoRefresh() when stopAutoRefresh != null:
return stopAutoRefresh();case _UpdateUploadProgress() when updateUploadProgress != null:
return updateUploadProgress(_that.progress);case _NotificationReceived() when notificationReceived != null:
return notificationReceived();case _ThemeChanged() when themeChanged != null:
return themeChanged(_that.isDark);case _ConnectionStatusChanged() when connectionStatusChanged != null:
return connectionStatusChanged(_that.isConnected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ip,  int port)  connect,required TResult Function( String pin)  validatePin,required TResult Function()  disconnect,required TResult Function( bool silent)  fetchFiles,required TResult Function( FileEntity file)  uploadFile,required TResult Function( String filename)  deleteFile,required TResult Function()  startAutoRefresh,required TResult Function()  stopAutoRefresh,required TResult Function( double progress)  updateUploadProgress,required TResult Function()  notificationReceived,required TResult Function( bool isDark)  themeChanged,required TResult Function( bool isConnected)  connectionStatusChanged,}) {final _that = this;
switch (_that) {
case Connect():
return connect(_that.ip,_that.port);case ValidatePin():
return validatePin(_that.pin);case Disconnect():
return disconnect();case FetchFiles():
return fetchFiles(_that.silent);case UploadFile():
return uploadFile(_that.file);case DeleteFile():
return deleteFile(_that.filename);case StartAutoRefresh():
return startAutoRefresh();case StopAutoRefresh():
return stopAutoRefresh();case _UpdateUploadProgress():
return updateUploadProgress(_that.progress);case _NotificationReceived():
return notificationReceived();case _ThemeChanged():
return themeChanged(_that.isDark);case _ConnectionStatusChanged():
return connectionStatusChanged(_that.isConnected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ip,  int port)?  connect,TResult? Function( String pin)?  validatePin,TResult? Function()?  disconnect,TResult? Function( bool silent)?  fetchFiles,TResult? Function( FileEntity file)?  uploadFile,TResult? Function( String filename)?  deleteFile,TResult? Function()?  startAutoRefresh,TResult? Function()?  stopAutoRefresh,TResult? Function( double progress)?  updateUploadProgress,TResult? Function()?  notificationReceived,TResult? Function( bool isDark)?  themeChanged,TResult? Function( bool isConnected)?  connectionStatusChanged,}) {final _that = this;
switch (_that) {
case Connect() when connect != null:
return connect(_that.ip,_that.port);case ValidatePin() when validatePin != null:
return validatePin(_that.pin);case Disconnect() when disconnect != null:
return disconnect();case FetchFiles() when fetchFiles != null:
return fetchFiles(_that.silent);case UploadFile() when uploadFile != null:
return uploadFile(_that.file);case DeleteFile() when deleteFile != null:
return deleteFile(_that.filename);case StartAutoRefresh() when startAutoRefresh != null:
return startAutoRefresh();case StopAutoRefresh() when stopAutoRefresh != null:
return stopAutoRefresh();case _UpdateUploadProgress() when updateUploadProgress != null:
return updateUploadProgress(_that.progress);case _NotificationReceived() when notificationReceived != null:
return notificationReceived();case _ThemeChanged() when themeChanged != null:
return themeChanged(_that.isDark);case _ConnectionStatusChanged() when connectionStatusChanged != null:
return connectionStatusChanged(_that.isConnected);case _:
  return null;

}
}

}

/// @nodoc


class Connect implements ClientEvent {
  const Connect(this.ip, this.port);
  

 final  String ip;
 final  int port;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectCopyWith<Connect> get copyWith => _$ConnectCopyWithImpl<Connect>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Connect&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.port, port) || other.port == port));
}


@override
int get hashCode => Object.hash(runtimeType,ip,port);

@override
String toString() {
  return 'ClientEvent.connect(ip: $ip, port: $port)';
}


}

/// @nodoc
abstract mixin class $ConnectCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ConnectCopyWith(Connect value, $Res Function(Connect) _then) = _$ConnectCopyWithImpl;
@useResult
$Res call({
 String ip, int port
});




}
/// @nodoc
class _$ConnectCopyWithImpl<$Res>
    implements $ConnectCopyWith<$Res> {
  _$ConnectCopyWithImpl(this._self, this._then);

  final Connect _self;
  final $Res Function(Connect) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ip = null,Object? port = null,}) {
  return _then(Connect(
null == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String,null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ValidatePin implements ClientEvent {
  const ValidatePin(this.pin);
  

 final  String pin;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidatePinCopyWith<ValidatePin> get copyWith => _$ValidatePinCopyWithImpl<ValidatePin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidatePin&&(identical(other.pin, pin) || other.pin == pin));
}


@override
int get hashCode => Object.hash(runtimeType,pin);

@override
String toString() {
  return 'ClientEvent.validatePin(pin: $pin)';
}


}

/// @nodoc
abstract mixin class $ValidatePinCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ValidatePinCopyWith(ValidatePin value, $Res Function(ValidatePin) _then) = _$ValidatePinCopyWithImpl;
@useResult
$Res call({
 String pin
});




}
/// @nodoc
class _$ValidatePinCopyWithImpl<$Res>
    implements $ValidatePinCopyWith<$Res> {
  _$ValidatePinCopyWithImpl(this._self, this._then);

  final ValidatePin _self;
  final $Res Function(ValidatePin) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pin = null,}) {
  return _then(ValidatePin(
null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Disconnect implements ClientEvent {
  const Disconnect();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Disconnect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientEvent.disconnect()';
}


}




/// @nodoc


class FetchFiles implements ClientEvent {
  const FetchFiles({this.silent = false});
  

@JsonKey() final  bool silent;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchFilesCopyWith<FetchFiles> get copyWith => _$FetchFilesCopyWithImpl<FetchFiles>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchFiles&&(identical(other.silent, silent) || other.silent == silent));
}


@override
int get hashCode => Object.hash(runtimeType,silent);

@override
String toString() {
  return 'ClientEvent.fetchFiles(silent: $silent)';
}


}

/// @nodoc
abstract mixin class $FetchFilesCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $FetchFilesCopyWith(FetchFiles value, $Res Function(FetchFiles) _then) = _$FetchFilesCopyWithImpl;
@useResult
$Res call({
 bool silent
});




}
/// @nodoc
class _$FetchFilesCopyWithImpl<$Res>
    implements $FetchFilesCopyWith<$Res> {
  _$FetchFilesCopyWithImpl(this._self, this._then);

  final FetchFiles _self;
  final $Res Function(FetchFiles) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? silent = null,}) {
  return _then(FetchFiles(
silent: null == silent ? _self.silent : silent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class UploadFile implements ClientEvent {
  const UploadFile(this.file);
  

 final  FileEntity file;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadFileCopyWith<UploadFile> get copyWith => _$UploadFileCopyWithImpl<UploadFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadFile&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'ClientEvent.uploadFile(file: $file)';
}


}

/// @nodoc
abstract mixin class $UploadFileCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $UploadFileCopyWith(UploadFile value, $Res Function(UploadFile) _then) = _$UploadFileCopyWithImpl;
@useResult
$Res call({
 FileEntity file
});




}
/// @nodoc
class _$UploadFileCopyWithImpl<$Res>
    implements $UploadFileCopyWith<$Res> {
  _$UploadFileCopyWithImpl(this._self, this._then);

  final UploadFile _self;
  final $Res Function(UploadFile) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,}) {
  return _then(UploadFile(
null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as FileEntity,
  ));
}


}

/// @nodoc


class DeleteFile implements ClientEvent {
  const DeleteFile(this.filename);
  

 final  String filename;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteFileCopyWith<DeleteFile> get copyWith => _$DeleteFileCopyWithImpl<DeleteFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteFile&&(identical(other.filename, filename) || other.filename == filename));
}


@override
int get hashCode => Object.hash(runtimeType,filename);

@override
String toString() {
  return 'ClientEvent.deleteFile(filename: $filename)';
}


}

/// @nodoc
abstract mixin class $DeleteFileCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $DeleteFileCopyWith(DeleteFile value, $Res Function(DeleteFile) _then) = _$DeleteFileCopyWithImpl;
@useResult
$Res call({
 String filename
});




}
/// @nodoc
class _$DeleteFileCopyWithImpl<$Res>
    implements $DeleteFileCopyWith<$Res> {
  _$DeleteFileCopyWithImpl(this._self, this._then);

  final DeleteFile _self;
  final $Res Function(DeleteFile) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filename = null,}) {
  return _then(DeleteFile(
null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StartAutoRefresh implements ClientEvent {
  const StartAutoRefresh();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartAutoRefresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientEvent.startAutoRefresh()';
}


}




/// @nodoc


class StopAutoRefresh implements ClientEvent {
  const StopAutoRefresh();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StopAutoRefresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientEvent.stopAutoRefresh()';
}


}




/// @nodoc


class _UpdateUploadProgress implements ClientEvent {
  const _UpdateUploadProgress(this.progress);
  

 final  double progress;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUploadProgressCopyWith<_UpdateUploadProgress> get copyWith => __$UpdateUploadProgressCopyWithImpl<_UpdateUploadProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUploadProgress&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,progress);

@override
String toString() {
  return 'ClientEvent.updateUploadProgress(progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$UpdateUploadProgressCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory _$UpdateUploadProgressCopyWith(_UpdateUploadProgress value, $Res Function(_UpdateUploadProgress) _then) = __$UpdateUploadProgressCopyWithImpl;
@useResult
$Res call({
 double progress
});




}
/// @nodoc
class __$UpdateUploadProgressCopyWithImpl<$Res>
    implements _$UpdateUploadProgressCopyWith<$Res> {
  __$UpdateUploadProgressCopyWithImpl(this._self, this._then);

  final _UpdateUploadProgress _self;
  final $Res Function(_UpdateUploadProgress) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? progress = null,}) {
  return _then(_UpdateUploadProgress(
null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _NotificationReceived implements ClientEvent {
  const _NotificationReceived();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationReceived);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientEvent.notificationReceived()';
}


}




/// @nodoc


class _ThemeChanged implements ClientEvent {
  const _ThemeChanged(this.isDark);
  

 final  bool isDark;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeChangedCopyWith<_ThemeChanged> get copyWith => __$ThemeChangedCopyWithImpl<_ThemeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeChanged&&(identical(other.isDark, isDark) || other.isDark == isDark));
}


@override
int get hashCode => Object.hash(runtimeType,isDark);

@override
String toString() {
  return 'ClientEvent.themeChanged(isDark: $isDark)';
}


}

/// @nodoc
abstract mixin class _$ThemeChangedCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory _$ThemeChangedCopyWith(_ThemeChanged value, $Res Function(_ThemeChanged) _then) = __$ThemeChangedCopyWithImpl;
@useResult
$Res call({
 bool isDark
});




}
/// @nodoc
class __$ThemeChangedCopyWithImpl<$Res>
    implements _$ThemeChangedCopyWith<$Res> {
  __$ThemeChangedCopyWithImpl(this._self, this._then);

  final _ThemeChanged _self;
  final $Res Function(_ThemeChanged) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isDark = null,}) {
  return _then(_ThemeChanged(
null == isDark ? _self.isDark : isDark // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ConnectionStatusChanged implements ClientEvent {
  const _ConnectionStatusChanged(this.isConnected);
  

 final  bool isConnected;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionStatusChangedCopyWith<_ConnectionStatusChanged> get copyWith => __$ConnectionStatusChangedCopyWithImpl<_ConnectionStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionStatusChanged&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected);

@override
String toString() {
  return 'ClientEvent.connectionStatusChanged(isConnected: $isConnected)';
}


}

/// @nodoc
abstract mixin class _$ConnectionStatusChangedCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory _$ConnectionStatusChangedCopyWith(_ConnectionStatusChanged value, $Res Function(_ConnectionStatusChanged) _then) = __$ConnectionStatusChangedCopyWithImpl;
@useResult
$Res call({
 bool isConnected
});




}
/// @nodoc
class __$ConnectionStatusChangedCopyWithImpl<$Res>
    implements _$ConnectionStatusChangedCopyWith<$Res> {
  __$ConnectionStatusChangedCopyWithImpl(this._self, this._then);

  final _ConnectionStatusChanged _self;
  final $Res Function(_ConnectionStatusChanged) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isConnected = null,}) {
  return _then(_ConnectionStatusChanged(
null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ClientState {

 bool get isLoading; String? get error; ConnectionInfo? get connectionInfo; List<RemoteFile>? get fileList; double? get uploadProgress; bool? get isDarkMode; bool get isWebSocketConnected;
/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientStateCopyWith<ClientState> get copyWith => _$ClientStateCopyWithImpl<ClientState>(this as ClientState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.connectionInfo, connectionInfo) || other.connectionInfo == connectionInfo)&&const DeepCollectionEquality().equals(other.fileList, fileList)&&(identical(other.uploadProgress, uploadProgress) || other.uploadProgress == uploadProgress)&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode)&&(identical(other.isWebSocketConnected, isWebSocketConnected) || other.isWebSocketConnected == isWebSocketConnected));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,connectionInfo,const DeepCollectionEquality().hash(fileList),uploadProgress,isDarkMode,isWebSocketConnected);

@override
String toString() {
  return 'ClientState(isLoading: $isLoading, error: $error, connectionInfo: $connectionInfo, fileList: $fileList, uploadProgress: $uploadProgress, isDarkMode: $isDarkMode, isWebSocketConnected: $isWebSocketConnected)';
}


}

/// @nodoc
abstract mixin class $ClientStateCopyWith<$Res>  {
  factory $ClientStateCopyWith(ClientState value, $Res Function(ClientState) _then) = _$ClientStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? error, ConnectionInfo? connectionInfo, List<RemoteFile>? fileList, double? uploadProgress, bool? isDarkMode, bool isWebSocketConnected
});




}
/// @nodoc
class _$ClientStateCopyWithImpl<$Res>
    implements $ClientStateCopyWith<$Res> {
  _$ClientStateCopyWithImpl(this._self, this._then);

  final ClientState _self;
  final $Res Function(ClientState) _then;

/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = freezed,Object? connectionInfo = freezed,Object? fileList = freezed,Object? uploadProgress = freezed,Object? isDarkMode = freezed,Object? isWebSocketConnected = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,connectionInfo: freezed == connectionInfo ? _self.connectionInfo : connectionInfo // ignore: cast_nullable_to_non_nullable
as ConnectionInfo?,fileList: freezed == fileList ? _self.fileList : fileList // ignore: cast_nullable_to_non_nullable
as List<RemoteFile>?,uploadProgress: freezed == uploadProgress ? _self.uploadProgress : uploadProgress // ignore: cast_nullable_to_non_nullable
as double?,isDarkMode: freezed == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool?,isWebSocketConnected: null == isWebSocketConnected ? _self.isWebSocketConnected : isWebSocketConnected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientState].
extension ClientStatePatterns on ClientState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientState value)  $default,){
final _that = this;
switch (_that) {
case _ClientState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientState value)?  $default,){
final _that = this;
switch (_that) {
case _ClientState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  ConnectionInfo? connectionInfo,  List<RemoteFile>? fileList,  double? uploadProgress,  bool? isDarkMode,  bool isWebSocketConnected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientState() when $default != null:
return $default(_that.isLoading,_that.error,_that.connectionInfo,_that.fileList,_that.uploadProgress,_that.isDarkMode,_that.isWebSocketConnected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  ConnectionInfo? connectionInfo,  List<RemoteFile>? fileList,  double? uploadProgress,  bool? isDarkMode,  bool isWebSocketConnected)  $default,) {final _that = this;
switch (_that) {
case _ClientState():
return $default(_that.isLoading,_that.error,_that.connectionInfo,_that.fileList,_that.uploadProgress,_that.isDarkMode,_that.isWebSocketConnected);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String? error,  ConnectionInfo? connectionInfo,  List<RemoteFile>? fileList,  double? uploadProgress,  bool? isDarkMode,  bool isWebSocketConnected)?  $default,) {final _that = this;
switch (_that) {
case _ClientState() when $default != null:
return $default(_that.isLoading,_that.error,_that.connectionInfo,_that.fileList,_that.uploadProgress,_that.isDarkMode,_that.isWebSocketConnected);case _:
  return null;

}
}

}

/// @nodoc


class _ClientState implements ClientState {
  const _ClientState({required this.isLoading, this.error, this.connectionInfo, final  List<RemoteFile>? fileList, this.uploadProgress, this.isDarkMode, this.isWebSocketConnected = false}): _fileList = fileList;
  

@override final  bool isLoading;
@override final  String? error;
@override final  ConnectionInfo? connectionInfo;
 final  List<RemoteFile>? _fileList;
@override List<RemoteFile>? get fileList {
  final value = _fileList;
  if (value == null) return null;
  if (_fileList is EqualUnmodifiableListView) return _fileList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  double? uploadProgress;
@override final  bool? isDarkMode;
@override@JsonKey() final  bool isWebSocketConnected;

/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientStateCopyWith<_ClientState> get copyWith => __$ClientStateCopyWithImpl<_ClientState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.connectionInfo, connectionInfo) || other.connectionInfo == connectionInfo)&&const DeepCollectionEquality().equals(other._fileList, _fileList)&&(identical(other.uploadProgress, uploadProgress) || other.uploadProgress == uploadProgress)&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode)&&(identical(other.isWebSocketConnected, isWebSocketConnected) || other.isWebSocketConnected == isWebSocketConnected));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,connectionInfo,const DeepCollectionEquality().hash(_fileList),uploadProgress,isDarkMode,isWebSocketConnected);

@override
String toString() {
  return 'ClientState(isLoading: $isLoading, error: $error, connectionInfo: $connectionInfo, fileList: $fileList, uploadProgress: $uploadProgress, isDarkMode: $isDarkMode, isWebSocketConnected: $isWebSocketConnected)';
}


}

/// @nodoc
abstract mixin class _$ClientStateCopyWith<$Res> implements $ClientStateCopyWith<$Res> {
  factory _$ClientStateCopyWith(_ClientState value, $Res Function(_ClientState) _then) = __$ClientStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? error, ConnectionInfo? connectionInfo, List<RemoteFile>? fileList, double? uploadProgress, bool? isDarkMode, bool isWebSocketConnected
});




}
/// @nodoc
class __$ClientStateCopyWithImpl<$Res>
    implements _$ClientStateCopyWith<$Res> {
  __$ClientStateCopyWithImpl(this._self, this._then);

  final _ClientState _self;
  final $Res Function(_ClientState) _then;

/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = freezed,Object? connectionInfo = freezed,Object? fileList = freezed,Object? uploadProgress = freezed,Object? isDarkMode = freezed,Object? isWebSocketConnected = null,}) {
  return _then(_ClientState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,connectionInfo: freezed == connectionInfo ? _self.connectionInfo : connectionInfo // ignore: cast_nullable_to_non_nullable
as ConnectionInfo?,fileList: freezed == fileList ? _self._fileList : fileList // ignore: cast_nullable_to_non_nullable
as List<RemoteFile>?,uploadProgress: freezed == uploadProgress ? _self.uploadProgress : uploadProgress // ignore: cast_nullable_to_non_nullable
as double?,isDarkMode: freezed == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool?,isWebSocketConnected: null == isWebSocketConnected ? _self.isWebSocketConnected : isWebSocketConnected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
