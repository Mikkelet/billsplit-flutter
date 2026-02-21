// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../domain/models/shared_expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SharedExpense {

 num get expense; List<Person> get participants; String get description;
/// Create a copy of SharedExpense
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedExpenseCopyWith<SharedExpense> get copyWith => _$SharedExpenseCopyWithImpl<SharedExpense>(this as SharedExpense, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedExpense&&(identical(other.expense, expense) || other.expense == expense)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,expense,const DeepCollectionEquality().hash(participants),description);

@override
String toString() {
  return 'SharedExpense(expense: $expense, participants: $participants, description: $description)';
}


}

/// @nodoc
abstract mixin class $SharedExpenseCopyWith<$Res>  {
  factory $SharedExpenseCopyWith(SharedExpense value, $Res Function(SharedExpense) _then) = _$SharedExpenseCopyWithImpl;
@useResult
$Res call({
 num expense, List<Person> participants, String description
});




}
/// @nodoc
class _$SharedExpenseCopyWithImpl<$Res>
    implements $SharedExpenseCopyWith<$Res> {
  _$SharedExpenseCopyWithImpl(this._self, this._then);

  final SharedExpense _self;
  final $Res Function(SharedExpense) _then;

/// Create a copy of SharedExpense
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expense = null,Object? participants = null,Object? description = null,}) {
  return _then(_self.copyWith(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as num,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<Person>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedExpense].
extension SharedExpensePatterns on SharedExpense {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedExpense value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedExpense() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedExpense value)  $default,){
final _that = this;
switch (_that) {
case _SharedExpense():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedExpense value)?  $default,){
final _that = this;
switch (_that) {
case _SharedExpense() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num expense,  List<Person> participants,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedExpense() when $default != null:
return $default(_that.expense,_that.participants,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num expense,  List<Person> participants,  String description)  $default,) {final _that = this;
switch (_that) {
case _SharedExpense():
return $default(_that.expense,_that.participants,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num expense,  List<Person> participants,  String description)?  $default,) {final _that = this;
switch (_that) {
case _SharedExpense() when $default != null:
return $default(_that.expense,_that.participants,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _SharedExpense extends SharedExpense {
  const _SharedExpense({this.expense = 0, final  List<Person> participants = const [], this.description = ""}): _participants = participants,super._();
  

@override@JsonKey() final  num expense;
 final  List<Person> _participants;
@override@JsonKey() List<Person> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override@JsonKey() final  String description;

/// Create a copy of SharedExpense
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedExpenseCopyWith<_SharedExpense> get copyWith => __$SharedExpenseCopyWithImpl<_SharedExpense>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedExpense&&(identical(other.expense, expense) || other.expense == expense)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,expense,const DeepCollectionEquality().hash(_participants),description);

@override
String toString() {
  return 'SharedExpense(expense: $expense, participants: $participants, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SharedExpenseCopyWith<$Res> implements $SharedExpenseCopyWith<$Res> {
  factory _$SharedExpenseCopyWith(_SharedExpense value, $Res Function(_SharedExpense) _then) = __$SharedExpenseCopyWithImpl;
@override @useResult
$Res call({
 num expense, List<Person> participants, String description
});




}
/// @nodoc
class __$SharedExpenseCopyWithImpl<$Res>
    implements _$SharedExpenseCopyWith<$Res> {
  __$SharedExpenseCopyWithImpl(this._self, this._then);

  final _SharedExpense _self;
  final $Res Function(_SharedExpense) _then;

/// Create a copy of SharedExpense
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expense = null,Object? participants = null,Object? description = null,}) {
  return _then(_SharedExpense(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as num,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<Person>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
