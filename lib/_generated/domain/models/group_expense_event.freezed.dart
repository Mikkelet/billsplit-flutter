// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../domain/models/group_expense_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupExpense {

 String get id; Person get payer; Person get createdBy; String get description; List<SharedExpense> get sharedExpenses; SyncState get syncState; Currency get currency; List<Person> get tempParticipants; String get receiptImageUrl; String get date; int get timestamp; List<Surcharge> get surcharges;
/// Create a copy of GroupExpense
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupExpenseCopyWith<GroupExpense> get copyWith => _$GroupExpenseCopyWithImpl<GroupExpense>(this as GroupExpense, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupExpense&&(identical(other.id, id) || other.id == id)&&(identical(other.payer, payer) || other.payer == payer)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.sharedExpenses, sharedExpenses)&&(identical(other.syncState, syncState) || other.syncState == syncState)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.tempParticipants, tempParticipants)&&(identical(other.receiptImageUrl, receiptImageUrl) || other.receiptImageUrl == receiptImageUrl)&&(identical(other.date, date) || other.date == date)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.surcharges, surcharges));
}


@override
int get hashCode => Object.hash(runtimeType,id,payer,createdBy,description,const DeepCollectionEquality().hash(sharedExpenses),syncState,currency,const DeepCollectionEquality().hash(tempParticipants),receiptImageUrl,date,timestamp,const DeepCollectionEquality().hash(surcharges));

@override
String toString() {
  return 'GroupExpense(id: $id, payer: $payer, createdBy: $createdBy, description: $description, sharedExpenses: $sharedExpenses, syncState: $syncState, currency: $currency, tempParticipants: $tempParticipants, receiptImageUrl: $receiptImageUrl, date: $date, timestamp: $timestamp, surcharges: $surcharges)';
}


}

/// @nodoc
abstract mixin class $GroupExpenseCopyWith<$Res>  {
  factory $GroupExpenseCopyWith(GroupExpense value, $Res Function(GroupExpense) _then) = _$GroupExpenseCopyWithImpl;
@useResult
$Res call({
 String id, Person payer, Person createdBy, String description, List<SharedExpense> sharedExpenses, SyncState syncState, Currency currency, List<Person> tempParticipants, String receiptImageUrl, String date, int timestamp, List<Surcharge> surcharges
});


$PersonCopyWith<$Res> get payer;$PersonCopyWith<$Res> get createdBy;

}
/// @nodoc
class _$GroupExpenseCopyWithImpl<$Res>
    implements $GroupExpenseCopyWith<$Res> {
  _$GroupExpenseCopyWithImpl(this._self, this._then);

  final GroupExpense _self;
  final $Res Function(GroupExpense) _then;

/// Create a copy of GroupExpense
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? payer = null,Object? createdBy = null,Object? description = null,Object? sharedExpenses = null,Object? syncState = null,Object? currency = null,Object? tempParticipants = null,Object? receiptImageUrl = null,Object? date = null,Object? timestamp = null,Object? surcharges = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as Person,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as Person,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sharedExpenses: null == sharedExpenses ? _self.sharedExpenses : sharedExpenses // ignore: cast_nullable_to_non_nullable
as List<SharedExpense>,syncState: null == syncState ? _self.syncState : syncState // ignore: cast_nullable_to_non_nullable
as SyncState,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,tempParticipants: null == tempParticipants ? _self.tempParticipants : tempParticipants // ignore: cast_nullable_to_non_nullable
as List<Person>,receiptImageUrl: null == receiptImageUrl ? _self.receiptImageUrl : receiptImageUrl // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,surcharges: null == surcharges ? _self.surcharges : surcharges // ignore: cast_nullable_to_non_nullable
as List<Surcharge>,
  ));
}
/// Create a copy of GroupExpense
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get payer {
  
  return $PersonCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}/// Create a copy of GroupExpense
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get createdBy {
  
  return $PersonCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [GroupExpense].
extension GroupExpensePatterns on GroupExpense {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupExpense value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupExpense() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupExpense value)  $default,){
final _that = this;
switch (_that) {
case _GroupExpense():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupExpense value)?  $default,){
final _that = this;
switch (_that) {
case _GroupExpense() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Person payer,  Person createdBy,  String description,  List<SharedExpense> sharedExpenses,  SyncState syncState,  Currency currency,  List<Person> tempParticipants,  String receiptImageUrl,  String date,  int timestamp,  List<Surcharge> surcharges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupExpense() when $default != null:
return $default(_that.id,_that.payer,_that.createdBy,_that.description,_that.sharedExpenses,_that.syncState,_that.currency,_that.tempParticipants,_that.receiptImageUrl,_that.date,_that.timestamp,_that.surcharges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Person payer,  Person createdBy,  String description,  List<SharedExpense> sharedExpenses,  SyncState syncState,  Currency currency,  List<Person> tempParticipants,  String receiptImageUrl,  String date,  int timestamp,  List<Surcharge> surcharges)  $default,) {final _that = this;
switch (_that) {
case _GroupExpense():
return $default(_that.id,_that.payer,_that.createdBy,_that.description,_that.sharedExpenses,_that.syncState,_that.currency,_that.tempParticipants,_that.receiptImageUrl,_that.date,_that.timestamp,_that.surcharges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Person payer,  Person createdBy,  String description,  List<SharedExpense> sharedExpenses,  SyncState syncState,  Currency currency,  List<Person> tempParticipants,  String receiptImageUrl,  String date,  int timestamp,  List<Surcharge> surcharges)?  $default,) {final _that = this;
switch (_that) {
case _GroupExpense() when $default != null:
return $default(_that.id,_that.payer,_that.createdBy,_that.description,_that.sharedExpenses,_that.syncState,_that.currency,_that.tempParticipants,_that.receiptImageUrl,_that.date,_that.timestamp,_that.surcharges);case _:
  return null;

}
}

}

/// @nodoc


class _GroupExpense extends GroupExpense {
  const _GroupExpense({this.id = "", this.payer = const Person(), this.createdBy = const Person(), this.description = "", final  List<SharedExpense> sharedExpenses = const [], this.syncState = SyncState.pending, this.currency = Currency.usdValue, final  List<Person> tempParticipants = const [], this.receiptImageUrl = "", this.date = "", this.timestamp = 0, final  List<Surcharge> surcharges = const []}): _sharedExpenses = sharedExpenses,_tempParticipants = tempParticipants,_surcharges = surcharges,super._();
  

@override@JsonKey() final  String id;
@override@JsonKey() final  Person payer;
@override@JsonKey() final  Person createdBy;
@override@JsonKey() final  String description;
 final  List<SharedExpense> _sharedExpenses;
@override@JsonKey() List<SharedExpense> get sharedExpenses {
  if (_sharedExpenses is EqualUnmodifiableListView) return _sharedExpenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedExpenses);
}

@override@JsonKey() final  SyncState syncState;
@override@JsonKey() final  Currency currency;
 final  List<Person> _tempParticipants;
@override@JsonKey() List<Person> get tempParticipants {
  if (_tempParticipants is EqualUnmodifiableListView) return _tempParticipants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tempParticipants);
}

@override@JsonKey() final  String receiptImageUrl;
@override@JsonKey() final  String date;
@override@JsonKey() final  int timestamp;
 final  List<Surcharge> _surcharges;
@override@JsonKey() List<Surcharge> get surcharges {
  if (_surcharges is EqualUnmodifiableListView) return _surcharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surcharges);
}


/// Create a copy of GroupExpense
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupExpenseCopyWith<_GroupExpense> get copyWith => __$GroupExpenseCopyWithImpl<_GroupExpense>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupExpense&&(identical(other.id, id) || other.id == id)&&(identical(other.payer, payer) || other.payer == payer)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._sharedExpenses, _sharedExpenses)&&(identical(other.syncState, syncState) || other.syncState == syncState)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._tempParticipants, _tempParticipants)&&(identical(other.receiptImageUrl, receiptImageUrl) || other.receiptImageUrl == receiptImageUrl)&&(identical(other.date, date) || other.date == date)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._surcharges, _surcharges));
}


@override
int get hashCode => Object.hash(runtimeType,id,payer,createdBy,description,const DeepCollectionEquality().hash(_sharedExpenses),syncState,currency,const DeepCollectionEquality().hash(_tempParticipants),receiptImageUrl,date,timestamp,const DeepCollectionEquality().hash(_surcharges));

@override
String toString() {
  return 'GroupExpense(id: $id, payer: $payer, createdBy: $createdBy, description: $description, sharedExpenses: $sharedExpenses, syncState: $syncState, currency: $currency, tempParticipants: $tempParticipants, receiptImageUrl: $receiptImageUrl, date: $date, timestamp: $timestamp, surcharges: $surcharges)';
}


}

/// @nodoc
abstract mixin class _$GroupExpenseCopyWith<$Res> implements $GroupExpenseCopyWith<$Res> {
  factory _$GroupExpenseCopyWith(_GroupExpense value, $Res Function(_GroupExpense) _then) = __$GroupExpenseCopyWithImpl;
@override @useResult
$Res call({
 String id, Person payer, Person createdBy, String description, List<SharedExpense> sharedExpenses, SyncState syncState, Currency currency, List<Person> tempParticipants, String receiptImageUrl, String date, int timestamp, List<Surcharge> surcharges
});


@override $PersonCopyWith<$Res> get payer;@override $PersonCopyWith<$Res> get createdBy;

}
/// @nodoc
class __$GroupExpenseCopyWithImpl<$Res>
    implements _$GroupExpenseCopyWith<$Res> {
  __$GroupExpenseCopyWithImpl(this._self, this._then);

  final _GroupExpense _self;
  final $Res Function(_GroupExpense) _then;

/// Create a copy of GroupExpense
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? payer = null,Object? createdBy = null,Object? description = null,Object? sharedExpenses = null,Object? syncState = null,Object? currency = null,Object? tempParticipants = null,Object? receiptImageUrl = null,Object? date = null,Object? timestamp = null,Object? surcharges = null,}) {
  return _then(_GroupExpense(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as Person,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as Person,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sharedExpenses: null == sharedExpenses ? _self._sharedExpenses : sharedExpenses // ignore: cast_nullable_to_non_nullable
as List<SharedExpense>,syncState: null == syncState ? _self.syncState : syncState // ignore: cast_nullable_to_non_nullable
as SyncState,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,tempParticipants: null == tempParticipants ? _self._tempParticipants : tempParticipants // ignore: cast_nullable_to_non_nullable
as List<Person>,receiptImageUrl: null == receiptImageUrl ? _self.receiptImageUrl : receiptImageUrl // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,surcharges: null == surcharges ? _self._surcharges : surcharges // ignore: cast_nullable_to_non_nullable
as List<Surcharge>,
  ));
}

/// Create a copy of GroupExpense
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get payer {
  
  return $PersonCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}/// Create a copy of GroupExpense
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get createdBy {
  
  return $PersonCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}

// dart format on
