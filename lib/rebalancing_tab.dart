import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_rebalance/extensions.dart';
import 'package:stock_rebalance/portfolio_tab.dart'; // 예: int.toNumberFormat() 확장 함수

part 'rebalancing_tab.freezed.dart';

///────────────────────────────
/// 도메인 로직: 리벨런싱 계산 결과 모델 및 함수
///────────────────────────────

class RebalanceResult {
  final double cashAdjustmentAmount;
  final double stockAdjustmentAmount;
  final double bondAdjustmentAmount;
  final double? individualAdjustment;
  final double? indexAdjustment;

  RebalanceResult({
    required this.cashAdjustmentAmount,
    required this.stockAdjustmentAmount,
    required this.bondAdjustmentAmount,
    required this.individualAdjustment,
    required this.indexAdjustment,
  });
}

/// 리벨런싱 계산 로직을 분리한 함수
RebalanceResult calculateRebalance(RebalancingState state) {
  double totalInvestment = state.totalInvestment.toDouble();
  double currentStockValue = state.currentStockValue.toDouble();
  double currentBondValue = state.currentBondValue.toDouble();
  double cashRatio = state.cashRatio.toRatioFormat();
  double stockRatio = state.stockRatio.toRatioFormat();
  double bondRatio = state.bondRatio.toRatioFormat();
  double individualStockRatio = state.individualStockRatio.toRatioFormat();
  double indexStockRatio = state.indexStockRatio.toRatioFormat();
  double currentIndexValue = state.currentIndexValue.toRatioFormat();

  // 계산 현금 변수
  double pastCashAmount =
      totalInvestment * (((cashRatio + bondRatio)) / stockRatio);
  double afterCashAmount = ((pastCashAmount + currentStockValue)) * cashRatio;
  double rebalanceCashAmount = afterCashAmount - pastCashAmount;

  print(
      "pastCashAmount: $pastCashAmount, afterCashAmount: $afterCashAmount , rebalanceCashAmount: $rebalanceCashAmount");

  // 게산 주식 변수
  double pastStockAmount = totalInvestment;
  double afterStockAmount = (pastCashAmount + currentStockValue) * stockRatio;
  double rebalanceStockAmount = afterStockAmount - pastStockAmount;
  print(
      "pastStockAmount: $pastStockAmount, afterStockAmount: $afterStockAmount , rebalanceStockAmount: $rebalanceStockAmount");

  //====== 세부 설정 시 계산
  double pastIndividualStockAmount = totalInvestment * individualStockRatio;
  double pastIndexStockAmount = totalInvestment * indexStockRatio;

  double afterIndividualStockAmount = afterStockAmount * individualStockRatio;
  double afterIndexStockAmount = afterStockAmount * individualStockRatio;

  final double individualAdjustment =
      (afterStockAmount - totalInvestment) * individualStockRatio;
  final double indexAdjustment =
      (afterStockAmount - totalInvestment) * indexStockRatio;

  // 계산 채권 변수
  double pastBondAmount = totalInvestment * bondRatio;
  double afterBondAmount = (pastCashAmount + currentStockValue) * bondRatio;
  double rebalanceBondAmount = afterBondAmount - pastBondAmount;
  print(
      "pastBondAmount: $pastBondAmount, afterBondAmount: $afterBondAmount , rebalanceBondAmount: $rebalanceBondAmount");

  return RebalanceResult(
    cashAdjustmentAmount: rebalanceCashAmount,
    stockAdjustmentAmount: rebalanceStockAmount,
    bondAdjustmentAmount: rebalanceBondAmount,
    individualAdjustment: state.isStockDetailOn ? individualAdjustment : null,
    indexAdjustment: state.isStockDetailOn ? indexAdjustment : null,
  );
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

// 추가: 세부 설정 관련 이벤트
class CurrentIndexValueChanged extends RebalancingEvent {
  final int currentIndexValue;

  CurrentIndexValueChanged(this.currentIndexValue);
}

@freezed
class RebalancingState with _$RebalancingState {
  factory RebalancingState({
    @Default(0) int totalInvestment,
    @Default(0) int currentStockValue,
    @Default(0) int currentBondValue,
    @Default(0) int currentIndexValue, // 추가: 현재 지수 평가 금액
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
      int bondRatio = state.isBondEvaluationEnabled ? 0 : state.bondRatio;
      emit(state.copyWith(
        isBondEvaluationEnabled: !state.isBondEvaluationEnabled,
        bondRatio: bondRatio,
      ));
    });

    on<CurrentIndexValueChanged>((event, emit) {
      emit(state.copyWith(currentIndexValue: event.currentIndexValue));
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
                var totalRatio =
                    state.stockRatio + state.cashRatio + state.bondRatio;
                if (totalRatio != 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('총 비중이 100% 이어야 합니다.')));
                  return;
                }
                RebalanceResult result = calculateRebalance(state);
                String overallText =
                    '전체 리벨런싱 결과: 주식을 ${result.stockAdjustmentAmount.abs().toNumberFormat()}원 만큼 ${result.stockAdjustmentAmount > 0 ? '매도' : '매수'} 하세요.';
                // TODO: 개별 주식 & 인덱스 주식 정보 필요
                String detailText = '';
                if (result.individualAdjustment != null &&
                    result.indexAdjustment != null) {
                  detailText =
                      '\n개별 주식: ${result.individualAdjustment!.abs().toNumberFormat()}원 ${result.individualAdjustment! > 0 ? '매도' : '매수'}'
                      '\n지수 주식: ${result.indexAdjustment!.abs().toNumberFormat()}원 ${result.indexAdjustment! > 0 ? '매도' : '매수'}';
                }
                // PortfolioBloc에 계산 결과 전달 (PortfolioItem 생성 후 add 이벤트 발행)
                final portfolioItem = PortfolioItem.create(
                  rebalanceAmount: result.stockAdjustmentAmount,
                  // TODO: 현금, 개별주식, 인덱스 등의 정보 추가
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

  // 추가: 세부 설정 관련 컨트롤러들
  late MoneyMaskedTextController totalIndexPurchaseController;
  late MoneyMaskedTextController currentIndexValueController;

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
    totalIndexPurchaseController = MoneyMaskedTextController(
      decimalSeparator: '',
      thousandSeparator: ',',
      precision: 0,
      initialValue: 0,
    );
    currentIndexValueController = MoneyMaskedTextController(
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
    totalIndexPurchaseController.dispose();
    currentIndexValueController.dispose();
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
            // 총 매수 원금 금액 입력 (Tooltip 사용)
            TextField(
              controller: totalInvestmentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '총 매수 원금 금액',
                suffixIcon: Tooltip(
                  message: '총 매수 원금 = 주식+채권 전체 매수 당시 금액',
                  child: Icon(Icons.help_outline, size: 16),
                ),
              ),
              onChanged: (value) {
                bloc.add(
                  TotalInvestmentChanged(totalInvestmentController.intValue),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  // 현재 주식 평가 금액 입력 (Tooltip 사용)
                  child: TextField(
                    controller: currentStockValueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '현재 주식 평가 금액',
                      suffixIcon: Tooltip(
                        message: '아직 미정인 내용',
                        child: Icon(Icons.help_outline, size: 16),
                      ),
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
                        const Text('세부 설정'),
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
            // 세부 설정이 켜지면 추가 입력 필드 표시
            BlocBuilder<RebalancingBloc, RebalancingState>(
              builder: (context, state) {
                if (state.isStockDetailOn) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        controller: currentIndexValueController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: '현재 지수 평가 금액',
                        ),
                        onChanged: (value) {
                          bloc.add(CurrentIndexValueChanged(
                              currentIndexValueController.intValue));
                        },
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
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
                        decoration: const InputDecoration(
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
                const SizedBox(width: 10),
                BlocBuilder<RebalancingBloc, RebalancingState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        const Text('채권 사용'),
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
                const SizedBox(width: 10),
              ],
            ),
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
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<RebalancingBloc, RebalancingState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '리벨런싱 비중 입력',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                Text('총 주식 비중 (%) : ${state.stockRatio.toString()}'),
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
                  const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
