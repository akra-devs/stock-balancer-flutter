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

/// @nodoc
mixin _$RebalancingState {
  int get totalInvestment => throw _privateConstructorUsedError;
  int get currentStockValue => throw _privateConstructorUsedError;
  int get currentBondValue => throw _privateConstructorUsedError;
  int get cashRatio => throw _privateConstructorUsedError;
  int get stockRatio => throw _privateConstructorUsedError;
  int get bondRatio => throw _privateConstructorUsedError;
  int get individualStockRatio => throw _privateConstructorUsedError;
  int get indexStockRatio => throw _privateConstructorUsedError;
  bool get isStockDetailOn => throw _privateConstructorUsedError;
  bool get isBondEvaluationEnabled => throw _privateConstructorUsedError;
  int get totalIndexPurchase =>
      throw _privateConstructorUsedError; // 추가: 총 지수 주식 매수 금액
  int get currentIndexValue => throw _privateConstructorUsedError;

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
      int currentStockValue,
      int currentBondValue,
      int cashRatio,
      int stockRatio,
      int bondRatio,
      int individualStockRatio,
      int indexStockRatio,
      bool isStockDetailOn,
      bool isBondEvaluationEnabled,
      int totalIndexPurchase,
      int currentIndexValue});
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
    Object? currentStockValue = null,
    Object? currentBondValue = null,
    Object? cashRatio = null,
    Object? stockRatio = null,
    Object? bondRatio = null,
    Object? individualStockRatio = null,
    Object? indexStockRatio = null,
    Object? isStockDetailOn = null,
    Object? isBondEvaluationEnabled = null,
    Object? totalIndexPurchase = null,
    Object? currentIndexValue = null,
  }) {
    return _then(_value.copyWith(
      totalInvestment: null == totalInvestment
          ? _value.totalInvestment
          : totalInvestment // ignore: cast_nullable_to_non_nullable
              as int,
      currentStockValue: null == currentStockValue
          ? _value.currentStockValue
          : currentStockValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentBondValue: null == currentBondValue
          ? _value.currentBondValue
          : currentBondValue // ignore: cast_nullable_to_non_nullable
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
      totalIndexPurchase: null == totalIndexPurchase
          ? _value.totalIndexPurchase
          : totalIndexPurchase // ignore: cast_nullable_to_non_nullable
              as int,
      currentIndexValue: null == currentIndexValue
          ? _value.currentIndexValue
          : currentIndexValue // ignore: cast_nullable_to_non_nullable
              as int,
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
      int currentStockValue,
      int currentBondValue,
      int cashRatio,
      int stockRatio,
      int bondRatio,
      int individualStockRatio,
      int indexStockRatio,
      bool isStockDetailOn,
      bool isBondEvaluationEnabled,
      int totalIndexPurchase,
      int currentIndexValue});
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
    Object? currentStockValue = null,
    Object? currentBondValue = null,
    Object? cashRatio = null,
    Object? stockRatio = null,
    Object? bondRatio = null,
    Object? individualStockRatio = null,
    Object? indexStockRatio = null,
    Object? isStockDetailOn = null,
    Object? isBondEvaluationEnabled = null,
    Object? totalIndexPurchase = null,
    Object? currentIndexValue = null,
  }) {
    return _then(_$RebalancingStateImpl(
      totalInvestment: null == totalInvestment
          ? _value.totalInvestment
          : totalInvestment // ignore: cast_nullable_to_non_nullable
              as int,
      currentStockValue: null == currentStockValue
          ? _value.currentStockValue
          : currentStockValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentBondValue: null == currentBondValue
          ? _value.currentBondValue
          : currentBondValue // ignore: cast_nullable_to_non_nullable
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
      totalIndexPurchase: null == totalIndexPurchase
          ? _value.totalIndexPurchase
          : totalIndexPurchase // ignore: cast_nullable_to_non_nullable
              as int,
      currentIndexValue: null == currentIndexValue
          ? _value.currentIndexValue
          : currentIndexValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RebalancingStateImpl implements _RebalancingState {
  _$RebalancingStateImpl(
      {this.totalInvestment = 0,
      this.currentStockValue = 0,
      this.currentBondValue = 0,
      this.cashRatio = 0,
      this.stockRatio = 0,
      this.bondRatio = 0,
      this.individualStockRatio = 0,
      this.indexStockRatio = 0,
      this.isStockDetailOn = false,
      this.isBondEvaluationEnabled = false,
      this.totalIndexPurchase = 0,
      this.currentIndexValue = 0});

  @override
  @JsonKey()
  final int totalInvestment;
  @override
  @JsonKey()
  final int currentStockValue;
  @override
  @JsonKey()
  final int currentBondValue;
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
  @JsonKey()
  final int totalIndexPurchase;
// 추가: 총 지수 주식 매수 금액
  @override
  @JsonKey()
  final int currentIndexValue;

  @override
  String toString() {
    return 'RebalancingState(totalInvestment: $totalInvestment, currentStockValue: $currentStockValue, currentBondValue: $currentBondValue, cashRatio: $cashRatio, stockRatio: $stockRatio, bondRatio: $bondRatio, individualStockRatio: $individualStockRatio, indexStockRatio: $indexStockRatio, isStockDetailOn: $isStockDetailOn, isBondEvaluationEnabled: $isBondEvaluationEnabled, totalIndexPurchase: $totalIndexPurchase, currentIndexValue: $currentIndexValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RebalancingStateImpl &&
            (identical(other.totalInvestment, totalInvestment) ||
                other.totalInvestment == totalInvestment) &&
            (identical(other.currentStockValue, currentStockValue) ||
                other.currentStockValue == currentStockValue) &&
            (identical(other.currentBondValue, currentBondValue) ||
                other.currentBondValue == currentBondValue) &&
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
                other.isBondEvaluationEnabled == isBondEvaluationEnabled) &&
            (identical(other.totalIndexPurchase, totalIndexPurchase) ||
                other.totalIndexPurchase == totalIndexPurchase) &&
            (identical(other.currentIndexValue, currentIndexValue) ||
                other.currentIndexValue == currentIndexValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalInvestment,
      currentStockValue,
      currentBondValue,
      cashRatio,
      stockRatio,
      bondRatio,
      individualStockRatio,
      indexStockRatio,
      isStockDetailOn,
      isBondEvaluationEnabled,
      totalIndexPurchase,
      currentIndexValue);

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
      final int currentStockValue,
      final int currentBondValue,
      final int cashRatio,
      final int stockRatio,
      final int bondRatio,
      final int individualStockRatio,
      final int indexStockRatio,
      final bool isStockDetailOn,
      final bool isBondEvaluationEnabled,
      final int totalIndexPurchase,
      final int currentIndexValue}) = _$RebalancingStateImpl;

  @override
  int get totalInvestment;
  @override
  int get currentStockValue;
  @override
  int get currentBondValue;
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
  @override
  int get totalIndexPurchase; // 추가: 총 지수 주식 매수 금액
  @override
  int get currentIndexValue;

  /// Create a copy of RebalancingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RebalancingStateImplCopyWith<_$RebalancingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
