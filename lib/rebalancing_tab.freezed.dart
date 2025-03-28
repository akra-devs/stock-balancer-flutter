// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rebalancing_tab.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RebalanceResult _$RebalanceResultFromJson(Map<String, dynamic> json) {
  return _RebalanceResult.fromJson(json);
}

/// @nodoc
mixin _$RebalanceResult {
  double get cashAdjustmentAmount => throw _privateConstructorUsedError;
  double get stockAdjustmentAmount => throw _privateConstructorUsedError;
  double? get bondAdjustmentAmount => throw _privateConstructorUsedError;
  double? get individualAdjustment => throw _privateConstructorUsedError;
  double? get indexAdjustment => throw _privateConstructorUsedError;

  /// Serializes this RebalanceResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RebalanceResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RebalanceResultCopyWith<RebalanceResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RebalanceResultCopyWith<$Res> {
  factory $RebalanceResultCopyWith(
          RebalanceResult value, $Res Function(RebalanceResult) then) =
      _$RebalanceResultCopyWithImpl<$Res, RebalanceResult>;
  @useResult
  $Res call(
      {double cashAdjustmentAmount,
      double stockAdjustmentAmount,
      double? bondAdjustmentAmount,
      double? individualAdjustment,
      double? indexAdjustment});
}

/// @nodoc
class _$RebalanceResultCopyWithImpl<$Res, $Val extends RebalanceResult>
    implements $RebalanceResultCopyWith<$Res> {
  _$RebalanceResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RebalanceResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cashAdjustmentAmount = null,
    Object? stockAdjustmentAmount = null,
    Object? bondAdjustmentAmount = freezed,
    Object? individualAdjustment = freezed,
    Object? indexAdjustment = freezed,
  }) {
    return _then(_value.copyWith(
      cashAdjustmentAmount: null == cashAdjustmentAmount
          ? _value.cashAdjustmentAmount
          : cashAdjustmentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      stockAdjustmentAmount: null == stockAdjustmentAmount
          ? _value.stockAdjustmentAmount
          : stockAdjustmentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      bondAdjustmentAmount: freezed == bondAdjustmentAmount
          ? _value.bondAdjustmentAmount
          : bondAdjustmentAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      individualAdjustment: freezed == individualAdjustment
          ? _value.individualAdjustment
          : individualAdjustment // ignore: cast_nullable_to_non_nullable
              as double?,
      indexAdjustment: freezed == indexAdjustment
          ? _value.indexAdjustment
          : indexAdjustment // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RebalanceResultImplCopyWith<$Res>
    implements $RebalanceResultCopyWith<$Res> {
  factory _$$RebalanceResultImplCopyWith(_$RebalanceResultImpl value,
          $Res Function(_$RebalanceResultImpl) then) =
      __$$RebalanceResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double cashAdjustmentAmount,
      double stockAdjustmentAmount,
      double? bondAdjustmentAmount,
      double? individualAdjustment,
      double? indexAdjustment});
}

/// @nodoc
class __$$RebalanceResultImplCopyWithImpl<$Res>
    extends _$RebalanceResultCopyWithImpl<$Res, _$RebalanceResultImpl>
    implements _$$RebalanceResultImplCopyWith<$Res> {
  __$$RebalanceResultImplCopyWithImpl(
      _$RebalanceResultImpl _value, $Res Function(_$RebalanceResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of RebalanceResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cashAdjustmentAmount = null,
    Object? stockAdjustmentAmount = null,
    Object? bondAdjustmentAmount = freezed,
    Object? individualAdjustment = freezed,
    Object? indexAdjustment = freezed,
  }) {
    return _then(_$RebalanceResultImpl(
      cashAdjustmentAmount: null == cashAdjustmentAmount
          ? _value.cashAdjustmentAmount
          : cashAdjustmentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      stockAdjustmentAmount: null == stockAdjustmentAmount
          ? _value.stockAdjustmentAmount
          : stockAdjustmentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      bondAdjustmentAmount: freezed == bondAdjustmentAmount
          ? _value.bondAdjustmentAmount
          : bondAdjustmentAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      individualAdjustment: freezed == individualAdjustment
          ? _value.individualAdjustment
          : individualAdjustment // ignore: cast_nullable_to_non_nullable
              as double?,
      indexAdjustment: freezed == indexAdjustment
          ? _value.indexAdjustment
          : indexAdjustment // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$RebalanceResultImpl implements _RebalanceResult {
  _$RebalanceResultImpl(
      {required this.cashAdjustmentAmount,
      required this.stockAdjustmentAmount,
      this.bondAdjustmentAmount,
      this.individualAdjustment,
      this.indexAdjustment});

  factory _$RebalanceResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$RebalanceResultImplFromJson(json);

  @override
  final double cashAdjustmentAmount;
  @override
  final double stockAdjustmentAmount;
  @override
  final double? bondAdjustmentAmount;
  @override
  final double? individualAdjustment;
  @override
  final double? indexAdjustment;

  @override
  String toString() {
    return 'RebalanceResult(cashAdjustmentAmount: $cashAdjustmentAmount, stockAdjustmentAmount: $stockAdjustmentAmount, bondAdjustmentAmount: $bondAdjustmentAmount, individualAdjustment: $individualAdjustment, indexAdjustment: $indexAdjustment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RebalanceResultImpl &&
            (identical(other.cashAdjustmentAmount, cashAdjustmentAmount) ||
                other.cashAdjustmentAmount == cashAdjustmentAmount) &&
            (identical(other.stockAdjustmentAmount, stockAdjustmentAmount) ||
                other.stockAdjustmentAmount == stockAdjustmentAmount) &&
            (identical(other.bondAdjustmentAmount, bondAdjustmentAmount) ||
                other.bondAdjustmentAmount == bondAdjustmentAmount) &&
            (identical(other.individualAdjustment, individualAdjustment) ||
                other.individualAdjustment == individualAdjustment) &&
            (identical(other.indexAdjustment, indexAdjustment) ||
                other.indexAdjustment == indexAdjustment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cashAdjustmentAmount,
      stockAdjustmentAmount,
      bondAdjustmentAmount,
      individualAdjustment,
      indexAdjustment);

  /// Create a copy of RebalanceResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RebalanceResultImplCopyWith<_$RebalanceResultImpl> get copyWith =>
      __$$RebalanceResultImplCopyWithImpl<_$RebalanceResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RebalanceResultImplToJson(
      this,
    );
  }
}

abstract class _RebalanceResult implements RebalanceResult {
  factory _RebalanceResult(
      {required final double cashAdjustmentAmount,
      required final double stockAdjustmentAmount,
      final double? bondAdjustmentAmount,
      final double? individualAdjustment,
      final double? indexAdjustment}) = _$RebalanceResultImpl;

  factory _RebalanceResult.fromJson(Map<String, dynamic> json) =
      _$RebalanceResultImpl.fromJson;

  @override
  double get cashAdjustmentAmount;
  @override
  double get stockAdjustmentAmount;
  @override
  double? get bondAdjustmentAmount;
  @override
  double? get individualAdjustment;
  @override
  double? get indexAdjustment;

  /// Create a copy of RebalanceResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RebalanceResultImplCopyWith<_$RebalanceResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RebalancingState {
  int get totalInvestment => throw _privateConstructorUsedError;
  int get currentCashValue => throw _privateConstructorUsedError;
  int get currentStockValue => throw _privateConstructorUsedError;
  int get currentBondValue => throw _privateConstructorUsedError;
  int get currentIndexValue =>
      throw _privateConstructorUsedError; // 추가: 현재 지수 평가 금액
  int get cashRatio => throw _privateConstructorUsedError;
  int get stockRatio => throw _privateConstructorUsedError;
  int get bondRatio => throw _privateConstructorUsedError;
  int get individualStockRatio => throw _privateConstructorUsedError;
  int get indexStockRatio => throw _privateConstructorUsedError;
  bool get isStockDetailOn => throw _privateConstructorUsedError;
  bool get isBondEvaluationEnabled => throw _privateConstructorUsedError;

  /// Create a copy of RebalancingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RebalancingStateCopyWith<RebalancingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RebalancingStateCopyWith<$Res> {
  factory $RebalancingStateCopyWith(
          RebalancingState value, $Res Function(RebalancingState) then) =
      _$RebalancingStateCopyWithImpl<$Res, RebalancingState>;
  @useResult
  $Res call(
      {int totalInvestment,
      int currentCashValue,
      int currentStockValue,
      int currentBondValue,
      int currentIndexValue,
      int cashRatio,
      int stockRatio,
      int bondRatio,
      int individualStockRatio,
      int indexStockRatio,
      bool isStockDetailOn,
      bool isBondEvaluationEnabled});
}

/// @nodoc
class _$RebalancingStateCopyWithImpl<$Res, $Val extends RebalancingState>
    implements $RebalancingStateCopyWith<$Res> {
  _$RebalancingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RebalancingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvestment = null,
    Object? currentCashValue = null,
    Object? currentStockValue = null,
    Object? currentBondValue = null,
    Object? currentIndexValue = null,
    Object? cashRatio = null,
    Object? stockRatio = null,
    Object? bondRatio = null,
    Object? individualStockRatio = null,
    Object? indexStockRatio = null,
    Object? isStockDetailOn = null,
    Object? isBondEvaluationEnabled = null,
  }) {
    return _then(_value.copyWith(
      totalInvestment: null == totalInvestment
          ? _value.totalInvestment
          : totalInvestment // ignore: cast_nullable_to_non_nullable
              as int,
      currentCashValue: null == currentCashValue
          ? _value.currentCashValue
          : currentCashValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentStockValue: null == currentStockValue
          ? _value.currentStockValue
          : currentStockValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentBondValue: null == currentBondValue
          ? _value.currentBondValue
          : currentBondValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentIndexValue: null == currentIndexValue
          ? _value.currentIndexValue
          : currentIndexValue // ignore: cast_nullable_to_non_nullable
              as int,
      cashRatio: null == cashRatio
          ? _value.cashRatio
          : cashRatio // ignore: cast_nullable_to_non_nullable
              as int,
      stockRatio: null == stockRatio
          ? _value.stockRatio
          : stockRatio // ignore: cast_nullable_to_non_nullable
              as int,
      bondRatio: null == bondRatio
          ? _value.bondRatio
          : bondRatio // ignore: cast_nullable_to_non_nullable
              as int,
      individualStockRatio: null == individualStockRatio
          ? _value.individualStockRatio
          : individualStockRatio // ignore: cast_nullable_to_non_nullable
              as int,
      indexStockRatio: null == indexStockRatio
          ? _value.indexStockRatio
          : indexStockRatio // ignore: cast_nullable_to_non_nullable
              as int,
      isStockDetailOn: null == isStockDetailOn
          ? _value.isStockDetailOn
          : isStockDetailOn // ignore: cast_nullable_to_non_nullable
              as bool,
      isBondEvaluationEnabled: null == isBondEvaluationEnabled
          ? _value.isBondEvaluationEnabled
          : isBondEvaluationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RebalancingStateImplCopyWith<$Res>
    implements $RebalancingStateCopyWith<$Res> {
  factory _$$RebalancingStateImplCopyWith(_$RebalancingStateImpl value,
          $Res Function(_$RebalancingStateImpl) then) =
      __$$RebalancingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalInvestment,
      int currentCashValue,
      int currentStockValue,
      int currentBondValue,
      int currentIndexValue,
      int cashRatio,
      int stockRatio,
      int bondRatio,
      int individualStockRatio,
      int indexStockRatio,
      bool isStockDetailOn,
      bool isBondEvaluationEnabled});
}

/// @nodoc
class __$$RebalancingStateImplCopyWithImpl<$Res>
    extends _$RebalancingStateCopyWithImpl<$Res, _$RebalancingStateImpl>
    implements _$$RebalancingStateImplCopyWith<$Res> {
  __$$RebalancingStateImplCopyWithImpl(_$RebalancingStateImpl _value,
      $Res Function(_$RebalancingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RebalancingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvestment = null,
    Object? currentCashValue = null,
    Object? currentStockValue = null,
    Object? currentBondValue = null,
    Object? currentIndexValue = null,
    Object? cashRatio = null,
    Object? stockRatio = null,
    Object? bondRatio = null,
    Object? individualStockRatio = null,
    Object? indexStockRatio = null,
    Object? isStockDetailOn = null,
    Object? isBondEvaluationEnabled = null,
  }) {
    return _then(_$RebalancingStateImpl(
      totalInvestment: null == totalInvestment
          ? _value.totalInvestment
          : totalInvestment // ignore: cast_nullable_to_non_nullable
              as int,
      currentCashValue: null == currentCashValue
          ? _value.currentCashValue
          : currentCashValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentStockValue: null == currentStockValue
          ? _value.currentStockValue
          : currentStockValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentBondValue: null == currentBondValue
          ? _value.currentBondValue
          : currentBondValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentIndexValue: null == currentIndexValue
          ? _value.currentIndexValue
          : currentIndexValue // ignore: cast_nullable_to_non_nullable
              as int,
      cashRatio: null == cashRatio
          ? _value.cashRatio
          : cashRatio // ignore: cast_nullable_to_non_nullable
              as int,
      stockRatio: null == stockRatio
          ? _value.stockRatio
          : stockRatio // ignore: cast_nullable_to_non_nullable
              as int,
      bondRatio: null == bondRatio
          ? _value.bondRatio
          : bondRatio // ignore: cast_nullable_to_non_nullable
              as int,
      individualStockRatio: null == individualStockRatio
          ? _value.individualStockRatio
          : individualStockRatio // ignore: cast_nullable_to_non_nullable
              as int,
      indexStockRatio: null == indexStockRatio
          ? _value.indexStockRatio
          : indexStockRatio // ignore: cast_nullable_to_non_nullable
              as int,
      isStockDetailOn: null == isStockDetailOn
          ? _value.isStockDetailOn
          : isStockDetailOn // ignore: cast_nullable_to_non_nullable
              as bool,
      isBondEvaluationEnabled: null == isBondEvaluationEnabled
          ? _value.isBondEvaluationEnabled
          : isBondEvaluationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RebalancingStateImpl implements _RebalancingState {
  _$RebalancingStateImpl(
      {this.totalInvestment = 0,
      this.currentCashValue = 0,
      this.currentStockValue = 0,
      this.currentBondValue = 0,
      this.currentIndexValue = 0,
      this.cashRatio = 0,
      this.stockRatio = 0,
      this.bondRatio = 0,
      this.individualStockRatio = 0,
      this.indexStockRatio = 0,
      this.isStockDetailOn = false,
      this.isBondEvaluationEnabled = false});

  @override
  @JsonKey()
  final int totalInvestment;
  @override
  @JsonKey()
  final int currentCashValue;
  @override
  @JsonKey()
  final int currentStockValue;
  @override
  @JsonKey()
  final int currentBondValue;
  @override
  @JsonKey()
  final int currentIndexValue;
// 추가: 현재 지수 평가 금액
  @override
  @JsonKey()
  final int cashRatio;
  @override
  @JsonKey()
  final int stockRatio;
  @override
  @JsonKey()
  final int bondRatio;
  @override
  @JsonKey()
  final int individualStockRatio;
  @override
  @JsonKey()
  final int indexStockRatio;
  @override
  @JsonKey()
  final bool isStockDetailOn;
  @override
  @JsonKey()
  final bool isBondEvaluationEnabled;

  @override
  String toString() {
    return 'RebalancingState(totalInvestment: $totalInvestment, currentCashValue: $currentCashValue, currentStockValue: $currentStockValue, currentBondValue: $currentBondValue, currentIndexValue: $currentIndexValue, cashRatio: $cashRatio, stockRatio: $stockRatio, bondRatio: $bondRatio, individualStockRatio: $individualStockRatio, indexStockRatio: $indexStockRatio, isStockDetailOn: $isStockDetailOn, isBondEvaluationEnabled: $isBondEvaluationEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RebalancingStateImpl &&
            (identical(other.totalInvestment, totalInvestment) ||
                other.totalInvestment == totalInvestment) &&
            (identical(other.currentCashValue, currentCashValue) ||
                other.currentCashValue == currentCashValue) &&
            (identical(other.currentStockValue, currentStockValue) ||
                other.currentStockValue == currentStockValue) &&
            (identical(other.currentBondValue, currentBondValue) ||
                other.currentBondValue == currentBondValue) &&
            (identical(other.currentIndexValue, currentIndexValue) ||
                other.currentIndexValue == currentIndexValue) &&
            (identical(other.cashRatio, cashRatio) ||
                other.cashRatio == cashRatio) &&
            (identical(other.stockRatio, stockRatio) ||
                other.stockRatio == stockRatio) &&
            (identical(other.bondRatio, bondRatio) ||
                other.bondRatio == bondRatio) &&
            (identical(other.individualStockRatio, individualStockRatio) ||
                other.individualStockRatio == individualStockRatio) &&
            (identical(other.indexStockRatio, indexStockRatio) ||
                other.indexStockRatio == indexStockRatio) &&
            (identical(other.isStockDetailOn, isStockDetailOn) ||
                other.isStockDetailOn == isStockDetailOn) &&
            (identical(
                    other.isBondEvaluationEnabled, isBondEvaluationEnabled) ||
                other.isBondEvaluationEnabled == isBondEvaluationEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalInvestment,
      currentCashValue,
      currentStockValue,
      currentBondValue,
      currentIndexValue,
      cashRatio,
      stockRatio,
      bondRatio,
      individualStockRatio,
      indexStockRatio,
      isStockDetailOn,
      isBondEvaluationEnabled);

  /// Create a copy of RebalancingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RebalancingStateImplCopyWith<_$RebalancingStateImpl> get copyWith =>
      __$$RebalancingStateImplCopyWithImpl<_$RebalancingStateImpl>(
          this, _$identity);
}

abstract class _RebalancingState implements RebalancingState {
  factory _RebalancingState(
      {final int totalInvestment,
      final int currentCashValue,
      final int currentStockValue,
      final int currentBondValue,
      final int currentIndexValue,
      final int cashRatio,
      final int stockRatio,
      final int bondRatio,
      final int individualStockRatio,
      final int indexStockRatio,
      final bool isStockDetailOn,
      final bool isBondEvaluationEnabled}) = _$RebalancingStateImpl;

  @override
  int get totalInvestment;
  @override
  int get currentCashValue;
  @override
  int get currentStockValue;
  @override
  int get currentBondValue;
  @override
  int get currentIndexValue; // 추가: 현재 지수 평가 금액
  @override
  int get cashRatio;
  @override
  int get stockRatio;
  @override
  int get bondRatio;
  @override
  int get individualStockRatio;
  @override
  int get indexStockRatio;
  @override
  bool get isStockDetailOn;
  @override
  bool get isBondEvaluationEnabled;

  /// Create a copy of RebalancingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RebalancingStateImplCopyWith<_$RebalancingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
