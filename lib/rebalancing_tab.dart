import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_rebalance/extensions.dart';
import 'package:stock_rebalance/portfolio_tab.dart'; // 확장함수(toNumberFormat) 포함

part 'rebalancing_tab.freezed.dart';

///────────────────────────────
/// 도메인 로직: 리벨런싱 계산 결과 모델 및 함수
///────────────────────────────

class RebalanceResult {
  final double overallAdjustment;
  final double? individualAdjustment;
  final double? indexAdjustment;

  RebalanceResult({
    required this.overallAdjustment,
    this.individualAdjustment,
    this.indexAdjustment,
  });
}

/// 계산 로직을 분리한 함수
/// - 세부 설정이 off이면 단순 계산 (기존 로직)
/// - 세부 설정이 on이면 추가로 총 지수 주식 매수 금액과 현재 지수 주식 평가 금액을 사용
RebalanceResult calculateRebalance(
  RebalancingState state, {
  int? totalIndexPurchase, // 세부 설정 모드일 때 입력된 총 지수 주식 매수 금액
  int? currentIndexValue, // 세부 설정 모드일 때 입력된 현재 지수 주식 평가 금액
}) {
  if (!state.isStockDetailOn) {
    // 단순 계산: 현금비중 기반 계산
    double totalInvestment = state.totalInvestment.toDouble();
    double currentStockValue = state.currentStockValue.toDouble();
    double cashRatio = state.cashRatio.toDouble();
    double impliedCash = totalInvestment * (cashRatio / (100 - cashRatio));
    double targetCash = (cashRatio / 100) * (impliedCash + currentStockValue);
    double adjustment = targetCash - impliedCash;
    return RebalanceResult(overallAdjustment: adjustment);
  } else {
    // 세부 설정 모드: 개별주식과 지수주식을 분리하여 계산
    if (totalIndexPurchase == null || currentIndexValue == null) {
      throw Exception("세부 설정 모드에서는 지수 주식 관련 값이 필요합니다.");
    }
    // 가정: 전체 주식 매수 금액은 두 부분의 합이고, 전체 주식 평가 금액도 두 부분의 합입니다.
    // 개별 주식 값은:
    double totalIndividualPurchase =
        state.totalInvestment.toDouble() - totalIndexPurchase.toDouble();
    double currentIndividualValue =
        state.currentStockValue.toDouble() - currentIndexValue.toDouble();

    // 각 비중 설정 (전체 주식 비중은 100%이고, 세부 설정으로 개별/지수로 분리)
    double individualRatio = state.individualStockRatio.toDouble();
    double indexRatio = state.indexStockRatio.toDouble();

    // 개별 주식 계산
    double impliedCashInd =
        totalIndividualPurchase * (individualRatio / (100 - individualRatio));
    double targetCashInd =
        (individualRatio / 100) * (impliedCashInd + currentIndividualValue);
    double individualAdjustment = targetCashInd - impliedCashInd;

    // 지수 주식 계산
    double impliedCashIdx =
        totalIndexPurchase.toDouble() * (indexRatio / (100 - indexRatio));
    double targetCashIdx =
        (indexRatio / 100) * (impliedCashIdx + currentIndexValue.toDouble());
    double indexAdjustment = targetCashIdx - impliedCashIdx;

    double overallAdjustment = individualAdjustment + indexAdjustment;
    return RebalanceResult(
      overallAdjustment: overallAdjustment,
      individualAdjustment: individualAdjustment,
      indexAdjustment: indexAdjustment,
    );
  }
}

///────────────────────────────
/// 계산 탭 Bloc 관련 코드 (상태값은 int로 관리)
///────────────────────────────

abstract class RebalancingEvent {}

class TotalInvestmentChanged extends RebalancingEvent {
  final int totalInvestment;

  TotalInvestmentChanged(this.totalInvestment);
}

class CurrentStockValueChanged extends RebalancingEvent {
  final int currentStockValue;

  CurrentStockValueChanged(this.currentStockValue);
}

class CurrentBondValueChanged extends RebalancingEvent {
  final int currentBondValue;

  CurrentBondValueChanged(this.currentBondValue);
}

class CashRatioChanged extends RebalancingEvent {
  final int cashRatio;

  CashRatioChanged(this.cashRatio);
}

class StockRatioChanged extends RebalancingEvent {
  final int stockRatio;

  StockRatioChanged(this.stockRatio);
}

class BondRatioChanged extends RebalancingEvent {
  final int bondRatio;

  BondRatioChanged(this.bondRatio);
}

class IndividualStockRatioChanged extends RebalancingEvent {
  final int individualStockRatio;

  IndividualStockRatioChanged(this.individualStockRatio);
}

class IndexStockRatioChanged extends RebalancingEvent {
  final int indexStockRatio;

  IndexStockRatioChanged(this.indexStockRatio);
}

class ToggleStockDetail extends RebalancingEvent {}

class ToggleBondEvaluation extends RebalancingEvent {}

@freezed
class RebalancingState with _$RebalancingState {
  factory RebalancingState({
    @Default(0) int totalInvestment,
    @Default(0) int currentStockValue,
    @Default(0) int currentBondValue,
    @Default(0) int cashRatio,
    @Default(0) int stockRatio,
    @Default(0) int bondRatio,
    @Default(0) int individualStockRatio,
    @Default(0) int indexStockRatio,
    @Default(false) bool isStockDetailOn,
    @Default(false) bool isBondEvaluationEnabled,
  }) = _RebalancingState;
}

class RebalancingBloc extends Bloc<RebalancingEvent, RebalancingState> {
  RebalancingBloc() : super(RebalancingState()) {
    on<TotalInvestmentChanged>((event, emit) {
      emit(state.copyWith(totalInvestment: event.totalInvestment));
    });
    on<CurrentStockValueChanged>((event, emit) {
      emit(state.copyWith(currentStockValue: event.currentStockValue));
    });
    on<CurrentBondValueChanged>((event, emit) {
      emit(state.copyWith(currentBondValue: event.currentBondValue));
    });
    on<CashRatioChanged>((event, emit) {
      int newCash;
      if (state.isBondEvaluationEnabled) {
        int maxCash = 100 - state.stockRatio;
        newCash = event.cashRatio.clamp(0, maxCash);
        int newBond = 100 - (newCash + state.stockRatio);
        emit(state.copyWith(cashRatio: newCash, bondRatio: newBond));
      } else {
        int maxCash = 100;
        newCash = event.cashRatio.clamp(0, maxCash);
        int newStock = 100 - newCash;
        emit(state.copyWith(cashRatio: newCash, stockRatio: newStock));
      }
    });
    on<StockRatioChanged>((event, emit) {
      int newStock;
      if (state.isBondEvaluationEnabled) {
        int maxStock = 100 - state.cashRatio;
        newStock = event.stockRatio.clamp(0, maxStock);
        int newBond = 100 - (state.cashRatio + newStock);
        emit(state.copyWith(stockRatio: newStock, bondRatio: newBond));
      } else {
        int maxStock = 100;
        newStock = event.stockRatio.clamp(0, maxStock);
        int newCash = 100 - newStock;
        emit(state.copyWith(stockRatio: newStock, cashRatio: newCash));
      }
    });
    on<BondRatioChanged>((event, emit) {
      if (state.isBondEvaluationEnabled) {
        int maxBond = 100 - (state.cashRatio + state.stockRatio);
        int newBond = event.bondRatio.clamp(0, maxBond);
        int newStock = 100 - (state.cashRatio + newBond);
        emit(state.copyWith(bondRatio: newBond, stockRatio: newStock));
      }
    });
    on<IndividualStockRatioChanged>((event, emit) {
      int newInd = event.individualStockRatio;
      int newIndex = 100 - newInd;
      emit(state.copyWith(
          individualStockRatio: newInd, indexStockRatio: newIndex));
    });
    on<IndexStockRatioChanged>((event, emit) {
      int newIndex = event.indexStockRatio;
      int newInd = 100 - newIndex;
      emit(state.copyWith(
          indexStockRatio: newIndex, individualStockRatio: newInd));
    });
    on<ToggleStockDetail>((event, emit) {
      emit(state.copyWith(isStockDetailOn: !state.isStockDetailOn));
    });
    on<ToggleBondEvaluation>((event, emit) {
      emit(state.copyWith(
          isBondEvaluationEnabled: !state.isBondEvaluationEnabled));
    });
  }
}

///────────────────────────────
/// 계산 탭 UI 관련 코드
///────────────────────────────

class RebalancingHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리벨런싱 계산'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            InvestmentInfoCard(),
            SizedBox(height: 20),
            RebalancingRatioCard(),
            SizedBox(height: 20),
            BlocBuilder<RebalancingBloc, RebalancingState>(
              builder: (context, state) {
                int totalRatio = state.cashRatio +
                    state.stockRatio +
                    (state.isBondEvaluationEnabled ? state.bondRatio : 0);
                return Text('총 비중: $totalRatio% (100% 필요)');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final state = context.read<RebalancingBloc>().state;
                if (state.totalInvestment == 0) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('총 매수 원금이 0입니다.')));
                  return;
                }
                if (state.cashRatio >= 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('현금비중이 100% 이상일 수 없습니다.')));
                  return;
                }
                RebalanceResult result;
                // 만약 세부 설정이 켜져 있다면, 추가 입력 필드의 값을 사용해야 합니다.
                // 예를 들어, 아래는 임의로 추가 컨트롤러 값(totalIndexPurchase, currentIndexValue)을 사용한다고 가정합니다.
                // 실제로는 세부 설정 UI에 별도의 입력 필드를 추가해야 합니다.
                if (state.isStockDetailOn) {
                  // 여기서는 예시로 100, 150을 사용합니다.
                  result = calculateRebalance(state,
                      totalIndexPurchase: 100, currentIndexValue: 150);
                } else {
                  result = calculateRebalance(state);
                }
                String overallText =
                    '전체 리벨런싱 결과: 주식을 ${result.overallAdjustment.abs().toNumberFormat()}원 만큼 ${result.overallAdjustment > 0 ? '매도' : '매수'} 하세요.';
                String detailText = '';
                if (result.individualAdjustment != null &&
                    result.indexAdjustment != null) {
                  detailText =
                      '\n개별 주식: ${result.individualAdjustment!.abs().toNumberFormat()}원 ${result.individualAdjustment! > 0 ? '매도' : '매수'}\n지수 주식: ${result.indexAdjustment!.abs().toNumberFormat()}원 ${result.indexAdjustment! > 0 ? '매도' : '매수'}';
                }
                // PortfolioBloc에 계산 결과 전달 (PortfolioItem 생성 후 add 이벤트 발행)
                final portfolioItem = PortfolioItem.create(
                  rebalanceAmount: result.overallAdjustment,
                  totalInvestment: state.totalInvestment.toDouble(),
                  currentStockValue: state.currentStockValue.toDouble(),
                );
                context
                    .read<PortfolioBloc>()
                    .add(PortfolioEvent.add(portfolioItem));
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('리벨런싱 결과'),
                    content: Text(overallText + detailText),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('리벨런싱 계산'),
            ),
          ],
        ),
      ),
    );
  }
}

class InvestmentInfoCard extends StatefulWidget {
  @override
  _InvestmentInfoCardState createState() => _InvestmentInfoCardState();
}

class _InvestmentInfoCardState extends State<InvestmentInfoCard> {
  late MoneyMaskedTextController totalInvestmentController;
  late MoneyMaskedTextController currentStockValueController;
  late MoneyMaskedTextController currentBondValueController;

  @override
  void initState() {
    super.initState();
    totalInvestmentController = MoneyMaskedTextController(
      decimalSeparator: '',
      thousandSeparator: ',',
      precision: 0,
      initialValue: 0,
    );
    currentStockValueController = MoneyMaskedTextController(
      decimalSeparator: '',
      thousandSeparator: ',',
      precision: 0,
      initialValue: 0,
    );
    currentBondValueController = MoneyMaskedTextController(
      decimalSeparator: '',
      thousandSeparator: ',',
      precision: 0,
      initialValue: 0,
    );
  }

  @override
  void dispose() {
    totalInvestmentController.dispose();
    currentStockValueController.dispose();
    currentBondValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RebalancingBloc>();
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '투자 정보 입력',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // 총 매수 원금 금액 입력
            TextField(
              controller: totalInvestmentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '총 매수 원금 금액',
              ),
              onChanged: (value) {
                bloc.add(
                    TotalInvestmentChanged(totalInvestmentController.intValue));
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  // 현재 주식 평가 금액 입력
                  child: TextField(
                    controller: currentStockValueController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '현재 주식 평가 금액',
                    ),
                    onChanged: (value) {
                      bloc.add(CurrentStockValueChanged(
                          currentStockValueController.intValue));
                    },
                  ),
                ),
                const SizedBox(width: 10),
                BlocBuilder<RebalancingBloc, RebalancingState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text('세부 설정'),
                        Switch(
                          value: state.isStockDetailOn,
                          onChanged: (_) {
                            bloc.add(ToggleStockDetail());
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  // 현재 채권 평가 금액 입력
                  child: BlocBuilder<RebalancingBloc, RebalancingState>(
                    builder: (context, state) {
                      return TextField(
                        controller: currentBondValueController,
                        keyboardType: TextInputType.number,
                        enabled: state.isBondEvaluationEnabled,
                        decoration: InputDecoration(
                          labelText: '현재 채권 평가 금액',
                        ),
                        onChanged: (value) {
                          bloc.add(CurrentBondValueChanged(
                              currentBondValueController.intValue));
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                BlocBuilder<RebalancingBloc, RebalancingState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text('채권 사용'),
                        Switch(
                          value: state.isBondEvaluationEnabled,
                          onChanged: (_) {
                            bloc.add(ToggleBondEvaluation());
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(width: 10),
              ],
            ),
            // TODO: 세부 설정이 켜지면 추가 입력 필드(총 지수 주식 매수 금액, 현재 지수 주식 평가 금액)도 표시하도록 구현
          ],
        ),
      ),
    );
  }
}

class RebalancingRatioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RebalancingBloc>();
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<RebalancingBloc, RebalancingState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '리벨런싱 비중 입력',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('현금 비중 (%) : ${state.cashRatio.toString()}'),
                Slider(
                  value: state.cashRatio.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: state.cashRatio.toString(),
                  onChanged: (value) {
                    bloc.add(CashRatioChanged(value.round()));
                  },
                ),
                SizedBox(height: 10),
                Text('주식 비중 (%) : ${state.stockRatio.toString()}'),
                Slider(
                  value: state.stockRatio.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: state.stockRatio.toString(),
                  onChanged: (value) {
                    bloc.add(StockRatioChanged(value.round()));
                  },
                ),
                if (state.isStockDetailOn) ...[
                  SizedBox(height: 10),
                  Text(
                      '개별 주식 비중 (%) : ${state.individualStockRatio.toString()}'),
                  Slider(
                    value: state.individualStockRatio.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: state.individualStockRatio.toString(),
                    onChanged: (value) {
                      bloc.add(IndividualStockRatioChanged(value.round()));
                    },
                  ),
                  Text('지수 주식 비중 (%) : ${state.indexStockRatio.toString()}'),
                  Slider(
                    value: state.indexStockRatio.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: state.indexStockRatio.toString(),
                    onChanged: (value) {
                      bloc.add(IndexStockRatioChanged(value.round()));
                    },
                  ),
                ],
                SizedBox(height: 10),
                if (state.isBondEvaluationEnabled) ...[
                  Text('채권 비중 (%) : ${state.bondRatio.toString()}'),
                  Slider(
                    value: state.bondRatio.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: state.bondRatio.toString(),
                    onChanged: (value) {
                      bloc.add(BondRatioChanged(value.round()));
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
