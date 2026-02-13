// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_trivia_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NumberTriviaEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberTriviaEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NumberTriviaEvent()';
}


}

/// @nodoc
class $NumberTriviaEventCopyWith<$Res>  {
$NumberTriviaEventCopyWith(NumberTriviaEvent _, $Res Function(NumberTriviaEvent) __);
}


/// Adds pattern-matching-related methods to [NumberTriviaEvent].
extension NumberTriviaEventPatterns on NumberTriviaEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetTrivia value)?  getTrivia,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetTrivia() when getTrivia != null:
return getTrivia(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetTrivia value)  getTrivia,}){
final _that = this;
switch (_that) {
case GetTrivia():
return getTrivia(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetTrivia value)?  getTrivia,}){
final _that = this;
switch (_that) {
case GetTrivia() when getTrivia != null:
return getTrivia(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  getTrivia,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetTrivia() when getTrivia != null:
return getTrivia();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  getTrivia,}) {final _that = this;
switch (_that) {
case GetTrivia():
return getTrivia();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  getTrivia,}) {final _that = this;
switch (_that) {
case GetTrivia() when getTrivia != null:
return getTrivia();case _:
  return null;

}
}

}

/// @nodoc


class GetTrivia implements NumberTriviaEvent {
  const GetTrivia();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTrivia);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NumberTriviaEvent.getTrivia()';
}


}




/// @nodoc
mixin _$NumberTriviaState {

 bool get isLoading; String? get error; TriviaEntity? get trivia;
/// Create a copy of NumberTriviaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberTriviaStateCopyWith<NumberTriviaState> get copyWith => _$NumberTriviaStateCopyWithImpl<NumberTriviaState>(this as NumberTriviaState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberTriviaState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.trivia, trivia) || other.trivia == trivia));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,trivia);

@override
String toString() {
  return 'NumberTriviaState(isLoading: $isLoading, error: $error, trivia: $trivia)';
}


}

/// @nodoc
abstract mixin class $NumberTriviaStateCopyWith<$Res>  {
  factory $NumberTriviaStateCopyWith(NumberTriviaState value, $Res Function(NumberTriviaState) _then) = _$NumberTriviaStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? error, TriviaEntity? trivia
});




}
/// @nodoc
class _$NumberTriviaStateCopyWithImpl<$Res>
    implements $NumberTriviaStateCopyWith<$Res> {
  _$NumberTriviaStateCopyWithImpl(this._self, this._then);

  final NumberTriviaState _self;
  final $Res Function(NumberTriviaState) _then;

/// Create a copy of NumberTriviaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = freezed,Object? trivia = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,trivia: freezed == trivia ? _self.trivia : trivia // ignore: cast_nullable_to_non_nullable
as TriviaEntity?,
  ));
}

}


/// Adds pattern-matching-related methods to [NumberTriviaState].
extension NumberTriviaStatePatterns on NumberTriviaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Initial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Initial value)  $default,){
final _that = this;
switch (_that) {
case _Initial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Initial value)?  $default,){
final _that = this;
switch (_that) {
case _Initial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  TriviaEntity? trivia)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when $default != null:
return $default(_that.isLoading,_that.error,_that.trivia);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  TriviaEntity? trivia)  $default,) {final _that = this;
switch (_that) {
case _Initial():
return $default(_that.isLoading,_that.error,_that.trivia);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String? error,  TriviaEntity? trivia)?  $default,) {final _that = this;
switch (_that) {
case _Initial() when $default != null:
return $default(_that.isLoading,_that.error,_that.trivia);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements NumberTriviaState {
  const _Initial({required this.isLoading, this.error, this.trivia});
  

@override final  bool isLoading;
@override final  String? error;
@override final  TriviaEntity? trivia;

/// Create a copy of NumberTriviaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.trivia, trivia) || other.trivia == trivia));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,trivia);

@override
String toString() {
  return 'NumberTriviaState(isLoading: $isLoading, error: $error, trivia: $trivia)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $NumberTriviaStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? error, TriviaEntity? trivia
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of NumberTriviaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = freezed,Object? trivia = freezed,}) {
  return _then(_Initial(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,trivia: freezed == trivia ? _self.trivia : trivia // ignore: cast_nullable_to_non_nullable
as TriviaEntity?,
  ));
}


}

// dart format on
