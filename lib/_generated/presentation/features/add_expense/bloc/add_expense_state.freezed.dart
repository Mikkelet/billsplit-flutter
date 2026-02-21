// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/add_expense/bloc/add_expense_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddExpenseState {

 bool get isLoading; SplitsbyError get error; Group get group; GroupExpense get groupExpense; List<Person> get people; ExpenseView get view;
/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddExpenseStateCopyWith<AddExpenseState> get copyWith => _$AddExpenseStateCopyWithImpl<AddExpenseState>(this as AddExpenseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.group, group) || other.group == group)&&(identical(other.groupExpense, groupExpense) || other.groupExpense == groupExpense)&&const DeepCollectionEquality().equals(other.people, people)&&(identical(other.view, view) || other.view == view));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,group,groupExpense,const DeepCollectionEquality().hash(people),view);

@override
String toString() {
  return 'AddExpenseState(isLoading: $isLoading, error: $error, group: $group, groupExpense: $groupExpense, people: $people, view: $view)';
}


}

/// @nodoc
abstract mixin class $AddExpenseStateCopyWith<$Res>  {
  factory $AddExpenseStateCopyWith(AddExpenseState value, $Res Function(AddExpenseState) _then) = _$AddExpenseStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error, Group group, GroupExpense groupExpense, List<Person> people, ExpenseView view
});


$GroupCopyWith<$Res> get group;$GroupExpenseCopyWith<$Res> get groupExpense;

}
/// @nodoc
class _$AddExpenseStateCopyWithImpl<$Res>
    implements $AddExpenseStateCopyWith<$Res> {
  _$AddExpenseStateCopyWithImpl(this._self, this._then);

  final AddExpenseState _self;
  final $Res Function(AddExpenseState) _then;

/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? group = null,Object? groupExpense = null,Object? people = null,Object? view = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group,groupExpense: null == groupExpense ? _self.groupExpense : groupExpense // ignore: cast_nullable_to_non_nullable
as GroupExpense,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as List<Person>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as ExpenseView,
  ));
}
/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res> get group {
  
  return $GroupCopyWith<$Res>(_self.group, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupExpenseCopyWith<$Res> get groupExpense {
  
  return $GroupExpenseCopyWith<$Res>(_self.groupExpense, (value) {
    return _then(_self.copyWith(groupExpense: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddExpenseState].
extension AddExpenseStatePatterns on AddExpenseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddExpenseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddExpenseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddExpenseState value)  $default,){
final _that = this;
switch (_that) {
case _AddExpenseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddExpenseState value)?  $default,){
final _that = this;
switch (_that) {
case _AddExpenseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  Group group,  GroupExpense groupExpense,  List<Person> people,  ExpenseView view)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddExpenseState() when $default != null:
return $default(_that.isLoading,_that.error,_that.group,_that.groupExpense,_that.people,_that.view);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  Group group,  GroupExpense groupExpense,  List<Person> people,  ExpenseView view)  $default,) {final _that = this;
switch (_that) {
case _AddExpenseState():
return $default(_that.isLoading,_that.error,_that.group,_that.groupExpense,_that.people,_that.view);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error,  Group group,  GroupExpense groupExpense,  List<Person> people,  ExpenseView view)?  $default,) {final _that = this;
switch (_that) {
case _AddExpenseState() when $default != null:
return $default(_that.isLoading,_that.error,_that.group,_that.groupExpense,_that.people,_that.view);case _:
  return null;

}
}

}

/// @nodoc


class _AddExpenseState implements AddExpenseState {
  const _AddExpenseState({this.isLoading = false, this.error = const SplitsbyError.none(), this.group = const Group(), this.groupExpense = const GroupExpense(), final  List<Person> people = const [], this.view = ExpenseView.simple}): _people = people;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  Group group;
@override@JsonKey() final  GroupExpense groupExpense;
 final  List<Person> _people;
@override@JsonKey() List<Person> get people {
  if (_people is EqualUnmodifiableListView) return _people;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_people);
}

@override@JsonKey() final  ExpenseView view;

/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddExpenseStateCopyWith<_AddExpenseState> get copyWith => __$AddExpenseStateCopyWithImpl<_AddExpenseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddExpenseState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.group, group) || other.group == group)&&(identical(other.groupExpense, groupExpense) || other.groupExpense == groupExpense)&&const DeepCollectionEquality().equals(other._people, _people)&&(identical(other.view, view) || other.view == view));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,group,groupExpense,const DeepCollectionEquality().hash(_people),view);

@override
String toString() {
  return 'AddExpenseState(isLoading: $isLoading, error: $error, group: $group, groupExpense: $groupExpense, people: $people, view: $view)';
}


}

/// @nodoc
abstract mixin class _$AddExpenseStateCopyWith<$Res> implements $AddExpenseStateCopyWith<$Res> {
  factory _$AddExpenseStateCopyWith(_AddExpenseState value, $Res Function(_AddExpenseState) _then) = __$AddExpenseStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error, Group group, GroupExpense groupExpense, List<Person> people, ExpenseView view
});


@override $GroupCopyWith<$Res> get group;@override $GroupExpenseCopyWith<$Res> get groupExpense;

}
/// @nodoc
class __$AddExpenseStateCopyWithImpl<$Res>
    implements _$AddExpenseStateCopyWith<$Res> {
  __$AddExpenseStateCopyWithImpl(this._self, this._then);

  final _AddExpenseState _self;
  final $Res Function(_AddExpenseState) _then;

/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? group = null,Object? groupExpense = null,Object? people = null,Object? view = null,}) {
  return _then(_AddExpenseState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group,groupExpense: null == groupExpense ? _self.groupExpense : groupExpense // ignore: cast_nullable_to_non_nullable
as GroupExpense,people: null == people ? _self._people : people // ignore: cast_nullable_to_non_nullable
as List<Person>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as ExpenseView,
  ));
}

/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res> get group {
  
  return $GroupCopyWith<$Res>(_self.group, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupExpenseCopyWith<$Res> get groupExpense {
  
  return $GroupExpenseCopyWith<$Res>(_self.groupExpense, (value) {
    return _then(_self.copyWith(groupExpense: value));
  });
}
}

// dart format on
