// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/add_service/bloc/add_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddServiceState {

 SplitsbyError get error; String get serviceId; bool get showCannotBe0ZeroError; String get nameErrorText; Person get payer; String get currency; List<Person> get participants; Group? get group; SubscriptionService? get service;
/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddServiceStateCopyWith<AddServiceState> get copyWith => _$AddServiceStateCopyWithImpl<AddServiceState>(this as AddServiceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddServiceState&&(identical(other.error, error) || other.error == error)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.showCannotBe0ZeroError, showCannotBe0ZeroError) || other.showCannotBe0ZeroError == showCannotBe0ZeroError)&&(identical(other.nameErrorText, nameErrorText) || other.nameErrorText == nameErrorText)&&(identical(other.payer, payer) || other.payer == payer)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.group, group) || other.group == group)&&(identical(other.service, service) || other.service == service));
}


@override
int get hashCode => Object.hash(runtimeType,error,serviceId,showCannotBe0ZeroError,nameErrorText,payer,currency,const DeepCollectionEquality().hash(participants),group,service);

@override
String toString() {
  return 'AddServiceState(error: $error, serviceId: $serviceId, showCannotBe0ZeroError: $showCannotBe0ZeroError, nameErrorText: $nameErrorText, payer: $payer, currency: $currency, participants: $participants, group: $group, service: $service)';
}


}

/// @nodoc
abstract mixin class $AddServiceStateCopyWith<$Res>  {
  factory $AddServiceStateCopyWith(AddServiceState value, $Res Function(AddServiceState) _then) = _$AddServiceStateCopyWithImpl;
@useResult
$Res call({
 SplitsbyError error, String serviceId, bool showCannotBe0ZeroError, String nameErrorText, Person payer, String currency, List<Person> participants, Group? group, SubscriptionService? service
});


$PersonCopyWith<$Res> get payer;$GroupCopyWith<$Res>? get group;$SubscriptionServiceCopyWith<$Res>? get service;

}
/// @nodoc
class _$AddServiceStateCopyWithImpl<$Res>
    implements $AddServiceStateCopyWith<$Res> {
  _$AddServiceStateCopyWithImpl(this._self, this._then);

  final AddServiceState _self;
  final $Res Function(AddServiceState) _then;

/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? serviceId = null,Object? showCannotBe0ZeroError = null,Object? nameErrorText = null,Object? payer = null,Object? currency = null,Object? participants = null,Object? group = freezed,Object? service = freezed,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,showCannotBe0ZeroError: null == showCannotBe0ZeroError ? _self.showCannotBe0ZeroError : showCannotBe0ZeroError // ignore: cast_nullable_to_non_nullable
as bool,nameErrorText: null == nameErrorText ? _self.nameErrorText : nameErrorText // ignore: cast_nullable_to_non_nullable
as String,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as Person,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<Person>,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as SubscriptionService?,
  ));
}
/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get payer {
  
  return $PersonCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res>? get group {
    if (_self.group == null) {
    return null;
  }

  return $GroupCopyWith<$Res>(_self.group!, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionServiceCopyWith<$Res>? get service {
    if (_self.service == null) {
    return null;
  }

  return $SubscriptionServiceCopyWith<$Res>(_self.service!, (value) {
    return _then(_self.copyWith(service: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddServiceState].
extension AddServiceStatePatterns on AddServiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddServiceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddServiceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddServiceState value)  $default,){
final _that = this;
switch (_that) {
case _AddServiceState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddServiceState value)?  $default,){
final _that = this;
switch (_that) {
case _AddServiceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SplitsbyError error,  String serviceId,  bool showCannotBe0ZeroError,  String nameErrorText,  Person payer,  String currency,  List<Person> participants,  Group? group,  SubscriptionService? service)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddServiceState() when $default != null:
return $default(_that.error,_that.serviceId,_that.showCannotBe0ZeroError,_that.nameErrorText,_that.payer,_that.currency,_that.participants,_that.group,_that.service);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SplitsbyError error,  String serviceId,  bool showCannotBe0ZeroError,  String nameErrorText,  Person payer,  String currency,  List<Person> participants,  Group? group,  SubscriptionService? service)  $default,) {final _that = this;
switch (_that) {
case _AddServiceState():
return $default(_that.error,_that.serviceId,_that.showCannotBe0ZeroError,_that.nameErrorText,_that.payer,_that.currency,_that.participants,_that.group,_that.service);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SplitsbyError error,  String serviceId,  bool showCannotBe0ZeroError,  String nameErrorText,  Person payer,  String currency,  List<Person> participants,  Group? group,  SubscriptionService? service)?  $default,) {final _that = this;
switch (_that) {
case _AddServiceState() when $default != null:
return $default(_that.error,_that.serviceId,_that.showCannotBe0ZeroError,_that.nameErrorText,_that.payer,_that.currency,_that.participants,_that.group,_that.service);case _:
  return null;

}
}

}

/// @nodoc


class _AddServiceState extends AddServiceState {
  const _AddServiceState({this.error = const SplitsbyError.none(), this.serviceId = "", this.showCannotBe0ZeroError = false, this.nameErrorText = "", required this.payer, this.currency = "", final  List<Person> participants = const [], this.group, this.service}): _participants = participants,super._();
  

@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  String serviceId;
@override@JsonKey() final  bool showCannotBe0ZeroError;
@override@JsonKey() final  String nameErrorText;
@override final  Person payer;
@override@JsonKey() final  String currency;
 final  List<Person> _participants;
@override@JsonKey() List<Person> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  Group? group;
@override final  SubscriptionService? service;

/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddServiceStateCopyWith<_AddServiceState> get copyWith => __$AddServiceStateCopyWithImpl<_AddServiceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddServiceState&&(identical(other.error, error) || other.error == error)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.showCannotBe0ZeroError, showCannotBe0ZeroError) || other.showCannotBe0ZeroError == showCannotBe0ZeroError)&&(identical(other.nameErrorText, nameErrorText) || other.nameErrorText == nameErrorText)&&(identical(other.payer, payer) || other.payer == payer)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.group, group) || other.group == group)&&(identical(other.service, service) || other.service == service));
}


@override
int get hashCode => Object.hash(runtimeType,error,serviceId,showCannotBe0ZeroError,nameErrorText,payer,currency,const DeepCollectionEquality().hash(_participants),group,service);

@override
String toString() {
  return 'AddServiceState(error: $error, serviceId: $serviceId, showCannotBe0ZeroError: $showCannotBe0ZeroError, nameErrorText: $nameErrorText, payer: $payer, currency: $currency, participants: $participants, group: $group, service: $service)';
}


}

/// @nodoc
abstract mixin class _$AddServiceStateCopyWith<$Res> implements $AddServiceStateCopyWith<$Res> {
  factory _$AddServiceStateCopyWith(_AddServiceState value, $Res Function(_AddServiceState) _then) = __$AddServiceStateCopyWithImpl;
@override @useResult
$Res call({
 SplitsbyError error, String serviceId, bool showCannotBe0ZeroError, String nameErrorText, Person payer, String currency, List<Person> participants, Group? group, SubscriptionService? service
});


@override $PersonCopyWith<$Res> get payer;@override $GroupCopyWith<$Res>? get group;@override $SubscriptionServiceCopyWith<$Res>? get service;

}
/// @nodoc
class __$AddServiceStateCopyWithImpl<$Res>
    implements _$AddServiceStateCopyWith<$Res> {
  __$AddServiceStateCopyWithImpl(this._self, this._then);

  final _AddServiceState _self;
  final $Res Function(_AddServiceState) _then;

/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? serviceId = null,Object? showCannotBe0ZeroError = null,Object? nameErrorText = null,Object? payer = null,Object? currency = null,Object? participants = null,Object? group = freezed,Object? service = freezed,}) {
  return _then(_AddServiceState(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,showCannotBe0ZeroError: null == showCannotBe0ZeroError ? _self.showCannotBe0ZeroError : showCannotBe0ZeroError // ignore: cast_nullable_to_non_nullable
as bool,nameErrorText: null == nameErrorText ? _self.nameErrorText : nameErrorText // ignore: cast_nullable_to_non_nullable
as String,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as Person,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<Person>,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as SubscriptionService?,
  ));
}

/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get payer {
  
  return $PersonCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res>? get group {
    if (_self.group == null) {
    return null;
  }

  return $GroupCopyWith<$Res>(_self.group!, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionServiceCopyWith<$Res>? get service {
    if (_self.service == null) {
    return null;
  }

  return $SubscriptionServiceCopyWith<$Res>(_self.service!, (value) {
    return _then(_self.copyWith(service: value));
  });
}
}

// dart format on
