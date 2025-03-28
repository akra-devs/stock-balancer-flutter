// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rebalancing_tab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RebalanceResultImpl _$$RebalanceResultImplFromJson(
        Map<String, dynamic> json) =>
    _$RebalanceResultImpl(
      cashAdjustmentAmount: (json['cashAdjustmentAmount'] as num).toDouble(),
      stockAdjustmentAmount: (json['stockAdjustmentAmount'] as num).toDouble(),
      bondAdjustmentAmount: (json['bondAdjustmentAmount'] as num?)?.toDouble(),
      individualAdjustment: (json['individualAdjustment'] as num?)?.toDouble(),
      indexAdjustment: (json['indexAdjustment'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$RebalanceResultImplToJson(
        _$RebalanceResultImpl instance) =>
    <String, dynamic>{
      'cashAdjustmentAmount': instance.cashAdjustmentAmount,
      'stockAdjustmentAmount': instance.stockAdjustmentAmount,
      'bondAdjustmentAmount': instance.bondAdjustmentAmount,
      'individualAdjustment': instance.individualAdjustment,
      'indexAdjustment': instance.indexAdjustment,
    };
