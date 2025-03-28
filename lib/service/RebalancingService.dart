import 'package:stock_rebalance/extensions.dart';

import '../rebalancing_tab.dart';

/// 리벨런싱 계산 로직을 분리한 함수
RebalanceResult calculateRebalance(RebalancingState state) {
  double totalInvestment = state.totalInvestment.toDouble();
  double currentCashValue = state.currentCashValue.toDouble();
  double currentStockValue = state.currentStockValue.toDouble();
  double currentBondValue = state.currentBondValue.toDouble();
  double cashRatio = state.cashRatio.toRatioFormat();
  double stockRatio = state.stockRatio.toRatioFormat();
  double bondRatio = state.bondRatio.toRatioFormat();
  double individualStockRatio = state.individualStockRatio.toRatioFormat();
  double indexStockRatio = state.indexStockRatio.toRatioFormat();
  double currentIndexValue = state.currentIndexValue.toDouble();
  double currentTotalValue =
      (currentCashValue + currentStockValue + currentBondValue);

  // 계산 현금 변수
  double afterCashAmount = currentTotalValue * cashRatio;
  double rebalanceCashAmount = afterCashAmount - currentCashValue;

  print(
      "afterCashAmount: $afterCashAmount , rebalanceCashAmount: $rebalanceCashAmount");

  // 게산 주식 변수
  double afterStockAmount = currentTotalValue * stockRatio;
  double rebalanceStockAmount = afterStockAmount - currentStockValue;
  print(
      "afterStockAmount: $afterStockAmount , rebalanceStockAmount: $rebalanceStockAmount");

  //====== 세부 설정 시 계산
  double? individualAdjustment;
  double? indexAdjustment;
  if (state.isStockDetailOn) {
    final double beforeIndividualAdjustment =
        currentStockValue - currentIndexValue;
    final double beforeIndexAdjustment = currentIndexValue;
    final double afterIndividualAdjustment =
        afterStockAmount * individualStockRatio;
    final double afterIndexAdjustment = afterStockAmount * indexStockRatio;

    individualAdjustment =
        afterIndividualAdjustment - beforeIndividualAdjustment;
    indexAdjustment = afterIndexAdjustment - beforeIndexAdjustment;
    print(
        "individualAdjustment: $individualAdjustment ,  indexAdjustment: $indexAdjustment ");
  }
  // 계산 채권 변수
  double afterBondAmount = currentTotalValue * bondRatio;
  double rebalanceBondAmount = afterBondAmount - currentBondValue;
  print(
      "afterBondAmount: $afterBondAmount , rebalanceBondAmount: $rebalanceBondAmount");

  return RebalanceResult(
    cashAdjustmentAmount: rebalanceCashAmount,
    stockAdjustmentAmount: rebalanceStockAmount,
    bondAdjustmentAmount:
        state.isBondEvaluationEnabled ? rebalanceBondAmount : null,
    individualAdjustment: state.isStockDetailOn ? individualAdjustment : null,
    indexAdjustment: state.isStockDetailOn ? indexAdjustment : null,
  );
}
