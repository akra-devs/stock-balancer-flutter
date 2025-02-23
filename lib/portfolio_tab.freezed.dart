// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_tab.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PortfolioItem {
  DateTime get savedAt => throw _privateConstructorUsedError;
  double get rebalanceAmount =>
      throw _privateConstructorUsedError; // 양수: 매도, 음수: 매수
  double get totalInvestment => throw _privateConstructorUsedError;
  double get currentStockValue => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioItemCopyWith<PortfolioItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioItemCopyWith<$Res> {
  factory $PortfolioItemCopyWith(
          PortfolioItem value, $Res Function(PortfolioItem) then) =
      _$PortfolioItemCopyWithImpl<$Res, PortfolioItem>;
  @useResult
  $Res call(
      {DateTime savedAt,
      double rebalanceAmount,
      double totalInvestment,
      double currentStockValue});
}

/// @nodoc
class _$PortfolioItemCopyWithImpl<$Res, $Val extends PortfolioItem>
    implements $PortfolioItemCopyWith<$Res> {
  _$PortfolioItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedAt = null,
    Object? rebalanceAmount = null,
    Object? totalInvestment = null,
    Object? currentStockValue = null,
  }) {
    return _then(_value.copyWith(
      savedAt: null == savedAt
          ? _value.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rebalanceAmount: null == rebalanceAmount
          ? _value.rebalanceAmount
          : rebalanceAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalInvestment: null == totalInvestment
          ? _value.totalInvestment
          : totalInvestment // ignore: cast_nullable_to_non_nullable
              as double,
      currentStockValue: null == currentStockValue
          ? _value.currentStockValue
          : currentStockValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortfolioItemImplCopyWith<$Res>
    implements $PortfolioItemCopyWith<$Res> {
  factory _$$PortfolioItemImplCopyWith(
          _$PortfolioItemImpl value, $Res Function(_$PortfolioItemImpl) then) =
      __$$PortfolioItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime savedAt,
      double rebalanceAmount,
      double totalInvestment,
      double currentStockValue});
}

/// @nodoc
class __$$PortfolioItemImplCopyWithImpl<$Res>
    extends _$PortfolioItemCopyWithImpl<$Res, _$PortfolioItemImpl>
    implements _$$PortfolioItemImplCopyWith<$Res> {
  __$$PortfolioItemImplCopyWithImpl(
      _$PortfolioItemImpl _value, $Res Function(_$PortfolioItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedAt = null,
    Object? rebalanceAmount = null,
    Object? totalInvestment = null,
    Object? currentStockValue = null,
  }) {
    return _then(_$PortfolioItemImpl(
      savedAt: null == savedAt
          ? _value.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rebalanceAmount: null == rebalanceAmount
          ? _value.rebalanceAmount
          : rebalanceAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalInvestment: null == totalInvestment
          ? _value.totalInvestment
          : totalInvestment // ignore: cast_nullable_to_non_nullable
              as double,
      currentStockValue: null == currentStockValue
          ? _value.currentStockValue
          : currentStockValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$PortfolioItemImpl implements _PortfolioItem {
  _$PortfolioItemImpl(
      {required this.savedAt,
      required this.rebalanceAmount,
      required this.totalInvestment,
      required this.currentStockValue});

  @override
  final DateTime savedAt;
  @override
  final double rebalanceAmount;
// 양수: 매도, 음수: 매수
  @override
  final double totalInvestment;
  @override
  final double currentStockValue;

  @override
  String toString() {
    return 'PortfolioItem(savedAt: $savedAt, rebalanceAmount: $rebalanceAmount, totalInvestment: $totalInvestment, currentStockValue: $currentStockValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioItemImpl &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            (identical(other.rebalanceAmount, rebalanceAmount) ||
                other.rebalanceAmount == rebalanceAmount) &&
            (identical(other.totalInvestment, totalInvestment) ||
                other.totalInvestment == totalInvestment) &&
            (identical(other.currentStockValue, currentStockValue) ||
                other.currentStockValue == currentStockValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, savedAt, rebalanceAmount,
      totalInvestment, currentStockValue);

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioItemImplCopyWith<_$PortfolioItemImpl> get copyWith =>
      __$$PortfolioItemImplCopyWithImpl<_$PortfolioItemImpl>(this, _$identity);
}

abstract class _PortfolioItem implements PortfolioItem {
  factory _PortfolioItem(
      {required final DateTime savedAt,
      required final double rebalanceAmount,
      required final double totalInvestment,
      required final double currentStockValue}) = _$PortfolioItemImpl;

  @override
  DateTime get savedAt;
  @override
  double get rebalanceAmount; // 양수: 매도, 음수: 매수
  @override
  double get totalInvestment;
  @override
  double get currentStockValue;

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioItemImplCopyWith<_$PortfolioItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PortfolioEvent {
  PortfolioItem get item => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PortfolioItem item) add,
    required TResult Function(PortfolioItem item) remove,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PortfolioItem item)? add,
    TResult? Function(PortfolioItem item)? remove,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PortfolioItem item)? add,
    TResult Function(PortfolioItem item)? remove,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPortfolioItem value) add,
    required TResult Function(_RemovePortfolioItem value) remove,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPortfolioItem value)? add,
    TResult? Function(_RemovePortfolioItem value)? remove,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPortfolioItem value)? add,
    TResult Function(_RemovePortfolioItem value)? remove,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioEventCopyWith<PortfolioEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioEventCopyWith<$Res> {
  factory $PortfolioEventCopyWith(
          PortfolioEvent value, $Res Function(PortfolioEvent) then) =
      _$PortfolioEventCopyWithImpl<$Res, PortfolioEvent>;
  @useResult
  $Res call({PortfolioItem item});

  $PortfolioItemCopyWith<$Res> get item;
}

/// @nodoc
class _$PortfolioEventCopyWithImpl<$Res, $Val extends PortfolioEvent>
    implements $PortfolioEventCopyWith<$Res> {
  _$PortfolioEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as PortfolioItem,
    ) as $Val);
  }

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PortfolioItemCopyWith<$Res> get item {
    return $PortfolioItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddPortfolioItemImplCopyWith<$Res>
    implements $PortfolioEventCopyWith<$Res> {
  factory _$$AddPortfolioItemImplCopyWith(_$AddPortfolioItemImpl value,
          $Res Function(_$AddPortfolioItemImpl) then) =
      __$$AddPortfolioItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PortfolioItem item});

  @override
  $PortfolioItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$AddPortfolioItemImplCopyWithImpl<$Res>
    extends _$PortfolioEventCopyWithImpl<$Res, _$AddPortfolioItemImpl>
    implements _$$AddPortfolioItemImplCopyWith<$Res> {
  __$$AddPortfolioItemImplCopyWithImpl(_$AddPortfolioItemImpl _value,
      $Res Function(_$AddPortfolioItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$AddPortfolioItemImpl(
      null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as PortfolioItem,
    ));
  }
}

/// @nodoc

class _$AddPortfolioItemImpl implements _AddPortfolioItem {
  const _$AddPortfolioItemImpl(this.item);

  @override
  final PortfolioItem item;

  @override
  String toString() {
    return 'PortfolioEvent.add(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddPortfolioItemImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddPortfolioItemImplCopyWith<_$AddPortfolioItemImpl> get copyWith =>
      __$$AddPortfolioItemImplCopyWithImpl<_$AddPortfolioItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PortfolioItem item) add,
    required TResult Function(PortfolioItem item) remove,
  }) {
    return add(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PortfolioItem item)? add,
    TResult? Function(PortfolioItem item)? remove,
  }) {
    return add?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PortfolioItem item)? add,
    TResult Function(PortfolioItem item)? remove,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPortfolioItem value) add,
    required TResult Function(_RemovePortfolioItem value) remove,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPortfolioItem value)? add,
    TResult? Function(_RemovePortfolioItem value)? remove,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPortfolioItem value)? add,
    TResult Function(_RemovePortfolioItem value)? remove,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class _AddPortfolioItem implements PortfolioEvent {
  const factory _AddPortfolioItem(final PortfolioItem item) =
      _$AddPortfolioItemImpl;

  @override
  PortfolioItem get item;

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddPortfolioItemImplCopyWith<_$AddPortfolioItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemovePortfolioItemImplCopyWith<$Res>
    implements $PortfolioEventCopyWith<$Res> {
  factory _$$RemovePortfolioItemImplCopyWith(_$RemovePortfolioItemImpl value,
          $Res Function(_$RemovePortfolioItemImpl) then) =
      __$$RemovePortfolioItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PortfolioItem item});

  @override
  $PortfolioItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$RemovePortfolioItemImplCopyWithImpl<$Res>
    extends _$PortfolioEventCopyWithImpl<$Res, _$RemovePortfolioItemImpl>
    implements _$$RemovePortfolioItemImplCopyWith<$Res> {
  __$$RemovePortfolioItemImplCopyWithImpl(_$RemovePortfolioItemImpl _value,
      $Res Function(_$RemovePortfolioItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$RemovePortfolioItemImpl(
      null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as PortfolioItem,
    ));
  }
}

/// @nodoc

class _$RemovePortfolioItemImpl implements _RemovePortfolioItem {
  const _$RemovePortfolioItemImpl(this.item);

  @override
  final PortfolioItem item;

  @override
  String toString() {
    return 'PortfolioEvent.remove(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemovePortfolioItemImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemovePortfolioItemImplCopyWith<_$RemovePortfolioItemImpl> get copyWith =>
      __$$RemovePortfolioItemImplCopyWithImpl<_$RemovePortfolioItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PortfolioItem item) add,
    required TResult Function(PortfolioItem item) remove,
  }) {
    return remove(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PortfolioItem item)? add,
    TResult? Function(PortfolioItem item)? remove,
  }) {
    return remove?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PortfolioItem item)? add,
    TResult Function(PortfolioItem item)? remove,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPortfolioItem value) add,
    required TResult Function(_RemovePortfolioItem value) remove,
  }) {
    return remove(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPortfolioItem value)? add,
    TResult? Function(_RemovePortfolioItem value)? remove,
  }) {
    return remove?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPortfolioItem value)? add,
    TResult Function(_RemovePortfolioItem value)? remove,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(this);
    }
    return orElse();
  }
}

abstract class _RemovePortfolioItem implements PortfolioEvent {
  const factory _RemovePortfolioItem(final PortfolioItem item) =
      _$RemovePortfolioItemImpl;

  @override
  PortfolioItem get item;

  /// Create a copy of PortfolioEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemovePortfolioItemImplCopyWith<_$RemovePortfolioItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PortfolioState {
  List<PortfolioItem> get items => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioStateCopyWith<PortfolioState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioStateCopyWith<$Res> {
  factory $PortfolioStateCopyWith(
          PortfolioState value, $Res Function(PortfolioState) then) =
      _$PortfolioStateCopyWithImpl<$Res, PortfolioState>;
  @useResult
  $Res call({List<PortfolioItem> items});
}

/// @nodoc
class _$PortfolioStateCopyWithImpl<$Res, $Val extends PortfolioState>
    implements $PortfolioStateCopyWith<$Res> {
  _$PortfolioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PortfolioItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortfolioStateImplCopyWith<$Res>
    implements $PortfolioStateCopyWith<$Res> {
  factory _$$PortfolioStateImplCopyWith(_$PortfolioStateImpl value,
          $Res Function(_$PortfolioStateImpl) then) =
      __$$PortfolioStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PortfolioItem> items});
}

/// @nodoc
class __$$PortfolioStateImplCopyWithImpl<$Res>
    extends _$PortfolioStateCopyWithImpl<$Res, _$PortfolioStateImpl>
    implements _$$PortfolioStateImplCopyWith<$Res> {
  __$$PortfolioStateImplCopyWithImpl(
      _$PortfolioStateImpl _value, $Res Function(_$PortfolioStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PortfolioState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$PortfolioStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PortfolioItem>,
    ));
  }
}

/// @nodoc

class _$PortfolioStateImpl implements _PortfolioState {
  _$PortfolioStateImpl({final List<PortfolioItem> items = const []})
      : _items = items;

  final List<PortfolioItem> _items;
  @override
  @JsonKey()
  List<PortfolioItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PortfolioState(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of PortfolioState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioStateImplCopyWith<_$PortfolioStateImpl> get copyWith =>
      __$$PortfolioStateImplCopyWithImpl<_$PortfolioStateImpl>(
          this, _$identity);
}

abstract class _PortfolioState implements PortfolioState {
  factory _PortfolioState({final List<PortfolioItem> items}) =
      _$PortfolioStateImpl;

  @override
  List<PortfolioItem> get items;

  /// Create a copy of PortfolioState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioStateImplCopyWith<_$PortfolioStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
